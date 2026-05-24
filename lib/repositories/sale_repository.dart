import 'package:gestao_estoque/services/pocketbase_client.dart';
import 'package:gestao_estoque/models/sale.dart';
import 'package:pocketbase/pocketbase.dart';

class SaleRepository {
  SaleRepository({PocketBase? pb}) : _pb = pb ?? pocketBaseClient;

  final PocketBase _pb;

  List<Sale> _cachedSales = [];
  List<Sale> get sales => List<Sale>.unmodifiable(_cachedSales);

  Future<List<Sale>> loadSales() async {
    try {
      final records = await _pb.collection('sales').getFullList();
      _cachedSales = records.map((r) => Sale.fromJson(r.toJson())).toList();
      return _cachedSales;
    } catch (e) {
      print('Erro ao carregar vendas do PocketBase: $e');
      return [];
    }
  }

  Future<void> addSale(
    String customerId,
    String productId,
    int quantidade,
    double precoUnitario,
  ) async {
    await _pb.collection('sales').create(
      body: {
        'customer_id': customerId,
        'product_id': productId,
        'quantidade': quantidade,
        'precoUnitario': precoUnitario,
      },
    );
    await loadSales();
  }

  Future<List<Sale>> salesByCustomer(String customerId) async {
    try {
      final records = await _pb.collection('sales').getFullList(
        filter: 'customer_id = "$customerId"',
      );
      return records.map((r) => Sale.fromJson(r.toJson())).toList();
    } catch (e) {
      print('Erro ao filtrar vendas por cliente no PocketBase: $e');
      return [];
    }
  }
}
