class Product {
  int id;
  String nomeProduto;
  int quantidade;
  double preco;
  int? supplierId; 

  Product({
    required this.id,
    required this.nomeProduto,
    required this.quantidade,
    required this.preco,
    this.supplierId, 
  });
}
