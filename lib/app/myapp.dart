import 'package:flutter/material.dart';
import 'package:gestao_estoque/app/routes.dart';
import 'package:gestao_estoque/repositories/suppliers_repository.dart';
import 'package:provider/provider.dart';
import 'package:gestao_estoque/views/suppliers_viewmodel.dart';
import 'package:gestao_estoque/widgets/theme.dart';

class MyApp extends StatelessWidget {
  final SuppliersRepository suppliersRepository;
  const MyApp({super.key, required this.suppliersRepository});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: suppliersRepository),
        ChangeNotifierProvider<SuppliersViewmodel>(
          create: (context) =>
              SuppliersViewmodel(suppliersRepository: context.read()),
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
