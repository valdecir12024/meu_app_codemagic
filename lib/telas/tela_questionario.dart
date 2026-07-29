import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../dados/banco_perguntas.dart';
import '../dados/gerador_pdf.dart'; // Importa nosso gerador de PDF

class TelaQuestionario extends StatefulWidget {
  final String nomeDoTeste;
  const TelaQuestionario({super.key, required this.nomeDoTeste});

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
              _construirOpcaoResposta('Sim', () => _processarRespostaMchat('Sim', listaPerguntas)),
              _construirOpcaoResposta('Não', () => _processarRespostaMchat('Não', listaPerguntas)),
            ] else if (ehCars) ...[
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  _construirBotaoNumerico('1.0', 1.0, listaPerguntas),
                  _construirBotaoNumerico('1.5', 1.5, listaPerguntas),
                  _construirBotaoNumerico('2.0', 2.0, listaPerguntas),
                  _construirBotaoNumerico('2.5', 2.5, listaPerguntas),
                  _construirBotaoNumerico('3.0', 3.0, listaPerguntas),
                  _construirBotaoNumerico('3.5', 3.5, listaPerguntas),
                  _construirBotaoNumerico('4.0', 4.0, listaPerguntas),
                ],
              ),
            ] else ...[
              _construirOpcaoResposta('Nunca', () => _processarRespostaPadrao(0, listaPerguntas)),
              _construirOpcaoResposta('Raramente', () => _processarRespostaPadrao(1, listaPerguntas)),
              _construirOpcaoResposta('Às vezes', () => _processarRespostaPadrao(2, listaPerguntas)),
              _construirOpcaoResposta('Frequentemente', () => _processarRespostaPadrao(3, listaPerguntas)),
              _construirOpcaoResposta('Sempre', () => _processarRespostaPadrao(4, listaPerguntas)),
            ],
          ],
        ),
      ),
    );
  }

  void _processarRespostaPadrao(int pontos, List<String> totalPerguntas) {
    _pontuacaoTotal += pontos;
    _proximaEtapa(totalPerguntas);
  }

  void _processarRespostaMchat(String resposta, List<String> totalPerguntas) {
    int numeroPergunta = _indicePerguntaAtual + 1;
    if (numeroPergunta == 2 || numeroPergunta == 5 || numeroPergunta == 12) {
      if (resposta == 'Sim') _pontuacaoTotal += 1;
    } else {
      if (resposta == 'Não') _pontuacaoTotal += 1;
    }
    _proximaEtapa(totalPerguntas);
  }

  void _proximaEtapa(List<String> totalPerguntas) {
    if (_indicePerguntaAtual < totalPerguntas.length - 1) {
      setState(() {
        _indicePerguntaAtual++;
      });
    } else {
      _exibirResultadoFinal();
    }
  }

  // Função que gera o arquivo PDF temporário e abre o compartilhamento do celular
  Future<void> _exportarECompartilharPdf(String classificacao) async {
    final docPdf = GeradorPdf.criarDocumento(widget.nomeDoTeste, _pontuacaoTotal, classificacao);
    final bytes = await docPdf.save();
    
    final diretorioTemporario = await getTemporaryDirectory();
    final caminhoArquivo = '${diretorioTemporario.path}/Relatorio_Triagem.pdf';
    final arquivo = File(caminhoArquivo);
    await arquivo.writeAsBytes(bytes);

    await Share.shareXFiles([XFile(caminhoArquivo)], text: 'Segue o relatório de triagem do NeuroApp.');
  }

  void _exibirResultadoFinal() {
    String classificacao = '';
    if (widget.nomeDoTeste.contains('M-CHAT')) {
      if (_pontuacaoTotal <= 2) classificacao = 'Risco Baixo.';
      else if (_pontuacaoTotal <= 7) classificacao = 'Risco Moderado.';
      else classificacao = 'Risco Alto.';
    } else if (widget.nomeDoTeste.contains('CARS')) {
      if (_pontuacaoTotal < 30) classificacao = 'Sem Autismo (Abaixo do ponto de corte).';
      else if (_pontuacaoTotal < 37) classificacao = 'Autismo Leve a Moderado.';
      else classificacao = 'Autismo Grave.';
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Triagem Concluída', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(
            'Pontuação total obtida: $_pontuacaoTotal pontos.\n\nClassificação: $classificacao\n\nEste resultado serve como um rastreio inicial clínico ou educacional.',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            // NOVO BOTÃO DE EXPORTAR PDF
            TextButton.icon(
              icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
              label: const Text('Exportar PDF', style: TextStyle(color: Colors.red, fontSize: 16)),
              onPressed: () => _exportarECompartilharPdf(classificacao),
            ),
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

  Widget _construirBotaoNumerico(String texto, double valor, List<String> totalPerguntas) {
    return SizedBox(
      width: 70,
      height: 50,
      child: OutlinedButton(
        onPressed: () {
          _pontuacaoTotal += valor;
          _proximaEtapa(totalPerguntas);
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.deepPurple),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          texto,
          style: const TextStyle(fontSize: 16, color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
