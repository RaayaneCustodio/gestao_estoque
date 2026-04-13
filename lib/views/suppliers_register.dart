import 'package:flutter/material.dart';

class SuppliersRegister extends StatefulWidget {
  const SuppliersRegister({super.key});

  @override
  State<SuppliersRegister> createState() => _SuppliersRegisterState();
}

class _SuppliersRegisterState extends State<SuppliersRegister> {
  final formkey = GlobalKey<FormState>();

  void save() {
    if (formkey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Adicionar Fornecedor', style: TextStyle(fontSize: 19, color: Colors.white),), backgroundColor: Color(0xFF4D9C89),),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              TextFormField(
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
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.add_business),
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
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.add_business),
                  border: OutlineInputBorder(),
                  filled: true,
                  labelText: 'E-mail',
                  contentPadding: EdgeInsets.all(10),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'O campo nome é obrigatório';
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
