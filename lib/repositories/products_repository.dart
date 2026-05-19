import 'package:pocketbase/pocketbase.dart';
import 'package:gestao_estoque/models/products.dart';

class ProductsRepository {

  final PocketBase pb = PocketBase('http://127.0.0.1:8090');

  List<Product> _cachedProducts = [];


  List<Product> get products => List<Product>.unmodifiable(_cachedProducts);


  Future<List<Product>> loadProducts() async {
    try {
      final records = await pb.collection('products').getFullList();
      

      _cachedProducts = records.map((record) => Product.fromJson(record.toJson())).toList();
      return _cachedProducts;
    } catch (e) {
      print("Erro ao carregar produtos do PocketBase: $e");
      return [];
    }
  }


  Future<void> addProduct(String name, int quantity, double price, String? supplierId) async {
    try {
      final body = {
        'nomeProduto': name,
        'quantidade': quantity,
        'preco': price,
        'supplierId': supplierId, 
      };

      await pb.collection('products').create(body: body);
    } catch (e) {
      print("Erro ao adicionar produto no PocketBase: $e");
    }
  }


  Future<void> removeProduct(String id) async {
    try {
      await pb.collection('products').delete(id);
    } catch (e) {
      print("Erro ao remover produto no PocketBase: $e");
    }
  }


  Future<void> updateProduct(
    String id, 
    String newName, 
    int newQuantity, 
    double newPrice, 
    String? newSupplierId,
  ) async {
    try {
      final body = {
        'nomeProduto': newName,
        'quantidade': newQuantity,
        'preco': newPrice,
        'supplierId': newSupplierId,
      };

      await pb.collection('products').update(id, body: body);
    } catch (e) {
      print("Erro ao atualizar produto no PocketBase: $e");
    }
  }
}