import 'package:flutter/material.dart';
import 'package:gestao_estoque/widgets/simple_appbar.dart';
import 'package:gestao_estoque/widgets/theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppbar.simples('CONFIGURAÇÕES'),
      body: ValueListenableBuilder(
        valueListenable: themeMode,
        builder: (context, theme, _) {
          return Column(
            children: [
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.green, width: 1),
                ),
                child: ListTile(
                  title: Text(
                    'Perfil',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  leading: Icon(Icons.people_outline),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Ainda em desenvolvimento!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.green, width: 1),
                ),
                child: ListTile(
                  title: Text(
                    'Modo Noturno',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Switch(
                    value: theme == ThemeMode.dark,
                    onChanged: (bool isDarkMode) {
                      themeMode.value = isDarkMode
                          ? ThemeMode.dark
                          : ThemeMode.light;
                    },
                  ),
                  onTap: () => themeMode.value == ThemeMode.dark
                      ? themeMode.value = ThemeMode.light
                      : themeMode.value = ThemeMode.dark,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
