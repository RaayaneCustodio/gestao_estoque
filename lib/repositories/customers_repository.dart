import 'package:pocketbase/pocketbase.dart';
import 'package:gestao_estoque/models/customers.dart';

class CustomersRepository {
  final PocketBase pb = PocketBase('http://127.0.0.1:8090');

  List<Customers> _cachedCustomers = [];
  List<Customers> get customers => List<Customers>.unmodifiable(_cachedCustomers);

  Future<List<Customers>> loadCustomers() async {
    try {
      final records = await pb.collection('customers').getFullList();
      _cachedCustomers = records.map((record) => Customers.fromJson(record.toJson())).toList();
      return _cachedCustomers;
    } catch (e) {
      print("Erro ao carregar clientes do PocketBase: $e");
      return [];
    }
  }

  Future<void> addCustomers(String nome, String telefone, String email) async {
    try {
      final body = {
        'nome': nome,
        'telefone': telefone,
        'email': email,
      };
      await pb.collection('customers').create(body: body);
    } catch (e) {
      print("Erro ao adicionar cliente no PocketBase: $e");
    }
  }

  Future<void> removeCustomers(String id) async {
    try {
      await pb.collection('customers').delete(id);
    } catch (e) {
      print("Erro ao remover cliente no PocketBase: $e");
    }
  }

  Future<void> updateCustomers(String id, String newNome, String newTelefone, String newEmail) async {
    try {
      final body = {
        'nome': newNome,
        'telefone': newTelefone,
        'email': newEmail,
      };
      await pb.collection('customers').update(id, body: body);
    } catch (e) {
      print("Erro ao atualizar cliente no PocketBase: $e");
    }
  }
}