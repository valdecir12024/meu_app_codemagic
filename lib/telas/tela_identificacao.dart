import 'package:flutter/material.dart';
import 'tela_questionario.dart';

class TelaIdentificacao extends StatefulWidget {
  final String nomeDoTeste;
  const TelaIdentificacao({super.key, required this.nomeDoTeste});

  @override
  State<TelaIdentificacao> createState() => _TelaIdentificacaoState();
}

class _TelaIdentificacaoState extends State<TelaIdentificacao> {
  // Controladores para capturar o texto digitado
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _instituicaoController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    _instituicaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text('Identificação'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.nomeDoTeste,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Insira os dados do avaliado antes de iniciar:',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome Completo', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _idadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Idade', border: OutlineInputBorder(), prefixIcon: Icon(Icons.cake)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _instituicaoController,
              decoration: const InputDecoration(labelText: 'Escola / Clínica', border: OutlineInputBorder(), prefixIcon: Icon(Icons.business)),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Avança para o questionário passando os dados coletados
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaQuestionario(
                      nomeDoTeste: widget.nomeDoTeste,
                      nomePaciente: _nomeController.text.isEmpty ? 'Não Informado' : _nomeController.text,
                      idadePaciente: _idadeController.text.isEmpty ? 'Não Informada' : _idadeController.text,
                      instituicao: _instituicaoController.text.isEmpty ? 'Não Informada' : _instituicaoController.text,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16)),
              child: const Text('Iniciar Triagem', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
