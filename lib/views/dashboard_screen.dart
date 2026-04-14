import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/suppliers.dart';
import 'package:go_router/go_router.dart';
import 'package:gestao_estoque/app/routes.dart';

import 'suppliers_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<String> options = ['Produtos', 'Fornecedores', 'Configurações'];
  //List<Suppliers> selecionadas = [];

  selectSuppliersPage() {
    context.push(Routes.suppliers);
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
              selectSuppliersPage();
            }
          },
        ),
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
