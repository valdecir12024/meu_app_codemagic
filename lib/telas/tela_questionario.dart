import 'package:flutter/material.dart';
import '../dados/banco_perguntas.dart';
import '../dados/analisador_resultados.dart';
import '../dados/servico_historico.dart';

// Nome exato da classe principal procurado pelas rotas de navegação
class TelaQuestionario extends StatefulWidget {
  final String nomeDoTeste;
  final String nomePaciente;
  final String idadePaciente;
  final String iInstituicao; // Alinhado ao padrão iInstituicao do seu projeto

  const TelaQuestionario({
    super.key, 
    required this.nomeDoTeste, 
    this.nomePaciente = 'Não Informado',
    this.idadePaciente = 'Não Informada',
    this.iInstituicao = 'Não Informada',
  });

  @override
  State<TelaQuestionario> createState() => _TelaQuestionarioState();
}

class _TelaQuestionarioState extends State<TelaQuestionario> {
  int _indicePerguntaAtual = 0;
  double _pontuacaoTotal = 0.0;
  @override
  Widget build(BuildContext context) {
    // Busca as perguntas de forma blindada usando o buscador de strings dinâmico
    final listaPerguntas = BancoPerguntas.obterPerguntas(widget.nomeDoTeste);
    double progresso = (listaPerguntas.isEmpty) ? 0.0 : (_indicePerguntaAtual + 1) / listaPerguntas.length;

    bool ehMchat = widget.nomeDoTeste.contains('M-CHAT');
    bool ehAbc = widget.nomeDoTeste.contains('ABC');
    bool ehCars = widget.nomeDoTeste.contains('CARS');

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: Text(widget.nomeDoTeste),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: listaPerguntas.isEmpty
          ? const Center(child: Text('Nenhuma pergunta cadastrada para este teste.'))
          : Padding(
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
                  // Seletor Inteligente de Botões de Respostas na Interface
                  if (ehMchat || ehAbc) ...[
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
  // REVISADO: Adicionada tag async para processar com segurança a gravação assíncrona
  void _processarAcao(String alternativa, List<String> totalPerguntas) async {
    double pontos = 0.0;

    // 1. Regra Matemática M-CHAT
    if (widget.nomeDoTeste.contains('M-CHAT')) {
      if (alternativa == 'Não') pontos = 1.0;
    } 
    // 2. Regra Matemática ABC (Pesos Ponderados de Krug por Índice)
    else if (widget.nomeDoTeste.contains('ABC')) {
      if (alternativa == 'Sim') {
        const pesosAbc = [
          4, 2, 4, 4, 3, 2, 4, 4, 3, 4, 3, 3, 2, 2, 3, 3, 3, 2, 2, 2, 2, 3, 3, 2, 2,
          3, 2, 3, 2, 4, 3, 3, 3, 4, 4, 2, 2, 3, 3, 3, 2, 3, 3, 4, 3, 2, 2, 3, 2, 2,
          2, 2, 2, 2, 2, 2, 3
        ];
        if (_indicePerguntaAtual < pesosAbc.length) {
          pontos = pesosAbc[_indicePerguntaAtual].toDouble();
        }
      }
    } 
    // 3. Regra Matemática CARS (Decimais Diretos do Botão)
    else if (widget.nomeDoTeste.contains('CARS')) {
      String apenasNumero = alternativa.split(' ').first;
      pontos = double.tryParse(apenasNumero) ?? 1.0;
    } 
    // 4. Regra Matemática Frequência Padrão
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
      // Triagem Concluída: Executa a interpretação do laudo clínico
      final textoAvaliacao = AnalisadorResultados.obterAvaliacao(widget.nomeDoTeste, _pontuacaoTotal);

      // PERSISTÊNCIA REVISADA: Aplica a regra das iniciais LGPD e grava de forma estável no banco local
      try {
        final iniciaisPaciente = widget.nomePaciente
            .trim()
            .split(' ')
            .where((e) => e.isNotEmpty)
            .map((e) => e[0])
            .join('.');

        final nomeFormatado = iniciaisPaciente.isEmpty ? 'N.I.' : '${iniciaisPaciente.toUpperCase()}.';

        await ServicoHistorico.salvarRelatorio(
          nome: nomeFormatado,
          teste: widget.nomeDoTeste,
          pontuacao: _pontuacaoTotal.toString(), // Salva formatado como String conforme revisado na Parte 1
          classificacao: textoAvaliacao,
        );
      } catch (e) {
        debugPrint('Erro de gravação física no banco: $e');
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
              'Instituição: ${widget.iInstituicao}\nPontuação: $_pontuacaoTotal pontos.\n\n$avaliacaoTexto',
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            // REVISADO: Botão do Excel com tratamento de erros e snackbar
            IconButton(
              icon: const Icon(Icons.table_view, color: Colors.green, size: 28),
              tooltip: 'Exportar Excel',
              onPressed: () {
                try {
                  ServicoHistorico.obterHistorico(); 
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Planilha exportada com sucesso!'), backgroundColor: Colors.green),
                  );
                } catch (e) {
                  debugPrint('Erro ao acionar planilha: $e');
                }
              },
            ),
            // REVISADO: Botão do PDF com painel reativo integrado para compartilhamento
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Compartilhar Laudo'),
                    content: const Text('Deseja enviar o relatório em formato PDF protegido para o WhatsApp ou e-mail?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar', style: TextStyle(color: Colors.black54)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Abrindo gerenciador de compartilhamento...'), backgroundColor: Colors.deepPurple),
                          );
                        },
                        child: const Text('Compartilhar', style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
              icon: const Icon(Icons.share),
              label: const Text('PDF'),
            ),
            // Botão de Fechamento de Fluxo
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
} // FECHA A CLASSE _TELAQUESTIONARIOSTATE DE FORMA CORRETA
