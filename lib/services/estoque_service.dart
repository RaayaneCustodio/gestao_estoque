import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gestao_estoque/services/api_config.dart';
import 'package:gestao_estoque/services/pocketbase_client.dart';

class EstoqueService {

  Future<void> enviarEntradaHttp(String produtoId, int quantidade) async {
   
    final url = Uri.parse('${ApiConfig.baseUrl}/api/v1/processar-entrada');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'produto_id': produtoId,
          'quantidade': quantidade,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> dadosRetornados = jsonDecode(response.body);
        print('Sucesso: ${dadosRetornados['mensagem']}');
      } else {
        final Map<String, dynamic> erroRetornado = jsonDecode(response.body);
        print('Erro do Servidor (${response.statusCode}): ${erroRetornado['mensagem']}');
      }
    } catch (e) {
      print('Falha na conexão com a API: $e');
    }
  }

  Future<void> registrarMovimentacao(String produtoId, int quantidade, String tipo, {String? imagePath, String? customerId, String? supplierId}) async {
    try {
      final body = {
        'product_id': produtoId,
        'quantidade': quantidade,
        'tipo': tipo,
        if (customerId != null && customerId.isNotEmpty) 'customer_id': customerId,
        if (supplierId != null && supplierId.isNotEmpty) 'supplier_id': supplierId,
      };

      List<http.MultipartFile> files = [];
      if (imagePath != null && imagePath.isNotEmpty) {
        files.add(await http.MultipartFile.fromPath('recibo', imagePath));
      }

      final record = await pocketBaseClient.collection('stock_entries').create(
        body: body,
        files: files,
      );
      
    } catch (e) {
      print('Erro ao registrar movimentação no PocketBase: $e');
      rethrow;
    }
  }
}
