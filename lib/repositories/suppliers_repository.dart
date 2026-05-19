import 'package:pocketbase/pocketbase.dart';
import 'package:gestao_estoque/models/suppliers.dart';

class SuppliersRepository {
  // Inicializa o cliente do PocketBase apontando para o seu servidor local
  final PocketBase pb = PocketBase('http://127.0.0.1:8090');

  List<Suppliers> _cachedSuppliers = [];

  // Mantido para compatibilidade síncrona com as telas atuais
  List<Suppliers> get suppliers => List<Suppliers>.unmodifiable(_cachedSuppliers);

  // Busca todos os fornecedores direto da coleção do PocketBase
  Future<List<Suppliers>> loadSuppliers() async {
    try {
      final records = await pb.collection('suppliers').getFullList();
      
      _cachedSuppliers = records.map((record) => Suppliers.fromJson(record.toJson())).toList();
      return _cachedSuppliers;
    } catch (e) {
      print("Erro ao carregar fornecedores do PocketBase: $e");
      return [];
    }
  }

  // Adiciona um novo fornecedor na coleção 'suppliers'
  Future<void> addSuppliers(String nome, String telefone, String email) async {
    try {
      final body = {
        'nome': nome,
        'telefone': telefone,
        'email': email,
      };

      await pb.collection('suppliers').create(body: body);
    } catch (e) {
      print("Erro ao adicionar fornecedor no PocketBase: $e");
    }
  }

  // Remove o fornecedor pelo ID de String gerado pelo PocketBase
  Future<void> removeSuppliers(String id) async {
    try {
      await pb.collection('suppliers').delete(id);
    } catch (e) {
      print("Erro ao remover fornecedor no PocketBase: $e");
    }
  }

  // Atualiza os dados de um fornecedor existente usando o ID de String
  Future<void> updateSuppliers(String id, String newNome, String newTelefone, String newEmail) async {
    try {
      final body = {
        'nome': newNome,
        'telefone': newTelefone,
        'email': newEmail,
      };

      await pb.collection('suppliers').update(id, body: body);
    } catch (e) {
      print("Erro ao atualizar fornecedor no PocketBase: $e");
    }
  }
}