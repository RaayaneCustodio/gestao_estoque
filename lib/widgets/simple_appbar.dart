import 'package:flutter/material.dart';

class SimpleAppbar {
  static PreferredSizeWidget simples(String titulo) {
    return AppBar(
      title: Text(
        titulo,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color(0xFF4D9C89),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
