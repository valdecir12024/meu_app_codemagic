import 'package:flutter/material.dart';
import 'telas/tela_splash.dart'; // Importa a nova tela de splash

void main() {
  runApp(const MeuAppReal());
}

class MeuAppReal extends StatelessWidget {
  const MeuAppReal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeuroApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TelaSplash(), // CORREGIDO: O app agora inicia na Splash de 2 segundos
    );
  }
}
