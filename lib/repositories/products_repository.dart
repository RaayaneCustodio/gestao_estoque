import 'dart:collection';
import 'package:gestao_estoque/models/products.dart';

class ProductsRepository {
  final List<Product> _productsList = [];

  // Gera o próximo ID disponível
  int getNextId() {
    if (_productsList.isEmpty) return 1;

    final maxId = _productsList
        .map((e) => e.id)
        .reduce((a, b) => a > b ? a : b);

    return maxId + 1;
  }

  // Retorna uma lista que não pode ser modificada diretamente de fora
  UnmodifiableListView<Product> get products =>
      UnmodifiableListView(_productsList);

  // Adiciona um novo produto
  void addProduct(String name, int quantity, double price) {
    final newProduct = Product(
      id: getNextId(),
      nomeProduto: name,
      quantidade: quantity,
      preco: price.toInt(),
    );

    _productsList.add(newProduct);
  }


  Future<List<Product>> loadProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return products;
  }


  void removeProduct(int id) {
    _productsList.removeWhere((product) => product.id == id);
  }


  void updateProduct(int id, String newName, int newQuantity, double newPrice) {
    final index = _productsList.indexWhere((product) => product.id == id);
    if (index != -1) {
      _productsList[index].nomeProduto = newName;
      _productsList[index].quantidade = newQuantity;
      _productsList[index].preco = newPrice.toInt();
    }
  }
}