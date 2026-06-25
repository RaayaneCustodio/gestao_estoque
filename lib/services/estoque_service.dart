import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:gestao_estoque/services/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EstoqueService {

  Future<int> enviarEntradaHttp(
    String produtoId,
    int quantidade, {
    String? supplierId,
    String? imagePath,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/api/v1/processar-entrada');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'produto_id': produtoId,
        'quantidade': quantidade,
        if (supplierId != null && supplierId.isNotEmpty)
          'supplier_id': supplierId,
      }),
    );

    final Map<String, dynamic> dados = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(dados['mensagem'] ?? 'Erro ao processar entrada');
    }

    final String recordId = dados['record_id'];
    final int qtdAtual = (dados['quantidade_atual'] as num).toInt();

    if (imagePath != null && imagePath.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      final pbAuthJson = prefs.getString('pb_auth');
      String? token;
      if (pbAuthJson != null) {
        final decoded = jsonDecode(pbAuthJson);
        token = decoded['token'] as String?;
      }

      final patchUrl = Uri.parse(
        '${ApiConfig.baseUrl}/api/collections/stock_entries/records/$recordId',
      );
      final request = http.MultipartRequest('PATCH', patchUrl);
      if (token != null) request.headers['Authorization'] = token;
      request.files.add(await http.MultipartFile.fromPath('recibo', imagePath));
      await request.send();
    }

    return qtdAtual;
  }

  Future<int> registrarSaida(
    String produtoId,
    int quantidade, {
    String? customerId,
    String? imagePath,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/api/v1/processar-saida');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'produto_id': produtoId,
        'quantidade': quantidade,
        if (customerId != null && customerId.isNotEmpty)
          'customer_id': customerId,
      }),
    );

    final Map<String, dynamic> dados = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(dados['mensagem'] ?? 'Erro ao processar saída');
    }

    final String recordId = dados['record_id'];
    final int qtdAtual = (dados['quantidade_atual'] as num).toInt();

    if (imagePath != null && imagePath.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      final pbAuthJson = prefs.getString('pb_auth');
      String? token;
      if (pbAuthJson != null) {
        final decoded = jsonDecode(pbAuthJson);
        token = decoded['token'] as String?;
      }

      final patchUrl = Uri.parse(
        '${ApiConfig.baseUrl}/api/collections/stock_entries/records/$recordId',
      );
      final request = http.MultipartRequest('PATCH', patchUrl);
      if (token != null) request.headers['Authorization'] = token;
      request.files.add(await http.MultipartFile.fromPath('recibo', imagePath));
      await request.send();
    }

    return qtdAtual;
  }
}
