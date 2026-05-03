import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/customers.dart';
import 'package:gestao_estoque/models/products.dart';
import 'package:gestao_estoque/viewsmodel/customers_viewmodel.dart';
import 'package:gestao_estoque/viewsmodel/products_viewmodel.dart';
import 'package:gestao_estoque/viewsmodel/sale_viewmodel.dart';
import 'package:provider/provider.dart';

class SaleScreen extends StatefulWidget {
  final SaleViewModel saleViewModel;
  final ProductsViewModel productsViewModel;
  final CustomersViewModel customersViewModel;

  const SaleScreen({
    super.key,
    required this.saleViewModel,
    required this.productsViewModel,
    required this.customersViewModel,
  });

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _quantidadeController = TextEditingController();

  Customers? _selectedCustomer;
  Product? _selectedProduct;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.saleViewModel.load();
      widget.productsViewModel.load();
      widget.customersViewModel.load();
    });
  }

  @override
  void dispose() {
    _quantidadeController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final int quantidade = int.tryParse(_quantidadeController.text) ?? 0;

      final sucesso = widget.saleViewModel.registrarSaida(
        _selectedCustomer!.id,
        _selectedProduct!.id,
        quantidade,
      );

      // Atualiza o estoque exibido na UI após a saída
      widget.productsViewModel.load();

      if (sucesso) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Saída registrada com sucesso!',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color(0xFF66BB6A),
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.saleViewModel.feedback,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientes = context.watch<CustomersViewModel>().customers;
    final produtos = context.watch<ProductsViewModel>().products;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'REGISTRAR SAÍDA',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF4D9C89),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF4D9C89), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Cliente',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButtonFormField<Customers>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFD9D9D9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      hint: const Text('Selecione o cliente'),
                      initialValue: _selectedCustomer,
                      items: clientes.map((customers) {
                        return DropdownMenuItem<Customers>(
                          value: customers,
                          child: Text(customers.nome),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedCustomer = value),
                      validator: (value) =>
                          value == null ? 'Selecione um cliente' : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Produto',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButtonFormField<Product>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFD9D9D9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      hint: const Text('Selecione o produto'),
                      initialValue: _selectedProduct,
                      items: produtos.map((product) {
                        return DropdownMenuItem<Product>(
                          value: product,
                          child: Text('${product.nomeProduto} (estoque: ${product.quantidade})'),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedProduct = value),
                      validator: (value) =>
                          value == null ? 'Selecione um produto' : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Quantidade',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: _quantidadeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFD9D9D9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorStyle: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Informe a quantidade';
                        final qtd = int.tryParse(value);
                        if (qtd == null || qtd <= 0) return 'Quantidade inválida';
                        if (_selectedProduct != null && qtd > _selectedProduct!.quantidade) {
                          return 'Estoque disponível: ${_selectedProduct!.quantidade}';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 160,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD9D9D9),
                          foregroundColor: Colors.black,
                          side: const BorderSide(
                            color: Color(0xFF4D9C89),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        onPressed: _save,
                        child: const Text(
                          'CONFIRMAR',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
