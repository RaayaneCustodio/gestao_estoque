import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/products.dart';
import 'package:gestao_estoque/repositories/products_repository.dart';

class ProductsViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<Product> products = [];
  final ProductsRepository productsRepository;
  String feedback = '';

  ProductsViewModel({required this.productsRepository});

  void load() {
    isLoading = true;
    feedback = '';
    notifyListeners();

    productsRepository.loadProducts().then((list) {
      products = list;
      isLoading = false;
      notifyListeners();
    });
  }

  void saveProduct(
    String name,
    int quantity,
    double price,
    String? supplierId,
    {String? imagePath}
  ) {
    productsRepository.addProduct(name, quantity, price, supplierId, imagePath: imagePath).then((_) {
      feedback = '$name foi salvo!';
      notifyListeners();
      load();
    });
  }

  Future<String?> removeProduct(Product product) async {
    try {
      await productsRepository.removeProduct(product.id);
      notifyListeners();
      load();
      return null;
    } catch (e) {
      return 'O produto possui histórico de movimentação/venda e não pode ser excluído.';
    }
  }

  void editProduct(Product product, {String? imagePath}) {
    productsRepository.updateProduct(
      product.id,
      product.nomeProduto,
      product.quantidade,
      product.preco,
      product.supplierId,
      imagePath: imagePath,
    ).then((_) {
      notifyListeners();
      load();
    });
  }
}