import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/suppliers.dart';
import 'package:gestao_estoque/views/suppliers_register_screen.dart';
import 'package:gestao_estoque/viewsmodel/suppliers_viewmodel.dart';
import 'package:gestao_estoque/widgets/simple_appbar.dart';
import 'package:provider/provider.dart';

class SuppliersScreen extends StatefulWidget {
  final SuppliersViewmodel suppliersViewmodel;

  const SuppliersScreen({super.key, required this.suppliersViewmodel});

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  List<Suppliers> selected = [];
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();
  String searchTerm = "";

  PreferredSizeWidget appBarDinamica() {
    if (selected.isNotEmpty) {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blueGrey),
          onPressed: clearSelected,
        ),
        title: Text(
          '${selected.length} selecionado${selected.length > 1 ? 's' : ''}',
          style: TextStyle(fontSize: 17),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[100],
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.blueGrey),
            onPressed: () {
              for (final supplier in selected) {
                context.read<SuppliersViewmodel>().removeSupplier(supplier);
              }
              clearSelected();
            },
          ),
        ],
      );
    }

    return AppBar(
      backgroundColor: const Color(0xFF4D9C89),
      title: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              axis: Axis.horizontal,
              child: child,
            ),
          );
        },
        child: isSearching
            ? TextField(
                key: ValueKey('search'),
                controller: searchController,
                autofocus: true,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  hintText: 'Buscar fornecedor...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    searchTerm = value;
                  });
                },
              )
            : Text(
                'FORNECEDORES',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            isSearching ? Icons.close : Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              isSearching = !isSearching;

              if (!isSearching) {
                searchController.clear();
                searchTerm = "";
              }
            });
          },
        ),
      ],
    );
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
    final filteredList = table.where((supplier) {
      final nome = supplier.nome.toLowerCase();
      final email = supplier.email.toLowerCase();
      final telefone = supplier.telefone;

      final busca = searchTerm.toLowerCase();

      return nome.contains(busca) ||
          email.contains(busca) ||
          telefone.contains(busca);
    }).toList();

    return Scaffold(
      appBar: appBarDinamica(),
      body: filteredList.isEmpty
          ? const Center(
              child: ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Nenhum item na lista ainda'),
              ),
            )
          : ListView.separated(
              itemBuilder: (BuildContext context, int id) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.green, width: 1),
                  ),
                  child: ListTile(
                    title: Text(
                      filteredList[id].nome,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
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
                                filteredList[id].telefone,
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
                                filteredList[id].email,
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
                    selected: selected.contains(filteredList[id]),
                    selectedTileColor: Colors
                        .blueGrey[50], //mudar para cor verde do código do figma
                    onLongPress: () {
                      setState(() {
                        (selected.contains(filteredList[id]))
                            ? selected.remove(filteredList[id])
                            : selected.add(filteredList[id]);
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
                                filteredList[id],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, _) => Divider(),
              itemCount: filteredList.length,
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
    );
  }
}
