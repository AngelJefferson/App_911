// Angel Jefferson Sanchez Ventura
// Matricula:2021-1816

import 'package:flutter/material.dart';
import 'package:app_911/constants.dart';
import 'package:app_911/screens/lista_eventos_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('App 911 iniciada por $kAutor ($kMatricula)');
  runApp(const App911());
}

class App911 extends StatelessWidget {
  const App911({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro 911',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const ListaEventosPage(),
    );
  }
}