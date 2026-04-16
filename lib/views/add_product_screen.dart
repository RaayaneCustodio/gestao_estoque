import 'package:flutter/material.dart';
import 'package:gestao_estoque/viewsmodel/products_viewmodel.dart';

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

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nomeController.dispose();
    _quantidadeController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final String name = _nomeController.text;
      final int quantity = int.tryParse(_quantidadeController.text) ?? 0;
      final double price =
          double.tryParse(_precoController.text.replaceAll(',', '.')) ?? 0.0;

      // Se passou no validate(), o name.isNotEmpty já está garantido pelo validator
      widget.productsViewModel.saveProduct(name, quantity, price);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Produto salvo com sucesso!',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xFF4D9C89),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CADASTRO PRODUTO',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF4D9C89),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView( // Movi para fora para evitar quebra de layout no teclado
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
              autovalidateMode: AutovalidateMode.onUserInteraction, // Ajuda a mostrar o erro assim que digita
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Nome do Produto',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: _nomeController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFD9D9D9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // Garante que o erro tenha cor vermelha visível
                        errorStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Informe o nome' : null,
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
                        errorStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Informe a quantidade';
                        if (int.tryParse(value) == null) return 'Número inválido';
                        return null;
                      },
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
                    child: TextFormField(
                      controller: _precoController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFD9D9D9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Informe o preço';
                        if (double.tryParse(value.replaceAll(',', '.')) == null) return 'Preço inválido';
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