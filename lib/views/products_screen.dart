import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/products.dart';
import 'package:gestao_estoque/views/add_product_screen.dart';
import 'package:gestao_estoque/viewsmodel/products_viewmodel.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  final ProductsViewModel productsViewmodel;

  const ProductsScreen({super.key, required this.productsViewmodel});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();
  String searchTerm = "";
  List<Product> selected = [];

  // Função para limpar seleção
  void clearSelected() {
    setState(() {
      selected = [];
    });
  }

  // Diálogo de confirmação unificado
  Future<bool?> _showDeleteDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: const Text('Tem certeza que deseja remover o(s) item(ns) selecionado(s)?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('CANCELAR', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'REMOVER',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // AppBar Dinâmica
  PreferredSizeWidget appBarDinamica() {
    if (selected.isEmpty) {
      return AppBar(
        title: const Text(
          'PRODUTOS',
          style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF4D9C89),
        iconTheme: const IconThemeData(color: Colors.white),
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blueGrey),
          onPressed: clearSelected,
        ),
        title: Text(
          '${selected.length} selecionado${selected.length > 1 ? 's' : ''}',
          style: const TextStyle(fontSize: 17),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[100],
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.blueGrey),
            onPressed: () async {
              final confirmed = await _showDeleteDialog();
              if (confirmed == true) {
                for (final product in selected) {
                  context.read<ProductsViewModel>().removeProduct(product);
                }
                clearSelected();
              }
            },
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final table = context.watch<ProductsViewModel>().products;

    return Scaffold(
      appBar: appBarDinamica(),
      body: table.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum produto cadastrado',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: table.length,
              separatorBuilder: (_, __) => const SizedBox(height: 2),
              itemBuilder: (BuildContext context, int id) {
                final product = table[id];
                final isSelected = selected.contains(product);

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Color(0xFF4D9C89), width: 1.5),
                  ),
                  child: ListTile(
                    title: Text(
                      product.nomeProduto,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.inventory_2, size: 16, color: Colors.grey),
                            const SizedBox(width: 5),
                            Expanded(child: Text('Qtd: ${product.quantidade}')),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.attach_money, size: 16, color: Colors.grey),
                            const SizedBox(width: 5),
                            Expanded(child: Text('Preço: R\$ ${product.preco.toStringAsFixed(2)}')),
                          ],
                        ),
                      ],
                    ),
                    leading: isSelected
                        ? const CircleAvatar(
                            backgroundColor: Color(0xFF4D9C89),
                            child: Icon(Icons.check, color: Colors.white),
                          )
                        : const Icon(Icons.inventory, color: Color(0xFF4D9C89)), // ÍCONE ALTERADO AQUI
                    selected: isSelected,
                    selectedTileColor: const Color(0xFFE8F5E9),
                    onLongPress: () {
                      setState(() {
                        isSelected ? selected.remove(product) : selected.add(product);
                      });
                    },
                    trailing: PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.delete, color: Colors.red),
                            title: const Text('Remover'),
                            onTap: () async {
                              Navigator.pop(context); // Fecha o menu
                              final confirmed = await _showDeleteDialog();
                              if (confirmed == true) {
                                context.read<ProductsViewModel>().removeProduct(product);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4D9C89),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddProductScreen(productsViewModel: context.read()),
            ),
          );
        },
        child: const Icon(Icons.add_box, color: Colors.white), // ÍCONE ALTERADO AQUI
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}