import 'package:flutter/material.dart';
import 'package:gestao_estoque/views/dashboard_screen.dart';
import 'package:gestao_estoque/views/settings_screen.dart';
import 'package:gestao_estoque/views/suppliers_screen.dart';
import 'package:gestao_estoque/views/products_screen.dart';
import 'package:gestao_estoque/views/customers_screen.dart';
import 'package:gestao_estoque/viewsmodel/suppliers_viewmodel.dart';
import 'package:gestao_estoque/viewsmodel/customers_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int currentPage = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: currentPage);
  }

  setCurrentPage(pagina) {
    setState(() {
      currentPage = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          DashboardScreen(),
          ProductsScreen(
            productsViewmodel: context.read(),
            suppliersViewmodel: context.read<SuppliersViewmodel>(),
          ),
          SuppliersScreen(suppliersViewmodel: context.read()),
          CustomersScreen(customersViewModel: context.read<CustomersViewModel>()),
          SettingsScreen(),
        ],
        onPageChanged: setCurrentPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Início'),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Produtos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Fornecedores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Clientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
        onTap: (pagina) {
          pc.animateToPage(
            pagina,
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
        backgroundColor: Color.alphaBlend(
          const Color(0xFF4D9C89),
          Colors.white,
        ),
      ),
    );
  }
}
