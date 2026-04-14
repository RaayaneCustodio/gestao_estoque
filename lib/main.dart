import 'package:flutter/material.dart';
import 'package:gestao_estoque/repositories/suppliers_repository.dart';
import 'app/myapp.dart';

void main() {
  runApp(MyApp(suppliersRepository: SuppliersRepository()));
}
