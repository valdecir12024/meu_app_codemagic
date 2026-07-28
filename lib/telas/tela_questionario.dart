import 'package:flutter/material.dart';
import '../dados/banco_perguntas.dart';

class TelaQuestionario extends StatefulWidget {
  final String nomeDoTeste;
  const TelaQuestionario({super.key, required this.nomeDoTeste});

  @override
  State<TelaQuestionario> createState() => _TelaQuestionarioState();
}

class _TelaQuestionarioState extends State<TelaQuestionario> {
  int _indicePerguntaAtual = 0; // Controla qual pergunta está na tela

  @override
  Widget build(BuildContext context) {
    // Busca as perguntas correspondentes ao teste clicado
    final listaPerguntas = BancoPerguntas.triagens[widget.nomeDoTeste] ?? 
        ['Nenhuma pergunta cadastrada para este teste inicial.'];

    // Calcula o progresso dinâmico da barra (ex: 1/3, 2/3, 3/3)
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
            // Barra de progresso dinâmica que enche a cada pergunta respondida
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
                  listaPerguntas[_indicePerguntaAtual], // Exibe a pergunta baseada no índice
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _construirOpcaoResposta('Nunca', () => _avancarPergunta(listaPerguntas)),
            _construirOpcaoResposta('Raramente', () => _avancarPergunta(listaPerguntas)),
            _construirOpcaoResposta('Às vezes', () => _avancarPergunta(listaPerguntas)),
            _construirOpcaoResposta('Frequentemente', () => _avancarPergunta(listaPerguntas)),
            _construirOpcaoResposta('Sempre', () => _avancarPergunta(listaPerguntas)),
          ],
        ),
      ),
    );
  }

  // Função interna para avançar para a próxima pergunta ou fechar o teste se for a última
  void _avancarPergunta(List<String> totalPerguntas) {
    setState(() {
      if (_indicePerguntaAtual < totalPerguntas.length - 1) {
        _indicePerguntaAtual++; // Passa para a próxima pergunta
      } else {
        // Se chegou ao fim, exibe o alerta e fecha o bloco voltando para o menu
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Triagem de "${widget.nomeDoTeste}" finalizada com sucesso!')),
        );
      }
    });
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
