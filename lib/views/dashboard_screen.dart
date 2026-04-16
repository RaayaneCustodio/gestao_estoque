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
    final products = context.watch<ProductsViewModel>().products;
    final int totalQuantidadeProdutos = products.fold(0, (sum, item) => sum + item.quantidade);
    final int totalFornecedores = context.watch<SuppliersViewmodel>().suppliers.length;

    return Scaffold(
      // AJUSTE: Forçando o fundo da tela para branco puro
      backgroundColor: Colors.white, 
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D9C89),
        centerTitle: true,
        elevation: 0, // Removi a sombra para um visual mais limpo
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
                title: 'PRODUTOS EM ESTOQUE',
                count: totalQuantidadeProdutos.toString(),
              ),
              
              const SizedBox(height: 20),
              
              _buildCounterCard(
                title: 'FORNECEDORES CADASTRADOS',
                count: totalFornecedores.toString(),
              ),
              
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCounterCard({required String title, required String count}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          // Se quiser os cards internos um pouquinho diferentes, use F5F5F5
          // Se quiser TUDO branco, mude para Colors.white
          color: const Color(0xFFF5F5F5), 
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF4D9C89), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05), // Sombra bem sutil
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              count,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 48,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}