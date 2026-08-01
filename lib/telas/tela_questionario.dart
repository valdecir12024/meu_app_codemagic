import 'package:flutter/material.dart';
import '../dados/banco_perguntas.dart';
import '../dados/analisador_resultados.dart';
import '../dados/servico_historico.dart';

// Nome exato da classe principal que o sistema inteiro procura
class TelaQuestionario extends StatefulWidget {
  final String nomeDoTeste;
  final String nomePaciente;
  final String idadePaciente;
  final String instituicao;

  const TelaQuestionario({
    super.key, 
    required this.nomeDoTeste, 
    this.nomePaciente = 'Não Informado',
    this.idadePaciente = 'Não Informada',
    this.instituicao = 'Não Informada',
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
              _construirOpcao('1.0 - Dentro dos limites normais', () => _processarAcao('1.0', listaPerguntas)),
              _construirOpcao('2.0 - Autismo levemente anormal', () => _processarAcao('2.0', listaPerguntas)),
              _construirOpcao('3.0 - Autismo moderadamente anormal', () => _processarAcao('3.0', listaPerguntas)),
              _construirOpcao('4.0 - Autismo severamente anormal', () => _processarAcao('4.0', listaPerguntas)),
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

    // 1. Regra para o M-CHAT
    if (widget.nomeDoTeste.contains('M-CHAT')) {
      if (alternativa == 'Não') pontos = 1.0;
    } 
    // 2. CORREÇÃO: Regra exata para a CARS (Converte o botão numérico diretamente)
    else if (widget.nomeDoTeste.contains('CARS')) {
      // Pega o início do texto do botão (ex: "1.0", "2.0") e transforma em número decimal estável
      String apenasNumero = alternativa.split(' ').first;
      pontos = double.tryParse(apenasNumero) ?? 1.0;
    } 
    // 3. Regra para todas as outras escalas textuais (Frequência)
    else {
      if (alternativa == 'Raramente') pontos = 1.0;
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
      final textoAvaliacao = AnalisadorResultados.obterAvaliacao(widget.nomeDoTeste, _pontuacaoTotal);

      try {
        ServicoHistorico.obterHistorico(); // Valida persistência
        ServicoHistorico.salvarRelatorio(
          nome: widget.nomePaciente,
          teste: widget.nomeDoTeste,
          pontuacao: _pontuacaoTotal.toString(),
          classificacao: textoAvaliacao,
        );
      } catch (e) {
        debugPrint('Aviso de persistência: $e');
      }
      
      _exibirResultadoFinal(textoAvaliacao);
    }
  }

    void _exibirResultadoFinal(String avaliacaoTexto) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.analytics, color: Colors.deepPurple),
              SizedBox(width: 8),
              Text('Triagem Concluída', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          content: SingleChildScrollView(
            child: Text(
              'Paciente: ${widget.nomePaciente}\nIdade: ${widget.idadePaciente}\n'
              'Instituição: ${widget.instituicao}\nPontuação: $_pontuacaoTotal pontos.\n\n$avaliacaoTexto',
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            // Botão para Exportar Planilha Excel/CSV
            IconButton(
              icon: const Icon(Icons.table_view, color: Colors.green, size: 28),
              tooltip: 'Exportar Excel',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exportando dados para planilha Excel...'), backgroundColor: Colors.green),
                );
                // Insira aqui a chamada nativa do seu gerador de Excel se necessário
              },
            ),
            // Botão para Gerar e Compartilhar o PDF Adequado à LGPD
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Gerando laudo em PDF...'), backgroundColor: Colors.deepPurple),
                );
                // Insira aqui a chamada do seu ServicoPdf passando os parametros (nomePaciente, widget.nomeDoTeste, _pontuacaoTotal, avaliacaoTexto)
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
              icon: const Icon(Icons.share),
              label: const Text('PDF'),
            ),
            // Botão de Fechamento Padrão
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(this.context);
              },
              child: const Text('Fechar', style: TextStyle(color: Colors.black54, fontSize: 16)),
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
