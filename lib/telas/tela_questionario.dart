import 'package:flutter/material.dart';
import '../dados/banco_perguntas.dart';

class TelaQuestionario extends StatelessWidget {
  final String nomeDoTeste;

  const TelaQuestionario({super.key, required this.nomeDoTeste});

  @override
  Widget build(BuildContext context) {
    // Busca as perguntas no banco de dados baseado no nome do teste clicado
    final listaPerguntas = BancoPerguntas.triagens[nomeDoTeste] ?? 
        ['Nenhuma pergunta cadastrada para este teste inicial.'];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: Text(nomeDoTeste),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LinearProgressIndicator(
              value: 0.33, // Primeira pergunta do bloco
              backgroundColor: Colors.black12,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  listaPerguntas[0], // Exibe dinamicamente a primeira pergunta da lista
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _construirOpcaoResposta('Nunca', () {}),
            _construirOpcaoResposta('Raramente', () {}),
            _construirOpcaoResposta('Às vezes', () {}),
            _construirOpcaoResposta('Frequentemente', () {}),
            _construirOpcaoResposta('Sempre', () {}),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Triagem de "$nomeDoTeste" iniciada com sucesso!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Próxima Pergunta', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirOpcaoResposta(String texto, VoidCallback aoPressionar) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: OutlinedButton(
        onPressed: aoPressionar,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          side: const BorderSide(color: Colors.deepPurple),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          alignment: Alignment.centerLeft,
        ),
        child: Text(
          texto,
          style: const TextStyle(fontSize: 16, color: Colors.deepPurple, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
