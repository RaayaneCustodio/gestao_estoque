class Product {
  final String id;
  String nomeProduto;
  int quantidade;
  double preco;
  String? supplierId;

  Product({
    required this.id,
    required this.nomeProduto,
    required this.quantidade,
    required this.preco,
    this.supplierId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      nomeProduto: json['nomeProduto'] ?? '',
      quantidade: (json['quantidade'] as num?)?.toInt() ?? 0,
      preco: (json['preco'] as num?)?.toDouble() ?? 0.0,
      supplierId: _relationId(json['supplierId']),
    );
  }

  static String? _relationId(dynamic value) {
    if (value == null || value == '') return null;
    if (value is String) return value;
    if (value is List && value.isNotEmpty) return value.first.toString();
    return value.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'nomeProduto': nomeProduto,
      'quantidade': quantidade,
      'preco': preco,
      'supplierId': supplierId,
    };
  }
}
