import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/customers.dart';
import 'package:gestao_estoque/repositories/customers_repository.dart';

class CustomersViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<Customers> customers = [];
  final CustomersRepository customersRepository;
  String feedback = '';

  CustomersViewModel({required this.customersRepository});

  void load() async {
    isLoading = true;
    feedback = '';
    notifyListeners();

    customers = await customersRepository.loadCustomers();
    isLoading = false;
    notifyListeners();
  }

  void saveCustomers(String nome, String telefone, String email) {
    customersRepository.addCustomers(nome, telefone, email);
    feedback = '$nome foi salvo!';
    notifyListeners();
    load();
  }

  void removeCustomers(Customers customers) {
    customersRepository.removeCustomers(customers.id);
    load();
  }

  void editCustomers(Customers customers) {
    customersRepository.updateCustomers(
      customers.id,
      customers.nome,
      customers.telefone,
      customers.email,
    );
    load();
  }
}
