import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/suppliers.dart';
import 'package:gestao_estoque/repositories/suppliers_repository.dart';

class SuppliersViewmodel extends ChangeNotifier {
  bool isLoading = false;
  List<Suppliers> suppliers = [];
  final SuppliersRepository suppliersRepository;
  String feedback = '';

  SuppliersViewmodel({required this.suppliersRepository});

  void load() {
    isLoading = true;
    feedback = '';
    notifyListeners();

    suppliersRepository.loadSuppliers().then((list) {
      suppliers = list;
      isLoading = false;
      notifyListeners();
    });
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
    ).then((_) {
      feedback = '$supplierName foi salvo!';
      notifyListeners();
      load();
    });
  }

  void removeSupplier(Suppliers supplier) {
    suppliersRepository.removeSuppliers(supplier.id).then((_) {
      notifyListeners();
      load();
    });
  }

  void editSupplier(Suppliers supplier) {
    suppliersRepository.updateSuppliers(
      supplier.id,
      supplier.nome,
      supplier.telefone,
      supplier.email,
    ).then((_) {
      notifyListeners();
      load();
    });
  }
}