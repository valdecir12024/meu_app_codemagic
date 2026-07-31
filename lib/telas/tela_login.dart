import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tela_principal.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _ocultarSenha = true;

  // Função interna que valida o login com o cadastro guardado no aparelho
  Future<void> _realizarAutenticacao() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      
      // Recupera as credenciais registradas (se não houver, o padrão é 'admin')
      final emailSalvo = prefs.getString('prof_email') ?? 'admin';
      final senhaSalva = prefs.getString('prof_senha') ?? '1234';

      if (_emailController.text == emailSalvo && _senhaController.text == senhaSalva) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TelaPrincipal()),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Credenciais incorretas. Caso não tenha cadastro, use admin e senha 1234.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
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
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail ou Registro Profissional *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.assignment_ind),
                ),
                validator: (value) => value == null || value.trim().isEmpty ? 'Por favor, insira suas credenciais.' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _senhaController,
                obscureText: _ocultarSenha,
                decoration: InputDecoration(
                  labelText: 'Senha de Acesso *',
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _ocultarSenha ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _ocultarSenha = !_ocultarSenha;
                      });
                    },
                  ),
                ),
                validator: (value) => value == null || value.trim().isEmpty ? 'Por favor, insira sua senha.' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _realizarAutenticacao, // Invoca o método com validação de SharedPreferences
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
      ),
    );
  }
}
