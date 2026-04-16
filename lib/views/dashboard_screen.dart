import 'package:flutter/material.dart';
import 'package:gestao_estoque/viewsmodel/products_viewmodel.dart';
import 'package:gestao_estoque/viewsmodel/suppliers_viewmodel.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    // 1. Detectar se o tema atual é dark ou light
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final products = context.watch<ProductsViewModel>().products;
    final int totalQuantidadeProdutos = products.fold(0, (sum, item) => sum + item.quantidade);
    final int totalFornecedores = context.watch<SuppliersViewmodel>().suppliers.length;

    return Scaffold(
      // 2. Usar cores dinâmicas em vez de fixas
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, 
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D9C89),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.analytics_outlined, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'GESTÃO DE ESTOQUE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              _buildCounterCard(
                context,
                title: 'PRODUTOS EM ESTOQUE',
                count: totalQuantidadeProdutos.toString(),
                isDark: isDark,
              ),
              const SizedBox(height: 20),
              _buildCounterCard(
                context,
                title: 'FORNECEDORES CADASTRADOS',
                count: totalFornecedores.toString(),
                isDark: isDark,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCounterCard(BuildContext context, {required String title, required String count, required bool isDark}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          // 4. Cor do card interno baseada no tema
          color: isDark ? Colors.grey[850] : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF4D9C89), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 0.5,
                // 5. Cor do texto dinâmica
                color: isDark ? Colors.white70 : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              count,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 48,
                // 5. Cor do texto dinâmica
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}