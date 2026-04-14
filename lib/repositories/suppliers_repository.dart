import 'dart:collection';

import 'package:gestao_estoque/models/suppliers.dart';

class SuppliersRepository {
  int getNextId() {
    if (_suppliersList.isEmpty) return 1;

    final maxId = _suppliersList
        .map((e) => e.id)
        .reduce((a, b) => a > b ? a : b);

    return maxId + 1;
  }

  final List<Suppliers> _suppliersList = [];

  UnmodifiableListView<Suppliers> get suppliers =>
      UnmodifiableListView(_suppliersList);

  void addSuppliers(String nome, String telefone, String email) {
    final newSupplier = Suppliers(
      id: getNextId(),
      nome: nome,
      telefone: telefone,
      email: email,
    );

    _suppliersList.add(newSupplier);
  }

  Future<List<Suppliers>> loadSupplier() async {
    await Future.delayed(Duration(seconds: 2));
    return suppliers;
  }

  void removeSupplier(int id) {
    _suppliersList.removeWhere((supplier) => supplier.id == id);
  }

  void updateSupplier(
    int id,
    String newName,
    String newPhone,
    String newEmail,
  ) {
    final index = _suppliersList.indexWhere((supplier) => supplier.id == id);
    if (index != -1) {
      _suppliersList[index].nome = newName;
      _suppliersList[index].telefone = newPhone;
      _suppliersList[index].email = newEmail;
    }
  }
}
