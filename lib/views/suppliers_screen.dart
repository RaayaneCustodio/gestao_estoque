import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/suppliers.dart';
import 'package:gestao_estoque/repositories/suppliers_repository.dart';
import 'package:gestao_estoque/views/suppliers_register_screen.dart';
import 'package:gestao_estoque/views/suppliers_viewmodel.dart';
import 'package:provider/provider.dart';

class SuppliersScreen extends StatefulWidget {
  final SuppliersViewmodel suppliersViewmodel;

  const SuppliersScreen({super.key, required this.suppliersViewmodel});

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  List<Suppliers> selected = [];
  
  appBarDinamica() {
    if (selected.isEmpty) {
      return AppBar(
        title: Text(
          'FORNECEDORES',
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
            for(final supplier in selected){
              context.read<SuppliersViewmodel>().removeSupplier(supplier);
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
    if (widget.suppliersViewmodel.feedback.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.suppliersViewmodel.feedback)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final table = context.watch<SuppliersViewmodel>().suppliers;
    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int id) {
          return ListTile(
            title: Text(
              table[id].nome,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.phone, size: 16),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        table[id].telefone,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.email, size: 16),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        table[id].email,
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
                : SizedBox(child: Icon(Icons.people), width: 10),
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
                      context.read<SuppliersViewmodel>().removeSupplier(
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
                  SuppliersRegister(suppliersViewmodel: context.read()),
            ),
          );
        },
        child: Icon(Icons.add_business_outlined),
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
