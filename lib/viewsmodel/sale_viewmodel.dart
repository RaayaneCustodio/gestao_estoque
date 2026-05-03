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

  void load() async {
    isLoading = true;
    feedback = '';
    notifyListeners();

    sales = await saleRepository.loadSales();
    isLoading = false;
    notifyListeners();
  }

  bool registrarSaida(int customerId, int productId, int quantidade) {
    final product = productsRepository.products.firstWhere(
      (p) => p.id == productId,
    );

    if (product.quantidade < quantidade) {
      feedback = 'Estoque insuficiente!';
      notifyListeners();
      return false;
    }

    productsRepository.updateProduct(
      product.id,
      product.nomeProduto,
      product.quantidade - quantidade,
      product.preco,
      product.supplierId,
    );

    saleRepository.addSale(
      customerId,
      productId,
      quantidade,
      product.preco,
    );

    feedback = 'Saída registrada com sucesso!';
    notifyListeners();
    load();
    return true;
  }

  List<Sale> vendasDoCliente(int customerId) {
    return saleRepository.salesByCustomer(customerId);
  }
}
