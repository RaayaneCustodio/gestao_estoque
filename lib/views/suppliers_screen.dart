import 'package:flutter/material.dart';
import 'package:gestao_estoque/models/suppliers.dart';
import 'package:gestao_estoque/repositories/suppliers_repository.dart';

class SuppliersScreen extends StatefulWidget {
  Suppliers suppliers;
  SuppliersScreen({Key? key, required this.suppliers}) : super(key: key);

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  List<Suppliers> selecionadas = [];

  @override
  Widget build(BuildContext context) {
    final table = SuppliersRepository.table;
    return Scaffold(appBar: AppBar());
  }
}
