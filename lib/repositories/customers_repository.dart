import 'package:gestao_estoque/services/pocketbase_client.dart';
import 'package:gestao_estoque/models/customers.dart';
import 'package:pocketbase/pocketbase.dart';

class CustomersRepository {
  CustomersRepository({PocketBase? pb}) : _pb = pb ?? pocketBaseClient;

  final PocketBase _pb;

  List<Customers> _cachedCustomers = [];
  List<Customers> get customers => List<Customers>.unmodifiable(_cachedCustomers);

  Future<List<Customers>> loadCustomers() async {
    try {
      final records = await _pb.collection('customers').getFullList();
      _cachedCustomers =
          records.map((r) => Customers.fromJson(r.toJson())).toList();
      return _cachedCustomers;
    } catch (e) {
      print('Erro ao carregar clientes do PocketBase: $e');
      return [];
    }
  }

  Future<void> addCustomers(String nome, String telefone, String email) async {
    await _pb.collection('customers').create(
      body: {'nome': nome, 'telefone': telefone, 'email': email},
    );
    await loadCustomers();
  }

  Future<void> removeCustomers(String id) async {
    await _pb.collection('customers').delete(id);
    await loadCustomers();
  }

  Future<void> updateCustomers(
    String id,
    String newNome,
    String newTelefone,
    String newEmail,
  ) async {
    await _pb.collection('customers').update(
      id,
      body: {'nome': newNome, 'telefone': newTelefone, 'email': newEmail},
    );
    await loadCustomers();
  }
}
