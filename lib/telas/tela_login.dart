import 'package:flutter/material.dart';
import 'tela_principal.dart';

class TelaLogin extends StatelessWidget {
  const TelaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Aplicação 2: Preparado para receber a logo oficial do NeuroApp
            // Por enquanto exibe o ícone clínico padrão-ouro até você mapear o arquivo de imagem
            const Icon(
              Icons.psychology, 
              size: 90, 
              color: Colors.deepPurple
            ),
            const SizedBox(height: 16),
            const Text(
              'NeuroApp',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 32),
            const TextField(
              decoration: InputDecoration(
                labelText: 'E-mail ou Registro Profissional',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.assignment_ind),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha de Acesso',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaPrincipal()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Acessar Painel', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
