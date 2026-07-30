import 'package:flutter/material.dart';
import 'tela_questionario.dart';

class TelaIdentificacao extends StatefulWidget {
  final String nomeDoTeste;
  const TelaIdentificacao({super.key, required this.nomeDoTeste});

  @override
  State<TelaIdentificacao> createState() => _TelaIdentificacaoState();
}

class _TelaIdentificacaoState extends State<TelaIdentificacao> {
  final _formKey = GlobalKey<FormState>(); // Chave global para validar o formulário
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _instituicaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text('Identificação do Paciente'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey, // Envolve os campos com a chave de validação
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Iniciando: ${widget.nomeDoTeste}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome Completo do Paciente *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                // Regra de validação: impede o envio se estiver em branco
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, insira o nome do paciente.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _idadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Idade',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _instituicaoController,
                decoration: const InputDecoration(
                  labelText: 'Escola / Instituição Clínica',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Só avança se o formulário passar na validação
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaQuestionario(
                          nomeDoTeste: widget.nomeDoTeste,
                          nomePaciente: _nomeController.text,
                          idadePaciente: _idadeController.text.isEmpty ? 'Não Informada' : _idadeController.text,
                          instituicao: _instituicaoController.text.isEmpty ? 'Não Informada' : _instituicaoController.text,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Iniciar Triagem', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
