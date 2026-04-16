import 'package:flutter/material.dart';
import 'package:gestao_estoque/app/routes.dart';
import 'package:gestao_estoque/repositories/suppliers_repository.dart';
import 'package:gestao_estoque/repositories/products_repository.dart';
import 'package:provider/provider.dart';
import 'package:gestao_estoque/viewsmodel/products_viewmodel.dart';
import 'package:gestao_estoque/viewsmodel/suppliers_viewmodel.dart';
import 'package:gestao_estoque/widgets/theme.dart';

class MyApp extends StatelessWidget {
  final SuppliersRepository suppliersRepository;
  final ProductsRepository productsRepository;
  const MyApp({super.key, required this.suppliersRepository, required this.productsRepository});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: suppliersRepository),
        Provider.value(value: productsRepository),
        ChangeNotifierProvider<SuppliersViewmodel>(
          create: (context) =>
              SuppliersViewmodel(suppliersRepository: context.read()),
        ),
        ChangeNotifierProvider<ProductsViewModel>(
          create: (context) =>
              ProductsViewModel(productsRepository: context.read()),
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