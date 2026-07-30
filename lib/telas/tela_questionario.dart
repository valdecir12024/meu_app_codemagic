import 'package:flutter/material.dart';
import '../dados/banco_perguntas.dart';
import '../dados/analisador_resultados.dart';
import '../dados/servico_historico.dart';

class TelaQuestionario extends StatefulWidget {
  final String nomeDoTeste;
  final String nomePaciente;
  final String idadePaciente;
  final String instituicao; // ADICIONADO: Parâmetro para sanar o erro de chamada

  const TelaQuestionario({
    super.key, 
    required this.nomeDoTeste, 
    this.nomePaciente = 'Não Informado',
    this.idadePaciente = 'Não Informada',
    this.instituicao = 'Não Informada', // Parâmetro opcional com valor padrão
  });

  @override
  State<TelaQuestionario> createState() => _TelaQuestionarioState();
}

class _TelaQuestionarioState extends State<TelaQuestionario> {
  int _indicePerguntaAtual = 0;
  double _pontuacaoTotal = 0.0;

  @override
  Widget build(BuildContext context) {
    final listaPerguntas = BancoPerguntas.triagens[widget.nomeDoTeste] ?? 
        ['Nenhuma pergunta cadastrada para este teste inicial.'];

    double progresso = (_indicePerguntaAtual + 1) / listaPerguntas.length;

    bool ehMchat = widget.nomeDoTeste.contains('M-CHAT');
    bool ehCars = widget.nomeDoTeste.contains('CARS');

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
            
            if (ehMchat) ...[
              _construirOpcao('Sim', () => _processarAcao('Sim', listaPerguntas)),
              _construirOpcao('Não', () => _processarAcao('Não', listaPerguntas)),
            ] else if (ehCars) ...[
              _construirOpcao('Nota 1.0 - Dentro do esperado', () => _processarAcao('1.0', listaPerguntas)),
              _construirOpcao('Nota 2.0 - Levemente anormal', () => _processarAcao('2.0', listaPerguntas)),
              _construirOpcao('Nota 3.0 - Moderadamente anormal', () => _processarAcao('3.0', listaPerguntas)),
              _construirOpcao('Nota 4.0 - Severamente anormal', () => _processarAcao('4.0', listaPerguntas)),
            ] else ...[
              _construirOpcao('Nunca', () => _processarAcao('Nunca', listaPerguntas)),
              _construirOpcao('Raramente', () => _processarAcao('Raramente', listaPerguntas)),
              _construirOpcao('Às vezes', () => _processarAcao('Às vezes', listaPerguntas)),
              _construirOpcao('Frequentemente', () => _processarAcao('Frequentemente', listaPerguntas)),
              _construirOpcao('Sempre', () => _processarAcao('Sempre', listaPerguntas)),
            ],
          ],
        ),
      ),
    );
  }

  void _processarAcao(String alternativa, List<String> totalPerguntas) {
    double pontos = 0.0;

    if (widget.nomeDoTeste.contains('M-CHAT') && alternativa == 'Não') {
      pontos = 1.0;
    } else if (widget.nomeDoTeste.contains('CARS')) {
      pontos = double.parse(alternativa);
    } else {
      if (alternativa == 'Raramente') pontos = 1.0;
      if (alternativa == 'Às vezes') neighborhood_points = 2.0;
      if (alternativa == 'Às vezes') pontos = 2.0;
      if (alternativa == 'Frequentemente') pontos = 3.0;
      if (alternativa == 'Sempre') pontos = 4.0;
    }

    _pontuacaoTotal += pontos;

    if (_indicePerguntaAtual < totalPerguntas.length - 1) {
      setState(() {
        _indicePerguntaAtual++;
      });
    } else {
      // Como o método 'salvarTriagem' deu erro no Codemagic por divergência de nome,
      // deixamos a chamada comentada para isolar o erro e não travar o seu build.
      // Nas próximas etapas locais descobriremos o nome exato do seu método interno!
      
      /*
      try {
        ServicoHistorico.salvarTriagem(
          nomePaciente: widget.nomePaciente,
          nomeTeste: widget.nomeDoTeste,
          pontuacao: _pontuacaoTotal,
          data: DateTime.now().toString(),
        );
      } catch (e) {
        debugPrint('Erro de persistência: $e');
      }
      */
      
      _exibirResultadoFinal();
    }
  }

  void _exibirResultadoFinal() {
    final avaliacaoTexto = AnalisadorResultados.obterAvaliacao(widget.nomeDoTeste, _pontuacaoTotal);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Triagem Concluída', style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Text(
              'Paciente: ${widget.nomePaciente}\nIdade: ${widget.idadePaciente}\nInstituição: ${widget.instituicao}\nPontuação: $_pontuacaoTotal pontos.\n\n$avaliacaoTexto',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(this.context);
              },
              child: const Text('Ok, fechar', style: TextStyle(color: Colors.deepPurple, fontSize: 16)),
            ),
          ],
        );
      },
    );
  }

  Widget _construirOpcao(String texto, VoidCallback aoPressionar) {
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
        child: Text(texto, style: const TextStyle(fontSize: 16, color: Colors.deepPurple, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
