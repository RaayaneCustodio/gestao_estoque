import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/products.dart';
import 'package:gestao_estoque/services/estoque_service.dart';
import 'package:gestao_estoque/models/customers.dart';
import 'package:gestao_estoque/models/suppliers.dart';
import 'package:gestao_estoque/widgets/image_picker_modal.dart';

class StockEntryDialog extends StatefulWidget {
  final Product product;
  final List<Suppliers> suppliers;
  final List<Customers> customers;
  final VoidCallback onSuccess;

  const StockEntryDialog({
    super.key,
    required this.product,
    required this.suppliers,
    required this.customers,
    required this.onSuccess,
  });

  @override
  State<StockEntryDialog> createState() => _StockEntryDialogState();
}

class _StockEntryDialogState extends State<StockEntryDialog> {
  final TextEditingController _qtdController = TextEditingController();
  String? _imagePath;
  bool _isLoading = false;
  String _tipoMovimentacao = 'entrada'; // 'entrada' ou 'saida'
  Suppliers? _selectedSupplier;
  Customers? _selectedCustomer;

  Future<void> _salvar() async {
    final int qtd = int.tryParse(_qtdController.text) ?? 0;
    if (qtd <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quantidade deve ser maior que zero')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final estoqueService = EstoqueService();
      await estoqueService.registrarMovimentacao(
        widget.product.id,
        qtd,
        _tipoMovimentacao,
        imagePath: _imagePath,
        customerId: _tipoMovimentacao == 'saida' ? _selectedCustomer?.id : null,
        supplierId: _tipoMovimentacao == 'entrada' ? _selectedSupplier?.id : null,
      );
      
      if (mounted) {
        widget.onSuccess();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Movimentação registrada com sucesso!', style: TextStyle(color: Colors.white)), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: $e', style: const TextStyle(color: Colors.white)), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Movimentar: ${widget.product.nomeProduto}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _tipoMovimentacao,
              items: const [
                DropdownMenuItem(value: 'entrada', child: Text('Entrada (Adicionar)')),
                DropdownMenuItem(value: 'saida', child: Text('Saída (Remover)')),
              ],
              onChanged: (val) => setState(() => _tipoMovimentacao = val!),
              decoration: const InputDecoration(labelText: 'Tipo de Movimentação'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _qtdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantidade',
                border: OutlineInputBorder(),
              ),
            ),
            if (_tipoMovimentacao == 'entrada') ...[
              const SizedBox(height: 10),
              DropdownButtonFormField<Suppliers>(
                value: _selectedSupplier,
                items: widget.suppliers.map((s) => DropdownMenuItem(value: s, child: Text(s.nome))).toList(),
                onChanged: (val) => setState(() => _selectedSupplier = val),
                decoration: const InputDecoration(labelText: 'Fornecedor (Opcional)', border: OutlineInputBorder()),
              ),
            ] else ...[
              const SizedBox(height: 10),
              DropdownButtonFormField<Customers>(
                value: _selectedCustomer,
                items: widget.customers.map((c) => DropdownMenuItem(value: c, child: Text(c.nome))).toList(),
                onChanged: (val) => setState(() => _selectedCustomer = val),
                decoration: const InputDecoration(labelText: 'Cliente (Opcional)', border: OutlineInputBorder()),
              ),
            ],
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                final path = await ImagePickerModal.show(context);
                if (path != null) {
                  setState(() => _imagePath = path);
                }
              },
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  image: _imagePath != null
                      ? DecorationImage(image: FileImage(File(_imagePath!)), fit: BoxFit.cover)
                      : null,
                ),
                child: _imagePath == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                          Text('Anexar Recibo / Nota', style: TextStyle(color: Colors.grey)),
                        ],
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CANCELAR'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _salvar,
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4D9C89), foregroundColor: Colors.white),
          child: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Text('SALVAR'),
        ),
      ],
    );
  }
}
