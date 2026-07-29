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
  int _pontuacaoTotal = 0;
  final TextEditingController _iniciaisController = TextEditingController(); // Controlador LGPD
  bool _testeIniciado = false;

  @override
  Widget build(BuildContext context) {
    final listaPerguntas = BancoPerguntas.triagens[widget.nomeDoTeste] ?? 
        ['Nenhuma pergunta cadastrada para este teste inicial.'];

    double progresso = (_indicePerguntaAtual + 1) / listaPerguntas.length;
    bool ehMchat = widget.nomeDoTeste.contains('M-CHAT');

    // TELA INICIAL: Coleta de iniciais antes de começar o teste (Adequação LGPD)
    if (!_testeIniciado) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.nomeDoTeste), backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.security, size: 60, color: Colors.deepPurple),
              const SizedBox(height: 16),
              const Text('Identificação Segura (LGPD)', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Para proteger a privacidade do paciente, insira apenas as iniciais do nome.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),
              TextField(
                controller: _iniciaisController,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(labelText: 'Iniciais do Paciente (Ex: J.S.O)', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_iniciaisController.text.trim().isNotEmpty) {
                    setState(() => _testeIniciado = true);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Por favor, insira as iniciais para continuar.')));
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text('Iniciar Triagem', style: TextStyle(fontSize: 16)),
              )
            ],
          ),
        ),
      );
    }

    // TELA DE QUESTIONÁRIO ATIVA
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(title: Text('${_iniciaisController.text} - Triagem'), backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(value: progresso, backgroundColor: Colors.black12, valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple)),
            const SizedBox(height: 24),
            Card(
              elevation: 0,
              shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.black12), borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(listaPerguntas[_indicePerguntaAtual], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ),
            ),
            const SizedBox(height: 24),
            
            if (ehMchat) ...[
              _construirOpcaoResposta('Sim', () => _processarRespostaMchat(true, listaPerguntas)),
              _construirOpcaoResposta('Não', () => _processarRespostaMchat(false, listaPerguntas)),
            ] else ...[
              _construirOpcaoResposta('Nunca', () => _processarRespostaPadrao(0, totalPerguntas: listaPerguntas)),
              _construirOpcaoResposta('Raramente', () => _processarRespostaPadrao(1, totalPerguntas: listaPerguntas)),
              _construirOpcaoResposta('Às vezes', () => _processarRespostaPadrao(2, totalPerguntas: listaPerguntas)),
              _construirOpcaoResposta('Frequentemente', () => _processarRespostaPadrao(3, totalPerguntas: listaPerguntas)),
              _construirOpcaoResposta('Sempre', () => _processarRespostaPadrao(4, totalPerguntas: listaPerguntas)),
            ],
          ],
        ),
      ),
    );
  }

  // Lógica Científica Inversa do M-CHAT-R/F
  void _processarRespostaMchat(bool respondeuSim, List<String> totalPerguntas) {
    int numeroPergunta = _indicePerguntaAtual + 1;
    bool pontuaNoSim = (numeroPergunta == 2 || numeroPergunta == 5 || numeroPergunta == 12);
    int pontos = 0;

    if (pontuaNoSim && respondeuSim) pontos = 1;
    if (!pontuaNoSim && !respondeuSim) pontos = 1;

    _pontuacaoTotal += pontos;
    _avancarOuFinalizar(totalPerguntas);
  }

  void _processarRespostaPadrao(int pontos, {required List<String> totalPerguntas}) {
    _pontuacaoTotal += pontos;
    _avancarOuFinalizar(totalPerguntas);
  }

  void _avancarOuFinalizar(List<String> totalPerguntas) {
    if (_indicePerguntaAtual < totalPerguntas.length - 1) {
      setState(() => _indicePerguntaAtual++);
    } else {
      _exibirResultadoFinal();
    }
  }

  // Gera o Alerta Final com Recomendações Automáticas de Acordo com a Pontuação
  void _exibirResultadoFinal() {
    String recomendacao = '';
    bool ehMchat = widget.nomeDoTeste.contains('M-CHAT');

    if (ehMchat) {
      if (_pontuacaoTotal <= 2) {
        recomendacao = 'RISCO BAIXO.\nNenhuma ação clínica imediata é necessária, continue o acompanhamento do desenvolvimento.';
      } else if (_pontuacaoTotal <= 7) {
        recomendacao = 'RISCO MÉDIO.\nRecomenda-se aplicar a Entrevista de Seguimento do M-CHAT-R/F ou realizar uma avaliação detalhada.';
      } else {
        recomendacao = 'RISCO ALTO.\nRecomenda-se encaminhamento imediato para avaliação diagnóstica especializada com neuropediatra/psicólogo.';
      }
    } else {
      recomendacao = 'Triagem inicial concluída. Avalie a pontuação obtida de acordo com os critérios específicos do manual desta escala.';
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resultado: ${_iniciaisController.text}', style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Pontuação total: $_pontuacaoTotal pontos.\n\nDiretriz Clínica:\n$recomendacao', style: const TextStyle(fontSize: 16)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(this.context);
              },
              child: const Text('Concluir', style: TextStyle(color: Colors.deepPurple, fontSize: 16)),
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
        style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(50), side: const BorderSide(color: Colors.deepPurple), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), alignment: Alignment.centerLeft),
        child: Text(texto, style: const TextStyle(fontSize: 16, color: Colors.deepPurple, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
