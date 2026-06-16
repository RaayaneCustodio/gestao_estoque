import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/sale.dart';
import 'package:gestao_estoque/repositories/products_repository.dart';
import 'package:gestao_estoque/repositories/sale_repository.dart';

class SaleViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<Sale> sales = [];
  String feedback = '';

  final SaleRepository saleRepository;
  final ProductsRepository productsRepository;

  SaleViewModel({
    required this.saleRepository,
    required this.productsRepository,
  });

  void load() {
    isLoading = true;
    feedback = '';
    notifyListeners();

    saleRepository.loadSales().then((list) {
      sales = list;
      isLoading = false;
      notifyListeners();
    });
  }

  Future<bool> registrarSaida(
    String customerId,
    String productId,
    int quantidade,
  ) async {
    final product = productsRepository.products
        .where((p) => p.id == productId)
        .firstOrNull;

    if (product == null) {
      feedback = 'Produto não encontrado.';
      notifyListeners();
      return false;
    }

    if (product.quantidade < quantidade) {
      feedback = 'Estoque insuficiente!';
      notifyListeners();
      return false;
    }

    try {
      await productsRepository.updateProduct(
        product.id,
        product.nomeProduto,
        product.quantidade - quantidade,
        product.preco,
        product.supplierId,
      );

      await saleRepository.addSale(
        customerId,
        productId,
        quantidade,
        product.preco,
      );
    } catch (e) {
      feedback = 'Erro ao registrar: $e';
      notifyListeners();
      return false;
    }

    feedback = 'Saída registrada com sucesso!';
    notifyListeners();
    load();
    return true;
  }

  List<Sale> vendasDoCliente(String customerId) {
    notifyListeners();
    return sales.where((s) => s.customerId == customerId).toList();
  }
}
