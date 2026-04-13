import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/suppliers.dart';
import 'package:gestao_estoque/repositories/suppliers_repository.dart';
import 'package:gestao_estoque/views/suppliers_register.dart';

class SuppliersScreen extends StatefulWidget {
  SuppliersScreen({Key? key}) : super(key: key);

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
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
        backgroundColor: Colors.blueGrey[50],
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black87),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final table = SuppliersRepository.table;
    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int id) {
          return ListTile(
            title: Text(
              table[id].nome,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
            selected: selected.contains(table[id]),
            selectedTileColor:
                Colors.indigo[50], //mudar para cor verde do código do figma
            onLongPress: () {
              setState(() {
                (selected.contains(table[id]))
                    ? selected.remove(table[id])
                    : selected.add(table[id]);
              });
            },
          );
        },
        separatorBuilder: (_, ___) => Divider(),
        itemCount: table.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SuppliersRegister()),
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
