import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/products.dart';
import 'package:gestao_estoque/repositories/products_repository.dart';

class ProductsViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<Product> products = [];
  final ProductsRepository productsRepository;
  String feedback = '';

  ProductsViewModel({required this.productsRepository});

 
  void load() async {
    isLoading = true;
    feedback = '';
    notifyListeners();

    products = await productsRepository.loadProducts();
    isLoading = false;
    notifyListeners();
  }


  void saveProduct(
    String name,
    int quantity,
    double price,
    int? supplierId
  ) {
    productsRepository.addProduct(
      name,
      quantity,
      price,
      supplierId
    );
    feedback = '$name foi salvo!';
    notifyListeners();
    load(); 
  }


  void removeProduct(Product product) {
    productsRepository.removeProduct(product.id);
    load();
  }


  void editProduct(Product product) {
    productsRepository.updateProduct(
      product.id,
      product.nomeProduto,
      product.quantidade,
      product.preco.toDouble(),
      product.supplierId,
    );
    load();
  }
}