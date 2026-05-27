import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/customers.dart';
import 'package:gestao_estoque/repositories/customers_repository.dart';

class CustomersViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<Customers> customers = [];
  final CustomersRepository customersRepository;
  String feedback = '';

  CustomersViewModel({required this.customersRepository});

  void load() {
    isLoading = true;
    feedback = '';
    notifyListeners();

    customersRepository.loadCustomers().then((list) {
      customers = list;
      isLoading = false;
      notifyListeners();
    });
  }

  void saveCustomers(String nome, String telefone, String email) {
    customersRepository.addCustomers(nome, telefone, email).then((_) {
      feedback = '$nome foi salvo!';
      notifyListeners();
      load();
    });
  }

  void removeCustomers(Customers customer) {
    customersRepository.removeCustomers(customer.id).then((_) {
      notifyListeners();
      load();
    });
  }

  void editCustomers(Customers customer) {
    customersRepository.updateCustomers(
      customer.id,
      customer.nome,
      customer.telefone,
      customer.email,
    ).then((_) {
      notifyListeners();
      load();
    });
  }
}