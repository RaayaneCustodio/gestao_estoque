import 'package:pocketbase/pocketbase.dart';
import 'package:gestao_estoque/models/sale.dart';

class SaleRepository {

  final PocketBase pb = PocketBase('http://127.0.0.1:8090');

  List<Sale> _cachedSales = [];


  List<Sale> get sales => List<Sale>.unmodifiable(_cachedSales);


  Future<List<Sale>> loadSales() async {
    try {
      final records = await pb.collection('sales').getFullList();
      
      _cachedSales = records.map((record) => Sale.fromJson(record.toJson())).toList();
      return _cachedSales;
    } catch (e) {
      print("Erro ao carregar vendas do PocketBase: $e");
      return [];
    }
  }

  Future<void> addSale(String customerId, String productId, int quantidade, double precoUnitario) async {
    try {
      final body = {
        'customerId': customerId,
        'productId': productId,   
        'quantidade': quantidade,
        'precoUnitario': precoUnitario,
        'data': DateTime.now().toIso8601String(), 
      };

      await pb.collection('sales').create(body: body);
    } catch (e) {
      print("Erro ao adicionar venda no PocketBase: $e");
    }
  }


  Future<List<Sale>> salesByCustomer(String customerId) async {
    try {
      final records = await pb.collection('sales').getFullList(
        filter: 'customerId = "$customerId"',
      );
      
      return records.map((record) => Sale.fromJson(record.toJson())).toList();
    } catch (e) {
      print("Erro ao filtrar vendas por cliente no PocketBase: $e");
      return [];
    }
  }
}