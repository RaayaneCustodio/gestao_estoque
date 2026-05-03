import 'dart:collection';
import 'package:gestao_estoque/models/sale.dart';

class SaleRepository {
  final List<Sale> _salesList = [];

  int getNextId() {
    if (_salesList.isEmpty) return 1;
    final maxId = _salesList.map((e) => e.id).reduce((a, b) => a > b ? a : b);
    return maxId + 1;
  }

  UnmodifiableListView<Sale> get sales => UnmodifiableListView(_salesList);

  void addSale(int customerId, int productId, int quantidade, double precoUnitario) {
    final newSale = Sale(
      id: getNextId(),
      customerId: customerId,
      productId: productId,
      quantidade: quantidade,
      precoUnitario: precoUnitario,
      data: DateTime.now(),
    );
    _salesList.add(newSale);
  }

  Future<List<Sale>> loadSales() async {
    await Future.delayed(const Duration(seconds: 1));
    return sales;
  }

  List<Sale> salesByCustomer(int customerId) {
    return _salesList.where((sale) => sale.customerId == customerId).toList();
  }
}
