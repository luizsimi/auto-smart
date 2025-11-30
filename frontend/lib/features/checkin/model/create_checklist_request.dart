class CreateChecklistRequest {
  final int orcamentoId;
  final String tipo;
  final String observacoes;

  CreateChecklistRequest({
    required this.orcamentoId,
    required this.tipo,
    required this.observacoes,
  });

  Map<String, dynamic> toJson() {
    return {
      'orcamentoId': orcamentoId,
      'tipo': tipo.toUpperCase(),
      'observacoes': observacoes,
    };
  }
}

