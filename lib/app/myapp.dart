import 'package:flutter/material.dart';
import 'package:gestao_estoque/app/routes.dart';
import 'package:gestao_estoque/repositories/suppliers_repository.dart';
import 'package:gestao_estoque/repositories/products_repository.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import 'package:gestao_estoque/views/suppliers_viewmodel.dart';
import 'package:gestao_estoque/views/products_viewmodel.dart';
import 'package:gestao_estoque/widgets/theme.dart';

=======
import 'package:gestao_estoque/viewsmodel/suppliers_viewmodel.dart';
import 'package:gestao_estoque/widgets/theme.dart';
>>>>>>> 61708e5efb003349943c59c0af9a4df8f98d7a5c

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
            theme: (theme == ThemeMode.dark) ? darkTheme : lightTheme,
            routerConfig: routes,
          );
        },
      ),
    );
  }
}
