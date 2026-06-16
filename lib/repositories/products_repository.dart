import 'package:gestao_estoque/services/pocketbase_client.dart';
import 'package:gestao_estoque/models/products.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

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
    {String? imagePath}
  ) async {
    final body = {
      'nomeProduto': name,
      'quantidade': quantity,
      'preco': price,
      if (supplierId != null) 'supplierId': supplierId,
    };

    List<http.MultipartFile> files = [];
    if (imagePath != null && imagePath.isNotEmpty) {
      files.add(await http.MultipartFile.fromPath('imagemProduto', imagePath));
    }

    await _pb.collection('products').create(body: body, files: files);
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
    {String? imagePath}
  ) async {
    final body = {
      'nomeProduto': newName,
      'quantidade': newQuantity,
      'preco': newPrice,
      if (newSupplierId != null && newSupplierId.isNotEmpty) 'supplierId': newSupplierId,
    };

    List<http.MultipartFile> files = [];
    if (imagePath != null && imagePath.isNotEmpty) {
      files.add(await http.MultipartFile.fromPath('imagemProduto', imagePath));
    }

    await _pb.collection('products').update(id, body: body, files: files);
    await loadProducts();
  }
}
