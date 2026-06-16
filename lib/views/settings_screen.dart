import 'package:flutter/material.dart';
import 'package:gestao_estoque/views/add_product_screen.dart';
import 'package:gestao_estoque/views/sale_screen.dart';
import 'package:gestao_estoque/viewsmodel/customers_viewmodel.dart';
import 'package:gestao_estoque/viewsmodel/auth_viewmodel.dart';
import 'package:gestao_estoque/services/relatorio_service.dart';
import 'package:go_router/go_router.dart';
import 'package:gestao_estoque/app/routes.dart';
import 'package:gestao_estoque/viewsmodel/products_viewmodel.dart';
import 'package:gestao_estoque/viewsmodel/sale_viewmodel.dart';
import 'package:gestao_estoque/widgets/simple_appbar.dart';
import 'package:gestao_estoque/widgets/theme.dart';
import 'package:provider/provider.dart';
import 'package:gestao_estoque/viewsmodel/suppliers_viewmodel.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppbar.simples('CONFIGURAÇÕES'),
      body: ValueListenableBuilder(
        valueListenable: themeMode,
        builder: (context, theme, _) {
          return Column(
            children: [
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.green, width: 1),
                ),
                child: ListTile(
                  title: Text(
                    'Sair da Conta',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.red),
                  ),
                  leading: Icon(Icons.logout, color: Colors.red),
                  onTap: () {
                    context.read<AuthViewModel>().logout();
                    context.go(Routes.login);
                  },
                ),
              ),
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.green, width: 1),
                ),
                child: ListTile(
                  title: Text(
                    'Modo Noturno',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Switch(
                    value: theme == ThemeMode.dark,
                    onChanged: (bool isDarkMode) {
                      themeMode.value = isDarkMode
                          ? ThemeMode.dark
                          : ThemeMode.light;
                    },
                  ),
                  onTap: () => themeMode.value == ThemeMode.dark
                      ? themeMode.value = ThemeMode.light
                      : themeMode.value = ThemeMode.dark,
                ),
              ),
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.green, width: 1),
                ),
                child: ListTile(
                  title: Text(
                    'Gerar Relatório de Estoque (.xlsx)',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  leading: Icon(Icons.table_chart_outlined, color: Colors.green),
                  onTap: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Gerando relatório... Aguarde.')),
                    );
                    try {
                      final service = RelatorioService();
                      await service.gerarRelatorioEstoque();
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erro: $e'), backgroundColor: Colors.red),
                        );
                      }
                    }
                  },
                ),
              ),
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.green, width: 1),
                ),
                child: ListTile(
                  title: Text(
                    'Entrada de Produtos',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  leading: Icon(Icons.add_circle_outline),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddProductScreen(
                          productsViewModel: context.read<ProductsViewModel>(),
                          suppliersViewModel: context.read<SuppliersViewmodel>(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.green, width: 1),
                ),
                child: ListTile(
                  title: Text(
                    'Saidas de Produtos',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  leading: Icon(Icons.arrow_circle_up_outlined),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SaleScreen(
                          saleViewModel: context.read<SaleViewModel>(),
                          productsViewModel: context.read<ProductsViewModel>(),
                          customersViewModel: context
                              .read<CustomersViewModel>(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
