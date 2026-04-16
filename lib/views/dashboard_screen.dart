import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gestao_estoque/app/routes.dart';

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
        backgroundColor: const Color(0xFF4D9C89),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Image.asset('images/logo.png', height: 30),
            SizedBox(width: 12),
            Text(
              'Gestão de Estoque',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
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
