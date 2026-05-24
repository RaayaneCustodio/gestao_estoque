class Sale {
  final String id;
  String customerId;
  String productId;
  int quantidade;
  double precoUnitario;
  DateTime data;

  Sale({
    required this.id,
    required this.customerId,
    required this.productId,
    required this.quantidade,
    required this.precoUnitario,
    required this.data,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    final created = json['created'] ?? json['data'];
    return Sale(
      id: json['id'] ?? '',
      customerId: json['customer_id'] ?? json['customerId'] ?? '',
      productId: json['product_id'] ?? json['productId'] ?? '',
      quantidade: (json['quantidade'] as num?)?.toInt() ?? 0,
      precoUnitario: (json['precoUnitario'] as num?)?.toDouble() ?? 0.0,
      data: created != null ? DateTime.parse(created.toString()) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'product_id': productId,
      'quantidade': quantidade,
      'precoUnitario': precoUnitario,
    };
  }
}
