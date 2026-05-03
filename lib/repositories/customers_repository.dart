import 'dart:collection';
import 'package:gestao_estoque/models/customers.dart';

class CustomersRepository {
  final List<Customers> _customersList = [];

  int getNextId() {
    if (_customersList.isEmpty) return 1;
    final maxId = _customersList.map((e) => e.id).reduce((a, b) => a > b ? a : b);
    return maxId + 1;
  }

  UnmodifiableListView<Customers> get customers =>
      UnmodifiableListView(_customersList);

  void addCustomers(String nome, String telefone, String email) {
    final newCustomers = Customers(
      id: getNextId(),
      nome: nome,
      telefone: telefone,
      email: email,
    );
    _customersList.add(newCustomers);
  }

  Future<List<Customers>> loadCustomers() async {
    await Future.delayed(const Duration(seconds: 1));
    return customers;
  }

  void removeCustomers(int id) {
    _customersList.removeWhere((customers) => customers.id == id);
  }

  void updateCustomers(int id, String newNome, String newTelefone, String newEmail) {
    final index = _customersList.indexWhere((customers) => customers.id == id);
    if (index != -1) {
      _customersList[index].nome = newNome;
      _customersList[index].telefone = newTelefone;
      _customersList[index].email = newEmail;
    }
  }
}
