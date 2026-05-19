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
    return Sale(
      id: json['id'] ?? '',
      customerId: json['customerId'] ?? '',
      productId: json['productId'] ?? '',
      quantidade: (json['quantidade'] ?? 0) as int,
      precoUnitario: (json['precoUnitario'] ?? 0.0).toDouble(),
      data: json['data'] != null ? DateTime.parse(json['data']) : DateTime.now(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'productId': productId,
      'quantidade': quantidade,
      'precoUnitario': precoUnitario,
      'data': data.toIso8601String(),
    };
  }
}