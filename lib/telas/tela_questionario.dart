import 'package:flutter/material.dart';
import '../dados/banco_perguntas.dart';

class TelaQuestionario extends StatefulWidget {
  final String nomeDoTeste;
  const TelaQuestionario({super.key, required this.nomeDoTeste});

  @override
  State<TelaQuestionario> createState() => _TelaQuestionarioState();
}

class _TelaQuestionarioState extends State<TelaQuestionario> {
  int _indicePerguntaAtual = 0;
  int _pontuacaoTotal = 0; // Armazena a soma dos pontos das respostas

  @override
  Widget build(BuildContext context) {
    final listaPerguntas = BancoPerguntas.triagens[widget.nomeDoTeste] ?? 
        ['Nenhuma pergunta cadastrada para este teste inicial.'];

    double progresso = (_indicePerguntaAtual + 1) / listaPerguntas.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: Text(widget.nomeDoTeste),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: progresso,
              backgroundColor: Colors.black12,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
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
                  listaPerguntas[_indicePerguntaAtual],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Passamos o peso de cada alternativa para a função de avançar
            _construirOpcaoResposta('Nunca', () => _processarResposta(0, listaPerguntas)),
            _construirOpcaoResposta('Raramente', () => _processarResposta(1, listaPerguntas)),
            _construirOpcaoResposta('Às vezes', () => _processarResposta(2, listaPerguntas)),
            _construirOpcaoResposta('Frequentemente', () => _processarResposta(3, listaPerguntas)),
            _construirOpcaoResposta('Sempre', () => _processarResposta(4, listaPerguntas)),
          ],
        ),
      ),
    );
  }

  void _processarResposta(int pontosDaAlternativa, List<String> totalPerguntas) {
    _pontuacaoTotal += pontosDaAlternativa; // Acumula os pontos da resposta atual

    if (_indicePerguntaAtual < totalPerguntas.length - 1) {
      setState(() {
        _indicePerguntaAtual++; // Vai para a próxima pergunta
      });
    } else {
      // Chegou ao fim do teste: exibe o resultado final de triagem
      _exibirResultadoFinal();
    }
  }

  void _exibirResultadoFinal() {
    showDialog(
      context: context,
      barrierDismissible: false, // Força o usuário a clicar no botão de fechar
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Triagem Concluída', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(
            'Pontuação total obtida: $_pontuacaoTotal pontos.\n\nEste resultado serve como um rastreio inicial clínico ou educacional.',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha a caixinha de diálogo
                Navigator.pop(this.context); // Fecha a tela do teste e volta para o menu
              },
              child: const Text('Ok, fechar', style: TextStyle(color: Colors.deepPurple, fontSize: 16)),
            ),
          ],
        );
      },
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
