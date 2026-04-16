import 'package:flutter/material.dart';
import 'package:gestao_estoque/views/products_viewmodel.dart';

class AddProductScreen extends StatefulWidget {
  final ProductsViewModel productsViewModel;
  const AddProductScreen({super.key, required this.productsViewModel});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

  class _AddProductScreenState extends State<AddProductScreen> {
    final TextEditingController _nomeController = TextEditingController();
    final TextEditingController _quantidadeController = TextEditingController();
    final TextEditingController _precoController = TextEditingController();

    @override
    void dispose() {
      _nomeController.dispose();
      _quantidadeController.dispose();
      _precoController.dispose();
      super.dispose();
    }

    void _save() {
      final String name = _nomeController.text;
      final int quantity = int.tryParse(_quantidadeController.text) ?? 0;
      final double price = double.tryParse(_precoController.text) ?? 0.0;

      if (name.isNotEmpty) {
        widget.productsViewModel.saveProduct(name, quantity, price);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produto salvo com sucesso!')),
        );
        Navigator.pop(context);
      }
    }

    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'CADASTRO PRODUTO',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF4D9C89),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Container (
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF4D9C89), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Nome do Produto',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox( height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _nomeController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFD9D9D9),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
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
                      child: TextField(
                        controller: _quantidadeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFD9D9D9),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Preco',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _precoController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFD9D9D9),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
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
                            side: const BorderSide(color: Color(0xFF4D9C89), width: 2),
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
      ));
    }
  }