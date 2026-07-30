import 'package:flutter/material.dart';
import 'tela_principal.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  bool _ocultarSenha = true; // Controla o estado de visibilidade da senha

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
            TextField(
              obscureText: _ocultarSenha, // Usa a variável dinâmica
              decoration: InputDecoration(
                labelText: 'Senha de Acesso',
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock),
                // Botão de olhinho integrado na direita do campo
                suffixIcon: IconButton(
                  icon: Icon(
                    _ocultarSenha ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _ocultarSenha = !_ocultarSenha; // Inverte o estado ao clicar
                    });
                  },
                ),
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
