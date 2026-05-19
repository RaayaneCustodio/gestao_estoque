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
      quantidade: (json['quantidade'] ?? 0) as int, 
      preco: (json['preco'] ?? 0.0).toDouble(), // Garante que vire double sem quebrar
      supplierId: json['supplierId'], // Pode vir nulo se não houver fornecedor
    );
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