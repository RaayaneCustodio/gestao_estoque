import 'package:gestao_estoque/services/pocketbase_client.dart';
import 'package:gestao_estoque/models/suppliers.dart';
import 'package:pocketbase/pocketbase.dart';

class SuppliersRepository {
  SuppliersRepository({PocketBase? pb}) : _pb = pb ?? pocketBaseClient;

  final PocketBase _pb;

  List<Suppliers> _cachedSuppliers = [];
  List<Suppliers> get suppliers => List<Suppliers>.unmodifiable(_cachedSuppliers);

  Future<List<Suppliers>> loadSuppliers() async {
    try {
      final records = await _pb.collection('suppliers').getFullList();
      _cachedSuppliers =
          records.map((r) => Suppliers.fromJson(r.toJson())).toList();
      return _cachedSuppliers;
    } catch (e) {
      print('Erro ao carregar fornecedores do PocketBase: $e');
      return [];
    }
  }

  Future<void> addSuppliers(String nome, String telefone, String email) async {
    await _pb.collection('suppliers').create(
      body: {'nome': nome, 'telefone': telefone, 'email': email},
    );
    await loadSuppliers();
  }

  Future<void> removeSuppliers(String id) async {
    await _pb.collection('suppliers').delete(id);
    await loadSuppliers();
  }

  Future<void> updateSuppliers(
    String id,
    String newNome,
    String newTelefone,
    String newEmail,
  ) async {
    await _pb.collection('suppliers').update(
      id,
      body: {'nome': newNome, 'telefone': newTelefone, 'email': newEmail},
    );
    await loadSuppliers();
  }
}
