import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/customers.dart';
import 'package:gestao_estoque/views/customers_register_screen.dart';
import 'package:gestao_estoque/viewsmodel/customers_viewmodel.dart';
import 'package:provider/provider.dart';

class CustomersScreen extends StatefulWidget {
  final CustomersViewModel customersViewModel;

  const CustomersScreen({super.key, required this.customersViewModel});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  List<Customers> selected = [];
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();
  String searchTerm = "";

  Future<bool?> _showDeleteDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: const Text('Tem certeza que deseja remover este cliente?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('CANCELAR', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('REMOVER', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget appBarDinamica() {
    if (selected.isNotEmpty) {
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
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.blueGrey),
            onPressed: () async {
              final confirmed = await _showDeleteDialog();
              if (confirmed == true) {
                for (final customers in selected) {
                  context.read<CustomersViewModel>().removeCustomers(customers);
                }
                clearSelected();
              }
            },
          ),
        ],
      );
    }

    return AppBar(
      backgroundColor: const Color(0xFF4D9C89),
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: isSearching
            ? TextField(
                key: const ValueKey('search'),
                controller: searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: 'Buscar cliente...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    searchTerm = value;
                  });
                },
              )
            : const Text(
                'CLIENTES',
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
              ),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: Icon(isSearching ? Icons.close : Icons.search, color: Colors.white),
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

  @override
  Widget build(BuildContext context) {
    final table = context.watch<CustomersViewModel>().customers;
    final filteredList = table.where((customers) {
      final nome = customers.nome.toLowerCase();
      final email = customers.email.toLowerCase();
      final telefone = customers.telefone;
      final busca = searchTerm.toLowerCase();

      return nome.contains(busca) || email.contains(busca) || telefone.contains(busca);
    }).toList();

    return Scaffold(
      appBar: appBarDinamica(),
      body: filteredList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.groups, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum cliente cadastrado',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (BuildContext context, int id) {
                final customers = filteredList[id];
                final isSelected = selected.contains(customers);

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Color(0xFF4D9C89), width: 1.5),
                  ),
                  child: ListTile(
                    title: Text(
                      customers.nome,
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
                            const Icon(Icons.phone, size: 16, color: Colors.grey),
                            const SizedBox(width: 5),
                            Expanded(child: Text(customers.telefone)),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.email, size: 16, color: Colors.grey),
                            const SizedBox(width: 5),
                            Expanded(child: Text(customers.email)),
                          ],
                        ),
                      ],
                    ),
                    leading: isSelected
                        ? const CircleAvatar(
                            backgroundColor: Color(0xFF4D9C89),
                            child: Icon(Icons.check, color: Colors.white),
                          )
                        : const Icon(Icons.person, color: Color(0xFF4D9C89)),
                    selected: isSelected,
                    selectedTileColor: const Color(0xFFE8F5E9),
                    onLongPress: () {
                      setState(() {
                        isSelected ? selected.remove(customers) : selected.add(customers);
                      });
                    },
                    trailing: PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: const ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.edit, color: Colors.blue),
                            title: Text('Editar'),
                          ),
                          onTap: () {
                            Future.delayed(const Duration(milliseconds: 10), () {
                              showDialog(
                                context: context,
                                builder: (_) => Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.70,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: CustomersRegister(
                                        customersViewModel: context.read(),
                                        customer: customers,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                        ),
                        PopupMenuItem(
                          child: const ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.delete, color: Colors.red),
                            title: Text('Remover'),
                          ),
                          onTap: () {
                            Future.delayed(const Duration(milliseconds: 10), () async {
                              final confirmed = await _showDeleteDialog();
                              if (confirmed == true) {
                                context.read<CustomersViewModel>().removeCustomers(customers);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 2),
              itemCount: filteredList.length,
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4D9C89),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CustomersRegister(customersViewModel: context.read()),
            ),
          );
        },
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
