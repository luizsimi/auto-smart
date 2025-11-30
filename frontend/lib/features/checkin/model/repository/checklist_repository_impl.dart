import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../checklist_model.dart';
import '../checklist_photo_model.dart';
import 'checklist_repository.dart';

const String _envApiBaseUrl =
    String.fromEnvironment('API_BASE_URL', defaultValue: '');

String _resolveDefaultBaseUrl() {
  if (_envApiBaseUrl.isNotEmpty) {
    return _envApiBaseUrl;
  }

  if (kIsWeb) {
    return 'http://127.0.0.1:3000';
  }

  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return 'http://10.0.2.2:3000';
    default:
      return 'http://127.0.0.1:3000';
  }
}

class ChecklistRepositoryImpl implements ChecklistRepository {
  ChecklistRepositoryImpl({
    http.Client? client,
    String? baseUrl,
  })  : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? _resolveDefaultBaseUrl();

  final http.Client _client;
  final String _baseUrl;

  static const String _tokenKey = 'access_token';

  Uri _buildUri(String path, [Map<String, String>? params]) {
    return Uri.parse('$_baseUrl$path').replace(queryParameters: params);
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<Map<String, String>> _buildHeaders({
    bool includeContentType = true,
    String? contentType,
  }) async {
    final token = await _getToken();
    final headers = <String, String>{};

    if (includeContentType) {
      headers['Content-Type'] = contentType ?? 'application/json';
    }

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  @override
  Future<ChecklistModel> createChecklist(
    int orcamentoId,
    String tipo,
    String observacoes,
    List<XFile> fotos,
  ) async {
    final uri = _buildUri('/checklist');
    final token = await _getToken();

    if (token == null || token.isEmpty) {
      throw Exception('Usuário não autenticado');
    }

    final request = http.MultipartRequest('POST', uri);

    request.headers['Authorization'] = 'Bearer $token';

    request.fields['orcamentoId'] = orcamentoId.toString();
    request.fields['tipo'] = tipo.toUpperCase();
    request.fields['observacoes'] = observacoes;

    for (final foto in fotos) {
      final bytes = await foto.readAsBytes();
      final multipartFile = http.MultipartFile.fromBytes(
        'files',
        bytes,
        filename: foto.name.isNotEmpty ? foto.name : 'foto.jpg',
      );
      request.files.add(multipartFile);
    }

    final streamedResponse = await _client.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {
      final errorBody = jsonDecode(response.body);
      final errorMessage = errorBody is Map<String, dynamic>
          ? (errorBody['message'] ?? errorBody['error'] ?? response.body)
          : response.body;
      throw Exception('Erro ao criar checklist: ${response.statusCode} - $errorMessage');
    }

    final dynamic decoded = jsonDecode(response.body);
    if (decoded is Map<String, dynamic>) {
      return ChecklistModel.fromJson(decoded);
    }

    throw Exception('Formato inesperado da resposta ao criar checklist');
  }

  @override
  Future<List<ChecklistModel>> findByOrcamentoId(int orcamentoId) async {
    final uri = _buildUri('/checklist/orcamento/$orcamentoId');
    final response = await _client.get(uri, headers: await _buildHeaders());

    if (response.statusCode != 200) {
      throw Exception(
        'Erro ao buscar checklists: ${response.statusCode} ${response.reasonPhrase}',
      );
    }

    final dynamic decoded = jsonDecode(response.body);
    if (decoded is List) {
      return decoded
          .map((item) =>
              ChecklistModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    throw Exception('Formato inesperado da resposta de /checklist/orcamento/$orcamentoId');
  }

  @override
  String getChecklistPhotoUrl(String nomeFoto) {
    return '$_baseUrl/checklist/$nomeFoto/foto';
  }
}

