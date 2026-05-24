import 'package:gestao_estoque/services/pocketbase_client.dart';
import 'package:gestao_estoque/models/products.dart';
import 'package:pocketbase/pocketbase.dart';

class ProductsRepository {
  ProductsRepository({PocketBase? pb}) : _pb = pb ?? pocketBaseClient;

  final PocketBase _pb;

  List<Product> _cachedProducts = [];
  List<Product> get products => List<Product>.unmodifiable(_cachedProducts);

  Future<List<Product>> loadProducts() async {
    try {
      final records = await _pb.collection('products').getFullList();
      _cachedProducts =
          records.map((r) => Product.fromJson(r.toJson())).toList();
      return _cachedProducts;
    } catch (e) {
      print('Erro ao carregar produtos do PocketBase: $e');
      return [];
    }
  }

  Future<void> addProduct(
    String name,
    int quantity,
    double price,
    String? supplierId,
  ) async {
    await _pb.collection('products').create(
      body: {
        'nomeProduto': name,
        'quantidade': quantity,
        'preco': price,
        if (supplierId != null) 'supplierId': supplierId,
      },
    );
    await loadProducts();
  }

  Future<void> removeProduct(String id) async {
    await _pb.collection('products').delete(id);
    await loadProducts();
  }

  Future<void> updateProduct(
    String id,
    String newName,
    int newQuantity,
    double newPrice,
    String? newSupplierId,
  ) async {
    await _pb.collection('products').update(
      id,
      body: {
        'nomeProduto': newName,
        'quantidade': newQuantity,
        'preco': newPrice,
        'supplierId': newSupplierId,
      },
    );
    await loadProducts();
  }
}
