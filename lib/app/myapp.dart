import 'package:flutter/material.dart';
import 'package:gestao_estoque/app/routes.dart';
import 'package:gestao_estoque/repositories/suppliers_repository.dart';
import 'package:gestao_estoque/repositories/products_repository.dart';
import 'package:gestao_estoque/repositories/customers_repository.dart';
import 'package:gestao_estoque/repositories/sale_repository.dart';
import 'package:provider/provider.dart';
import 'package:gestao_estoque/viewsmodel/products_viewmodel.dart';
import 'package:gestao_estoque/viewsmodel/suppliers_viewmodel.dart';
import 'package:gestao_estoque/viewsmodel/customers_viewmodel.dart';
import 'package:gestao_estoque/viewsmodel/sale_viewmodel.dart';
import 'package:gestao_estoque/widgets/theme.dart';

class MyApp extends StatelessWidget {
  final SuppliersRepository suppliersRepository;
  final ProductsRepository productsRepository;
  final CustomersRepository customersRepository;
  final SaleRepository saleRepository;
  const MyApp({
    super.key,
    required this.suppliersRepository,
    required this.productsRepository,
    required this.customersRepository,
    required this.saleRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: suppliersRepository),
        Provider.value(value: productsRepository),
        Provider.value(value: customersRepository),
        Provider.value(value: saleRepository),
        ChangeNotifierProvider<SuppliersViewmodel>(
          create: (context) =>
              SuppliersViewmodel(suppliersRepository: context.read()),
        ),
        ChangeNotifierProvider<ProductsViewModel>(
          create: (context) =>
              ProductsViewModel(productsRepository: context.read()),
        ),
        ChangeNotifierProvider<CustomersViewModel>(
          create: (context) =>
              CustomersViewModel(customersRepository: context.read()),
        ),
        ChangeNotifierProvider<SaleViewModel>(
          create: (context) => SaleViewModel(
            saleRepository: context.read(),
            productsRepository: context.read(),
          ),
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: themeMode,
        builder: (context, theme, _) {
          return MaterialApp.router(
            title: 'Gestão de Estoque',
            debugShowCheckedModeBanner: false,
            theme: lightTheme.copyWith(
              scaffoldBackgroundColor: Colors.white,
            ),
            darkTheme: darkTheme, 
            themeMode: theme,
            routerConfig: routes,
          );
        },
      ),
    );
  }
}