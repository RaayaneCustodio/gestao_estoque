import 'package:flutter/material.dart';
import 'package:gestao_estoque/views/suppliers_viewmodel.dart';

class SuppliersRegister extends StatefulWidget {
  final SuppliersViewmodel suppliersViewmodel;
  const SuppliersRegister({super.key, required this.suppliersViewmodel});

  @override
  State<SuppliersRegister> createState() => _SuppliersRegisterState();
}

class _SuppliersRegisterState extends State<SuppliersRegister> {
  final formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void save() {
    if (formkey.currentState!.validate()) {
      widget.suppliersViewmodel.saveSuppliers(
        nameController.text,
        phoneController.text,
        emailController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fornecedor salvo com sucesso!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Adicionar Fornecedor',
          style: TextStyle(fontSize: 19, color: Colors.white),
        ),
        backgroundColor: Color(0xFF4D9C89),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.add_business),
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: 'Nome (Razão Social)',
                  contentPadding: EdgeInsets.all(10),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'O campo nome é obrigatório';
                  }
                  return null;
                },
              ),
              Padding(padding: const EdgeInsets.only(top: 10.0)),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: 'Telefone',
                  contentPadding: EdgeInsets.all(10),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'O campo nome é obrigatório';
                  }
                  return null;
                },
              ),
              Padding(padding: const EdgeInsets.only(top: 10.0)),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: 'E-mail',
                  contentPadding: EdgeInsets.all(10),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O e-mail é obrigatório';
                  }

                  final emailRegex = RegExp(
                    r'^[\w\.-]+@[\w\.-]+\.\w+$',
                  );

                  if (!emailRegex.hasMatch(value)) {
                    return 'Digite um e-mail válido';
                  }

                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: FilledButton(
                  onPressed: save,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: .center,
                      children: [
                        Icon(Icons.check),
                        SizedBox(width: 10),
                        Text('Salvar', style: TextStyle(fontSize: 22)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
