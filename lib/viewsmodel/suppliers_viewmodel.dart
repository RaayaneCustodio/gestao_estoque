import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/suppliers.dart';
import 'package:gestao_estoque/repositories/suppliers_repository.dart';

class SuppliersViewmodel extends ChangeNotifier {
  bool isLoading = false;
  List<Suppliers> suppliers = [];
  final SuppliersRepository suppliersRepository;
  String feedback = '';

  SuppliersViewmodel({required this.suppliersRepository});

  void load() async {
    isLoading = true;
    feedback = '';
    notifyListeners();

    suppliers = await suppliersRepository.loadSupplier();
    isLoading = false;
    notifyListeners();
  }

  void saveSuppliers(
    String supplierName,
    String supplierPhone,
    String supplierEmail,
  ) {
    suppliersRepository.addSuppliers(
      supplierName,
      supplierPhone,
      supplierEmail,
    );
    feedback = '$supplierName foi salvo!';
    notifyListeners();
    load();
  }

  void removeSupplier(Suppliers supplier) {
    suppliersRepository.removeSupplier(supplier.id);
    load();
  }

  void editSupplier(Suppliers supplier) {
    suppliersRepository.updateSupplier(
      supplier.id,
      supplier.nome,
      supplier.telefone,
      supplier.email,
    );
    load();
  }
}
