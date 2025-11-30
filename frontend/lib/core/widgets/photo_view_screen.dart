import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/colors.dart';
import '../../features/checkin/model/repository/checklist_repository_impl.dart';
import '../../features/orcamentos/model/repository/orcamento_repository_impl.dart';

class PhotoViewScreen extends StatefulWidget {
  final List<String>? photoPaths;
  final List<XFile>? localImages;
  final int initialIndex;
  final bool isOrcamento;

  const PhotoViewScreen({
    super.key,
    this.photoPaths,
    this.localImages,
    this.initialIndex = 0,
    this.isOrcamento = false,
  }) : assert(
          (photoPaths != null && localImages == null) ||
              (photoPaths == null && localImages != null),
          'Either photoPaths or localImages must be provided, but not both',
        );

  @override
  State<PhotoViewScreen> createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  late PageController _pageController;
  late int _currentIndex;
  final Map<int, Uint8List> _loadedImages = {};

  bool get _isLocalImages => widget.localImages != null;
  int get _itemCount => _isLocalImages
      ? widget.localImages!.length
      : widget.photoPaths!.length;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    if (!_isLocalImages) {
      _preloadImages();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> _preloadImages() async {
    if (_isLocalImages) return;
    for (int i = 0; i < widget.photoPaths!.length; i++) {
      _loadImage(i);
    }
  }

  Future<void> _loadImage(int index) async {
    if (_loadedImages.containsKey(index)) return;
    if (_isLocalImages) return;

    try {
      final String imageUrl;
      if (widget.isOrcamento) {
        final repository = OrcamentoRepositoryImpl();
        imageUrl = repository.getOrcamentoPhotoUrl(widget.photoPaths![index]);
      } else {
        final repository = ChecklistRepositoryImpl();
        imageUrl = repository.getChecklistPhotoUrl(widget.photoPaths![index]);
      }

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      final headers = <String, String>{};
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await http.get(
        Uri.parse(imageUrl),
        headers: headers,
      );

      if (response.statusCode == 200 && mounted) {
        setState(() {
          _loadedImages[index] = response.bodyBytes;
        });
      }
    } catch (e) {
      // Ignore errors, will show placeholder
    }
  }

  Future<Uint8List> _getLocalImageBytes(int index) async {
    if (!_isLocalImages) throw StateError('Not local images');
    final image = widget.localImages![index];
    if (kIsWeb) {
      return await image.readAsBytes();
    } else {
      final file = File(image.path);
      return await file.readAsBytes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_currentIndex + 1} / $_itemCount',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Flexible(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _itemCount,
              itemBuilder: (context, index) {
                return _buildPhotoView(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoView(int index) {
    if (_isLocalImages) {
      return FutureBuilder<Uint8List>(
        future: _getLocalImageBytes(index),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Image.memory(
                    snapshot.data!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          }
          return Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        },
      );
    }

    if (!_loadedImages.containsKey(index)) {
      _loadImage(index);
      return Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 3,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.memory(
            _loadedImages[index]!,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
