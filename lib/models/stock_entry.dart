class StockEntry {
  final String id;
  final String productId;
  final int quantidade;
  final String tipo; 
  final String? recibo;
  final DateTime? created;

  StockEntry({
    required this.id,
    required this.productId,
    required this.quantidade,
    required this.tipo,
    this.recibo,
    this.created,
  });

  factory StockEntry.fromJson(Map<String, dynamic> json) {
    return StockEntry(
      id: json['id'] ?? '',
      productId: json['product_id'] ?? '',
      quantidade: (json['quantidade'] as num?)?.toInt() ?? 0,
      tipo: json['tipo'] ?? 'entrada',
      recibo: json['recibo'] as String?,
      created: json['created'] != null ? DateTime.tryParse(json['created']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantidade': quantidade,
      'tipo': tipo,
    };
  }
}
