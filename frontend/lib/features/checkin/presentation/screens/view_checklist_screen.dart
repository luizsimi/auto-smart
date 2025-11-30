import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/authenticated_image_widget.dart';
import '../../../../core/widgets/photo_view_screen.dart';
import '../../../../core/theme/colors.dart';
import '../../model/checklist_model.dart';
import '../../../orcamentos/model/repository/orcamento_repository_impl.dart';

class ViewChecklistScreen extends StatefulWidget {
  final ChecklistModel checklist;
  final String vehicleTitle;
  final String clientName;

  const ViewChecklistScreen({
    super.key,
    required this.checklist,
    required this.vehicleTitle,
    required this.clientName,
  });

  @override
  State<ViewChecklistScreen> createState() => _ViewChecklistScreenState();
}

class _ViewChecklistScreenState extends State<ViewChecklistScreen> {
  final OrcamentoRepositoryImpl _orcamentoRepository = OrcamentoRepositoryImpl();
  String? _fotoVeiculo;
  bool _isLoadingFoto = true;

  @override
  void initState() {
    super.initState();
    _loadFotoVeiculo();
  }

  Future<void> _loadFotoVeiculo() async {
    try {
      final orcamento = await _orcamentoRepository.findOne(widget.checklist.orcamentoId);
      if (mounted) {
        setState(() {
          _fotoVeiculo = orcamento.fotoVeiculo;
          _isLoadingFoto = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingFoto = false;
        });
      }
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Data não disponível';
    final localDate = date.toLocal();
    final day = localDate.day.toString().padLeft(2, '0');
    final month = localDate.month.toString().padLeft(2, '0');
    final year = localDate.year;
    final hour = localDate.hour.toString().padLeft(2, '0');
    final minute = localDate.minute.toString().padLeft(2, '0');
    return '$day/$month/$year às $hour:$minute';
  }

  String _extractKm(String observacoes) {
    final kmMatch = RegExp(r'Quilometragem:\s*(\d+)\s*km').firstMatch(observacoes);
    return kmMatch?.group(1) ?? 'N/A';
  }

  String _extractObservacoes(String observacoes) {
    final parts = observacoes.split('\n\n');
    if (parts.length > 1) {
      return parts.sublist(1).join('\n\n');
    }
    return '';
  }

  Widget _buildImage(String path) {
    return AuthenticatedImageWidget(path: path);
  }

  @override
  Widget build(BuildContext context) {
    final isCheckin = widget.checklist.tipo.toUpperCase() == 'CHECK_IN';
    final km = _extractKm(widget.checklist.observacoes);
    final observacoes = _extractObservacoes(widget.checklist.observacoes);

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: const CustomAppBar(
        title: 'DETALHES',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _isLoadingFoto
                          ? Container(
                              color: AppColors.secondary,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                                ),
                              ),
                            )
                          : _fotoVeiculo != null && _fotoVeiculo!.isNotEmpty
                              ? AuthenticatedImageWidget(
                                  path: _fotoVeiculo!,
                                  fit: BoxFit.cover,
                                  isOrcamento: true,
                                  errorWidget: Container(
                                    color: AppColors.secondary,
                                    child: Icon(
                                      Icons.directions_car,
                                      color: isCheckin ? Colors.green : Colors.blue,
                                      size: 40,
                                    ),
                                  ),
                                )
                              : Container(
                                  color: AppColors.secondary,
                                  child: Icon(
                                    Icons.directions_car,
                                    color: isCheckin ? Colors.green : Colors.blue,
                                    size: 40,
                                  ),
                                ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.vehicleTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.clientName,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.speed,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Quilometragem',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$km km',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            if (observacoes.isNotEmpty) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.note_add,
                          color: AppColors.primary,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Observações',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      observacoes,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            if (widget.checklist.checklistItems.isNotEmpty) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.add_a_photo,
                          color: AppColors.primary,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Fotos do Veículo',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: widget.checklist.checklistItems.length,
                      itemBuilder: (context, index) {
                        final photo = widget.checklist.checklistItems[index];
                        return GestureDetector(
                          onTap: () {
                            final photoPaths = widget.checklist.checklistItems
                                .map((item) => item.path)
                                .toList();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PhotoViewScreen(
                                  photoPaths: photoPaths,
                                  initialIndex: index,
                                  isOrcamento: false,
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: _buildImage(photo.path),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Data e hora: ${_formatDate(widget.checklist.dataCriacao)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

