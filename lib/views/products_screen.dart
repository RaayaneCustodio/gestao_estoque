import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/products.dart';
import 'package:gestao_estoque/views/add_product_screen.dart';
import 'package:gestao_estoque/views/products_viewmodel.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  final ProductsViewModel productsViewmodel;

  const ProductsScreen({super.key, required this.productsViewmodel});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> selected = [];
  
  appBarDinamica() {
    if (selected.isEmpty) {
      return AppBar(
        title: Text(
          'PRODUTOS',
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF4D9C89),
        iconTheme: IconThemeData(color: Colors.white),
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blueGrey),
          onPressed: () {
            setState(() {
              selected = [];
            });
          },
        ),
        title: (selected.length == 1)
            ? Text(
                '${selected.length} selecionado',
                style: TextStyle(fontSize: 17),
              )
            : Text(
                '${selected.length} selecionados',
                style: TextStyle(fontSize: 17),
              ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[100],
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(icon: Icon(Icons.delete, color: Colors.blueGrey), onPressed: (){
            for(final product in selected){
              context.read<ProductsViewModel>().removeProduct(product);
            }
            setState(() {
              selected = [];
            });
          },)
        ],
      );
    }
  }

  clearSelected() {
    setState(() {
      selected = [];
    });
  }

  void onSave() {
    if (widget.productsViewmodel.feedback.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.productsViewmodel.feedback)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final table = context.watch<ProductsViewModel>().products;
    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int id) {
          return ListTile(
            title: Text(
              table[id].nomeProduto,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.inventory_2, size: 16),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Qtd: ${table[id].quantidade}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.attach_money, size: 16),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Preço: R\$ ${table[id].preco}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            leading: (selected.contains(table[id]))
                ? CircleAvatar(child: Icon(Icons.check))
                : SizedBox(child: Icon(Icons.shopping_cart), width: 10),
            selected: selected.contains(table[id]),
            selectedTileColor:
                Colors.blueGrey[50], //mudar para cor verde do código do figma
            onLongPress: () {
              setState(() {
                (selected.contains(table[id]))
                    ? selected.remove(table[id])
                    : selected.add(table[id]);
              });
            },
            trailing: PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: ListTile(
                    title: Text('Remover'),
                    onTap: () {
                      Navigator.pop(context);
                      context.read<ProductsViewModel>().removeProduct(
                        table[id],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, ___) => Divider(),
        itemCount: table.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  AddProductScreen(productsViewModel: context.read()),
            ),
          );
        },
        child: Icon(Icons.add_shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      /*bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(), // Cria o efeito de corte para o botão
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.menu), onPressed: () {}),
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
          ],
        ),
      ),*/
    );
  }
}