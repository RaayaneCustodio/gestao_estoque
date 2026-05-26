import 'package:flutter/material.dart';
import 'package:gestao_estoque/repositories/auth_repository.dart';
import 'package:gestao_estoque/repositories/customers_repository.dart';
import 'package:gestao_estoque/repositories/products_repository.dart';
import 'package:gestao_estoque/repositories/sale_repository.dart';
import 'package:gestao_estoque/repositories/suppliers_repository.dart';
import 'app/myapp.dart';

void main() {
  runApp(
    MyApp(
      authRepository: AuthRepository(),
      suppliersRepository: SuppliersRepository(),
      productsRepository: ProductsRepository(),
      customersRepository: CustomersRepository(),
      saleRepository: SaleRepository(),
    ),
  );
}
