import 'dart:io';
import 'package:excel/excel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gestao_estoque/services/api_config.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class RelatorioService {
  Future<void> gerarRelatorioEstoque() async {
    try {
      final entriesUrl = Uri.parse('${ApiConfig.baseUrl}/api/collections/stock_entries/records?sort=-created&expand=product_id,customer_id,supplier_id&perPage=500');
      final salesUrl = Uri.parse('${ApiConfig.baseUrl}/api/collections/sales/records?sort=-created&expand=product_id,customer_id&perPage=500');

      final entriesResponse = await http.get(entriesUrl);
      final salesResponse = await http.get(salesUrl);

      if (entriesResponse.statusCode != 200 || salesResponse.statusCode != 200) {
        throw Exception('Erro ao buscar dados da API. (Status: ${entriesResponse.statusCode})');
      }

      final entriesData = jsonDecode(entriesResponse.body);
      final salesData = jsonDecode(salesResponse.body);

      final List<dynamic> entries = entriesData['items'] ?? [];
      final List<dynamic> sales = salesData['items'] ?? [];

      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Movimentações'];
      excel.setDefaultSheet('Movimentações');

      sheetObject.appendRow([
        TextCellValue('ID'),
        TextCellValue('Data'),
        TextCellValue('Produto'),
        TextCellValue('Tipo'),
        TextCellValue('Quantidade'),
        TextCellValue('Cliente / Fornecedor'),
      ]);

      for (var entry in entries) {
        final expand = entry['expand'] ?? {};
        final productName = expand['product_id']?['nomeProduto'] ?? '';
        final displayName = productName.isNotEmpty ? productName : 'Produto Desconhecido';
        
        String originDest = '-';
        final customerId = entry['customer_id'] ?? '';
        final supplierId = entry['supplier_id'] ?? '';

        if (customerId.isNotEmpty) {
          final cName = expand['customer_id']?['nome'] ?? '';
          originDest = 'Cliente: ${cName.isNotEmpty ? cName : "Desconhecido"}';
        } else if (supplierId.isNotEmpty) {
          final sName = expand['supplier_id']?['nome'] ?? '';
          originDest = 'Fornecedor: ${sName.isNotEmpty ? sName : "Desconhecido"}';
        }
        
        sheetObject.appendRow([
          TextCellValue(entry['id'] ?? ''),
          TextCellValue(entry['created'] ?? ''),
          TextCellValue(displayName),
          TextCellValue(entry['tipo'] ?? ''),
          IntCellValue((entry['quantidade'] as num?)?.toInt() ?? 0),
          TextCellValue(originDest),
        ]);
      }

      Sheet salesSheet = excel['Vendas'];
      salesSheet.appendRow([
        TextCellValue('ID'),
        TextCellValue('Data'),
        TextCellValue('Produto'),
        TextCellValue('Cliente'),
        TextCellValue('Quantidade'),
        TextCellValue('Preço Unitário'),
        TextCellValue('Total'),
      ]);

      for (var sale in sales) {
        final expand = sale['expand'] ?? {};
        final productName = expand['product_id']?['nomeProduto'] ?? '';
        final customerName = expand['customer_id']?['nome'] ?? '';
        
        final displayName = productName.isNotEmpty ? productName : 'Produto Desconhecido';
        final displayCustomer = customerName.isNotEmpty ? customerName : 'Cliente Desconhecido';
        final qtd = (sale['quantidade'] as num?)?.toInt() ?? 0;
        final preco = (sale['precoUnitario'] as num?)?.toDouble() ?? 0.0;
        
        salesSheet.appendRow([
          TextCellValue(sale['id'] ?? ''),
          TextCellValue(sale['created'] ?? ''),
          TextCellValue(displayName),
          TextCellValue(displayCustomer),
          IntCellValue(qtd),
          DoubleCellValue(preco),
          DoubleCellValue(qtd * preco),
        ]);
      }

      final fileBytes = excel.save();
      if (fileBytes == null) throw Exception('Falha ao gerar bytes do Excel');

      Directory? directory;
      if (Platform.isAndroid || Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getDownloadsDirectory();
      }

      final String filePath = '${directory!.path}/relatorio_estoque.xlsx';
      final file = File(filePath);

      await file.writeAsBytes(fileBytes);

      final result = await OpenFilex.open(filePath);
      print('Resultado da abertura: ${result.message}');
      
    } catch (e) {
      print('Erro ao gerar relatório: $e');
      rethrow;
    }
  }
}
