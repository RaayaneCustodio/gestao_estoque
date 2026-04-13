import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/suppliers.dart';
import 'package:gestao_estoque/repositories/suppliers_repository.dart';

import 'suppliers_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<String> options = ['Produtos', 'Fornecedores', 'Configurações'];
  //List<Suppliers> selecionadas = [];

  selectSuppliersPage(Suppliers suppliers) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SuppliersScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final table = SuppliersRepository.table;
    return Scaffold(
      appBar: AppBar(
        //leading:, //logo da empresa
        centerTitle: true,
        title: Text('Gestão de Estoque'),
      ),
      body: ListView.separated(
        itemCount: options.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(options[index]),
          onTap: () {
            if (options[index] == 'Fornecedores') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SuppliersScreen()),
              );
            }
          },
        ),
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
