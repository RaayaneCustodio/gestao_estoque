import 'package:flutter/material.dart';
import 'package:gestao_estoque/views/dashboard_screen.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestão de Estoque',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF4D9C89)),
      ),
      home: DashboardScreen(),
    );
  }
}
