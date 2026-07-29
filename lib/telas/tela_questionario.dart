import 'package:flutter/material.dart';
import '../dados/banco_perguntas.dart';
import '../servicos/servico_pdf.dart';

class TelaQuestionario extends StatefulWidget {
  final String nomeDoTeste;
  const TelaQuestionario({super.key, required this.nomeDoTeste});

  @override
  State<TelaQuestionario> createState() => _TelaQuestionarioState();
}

class _TelaQuestionarioState extends State<TelaQuestionario> {
  int _indicePerguntaAtual = 0;
  double _pontuacaoTotal = 0.0; // Mudado para double porque a CARS aceita frações
  final TextEditingController _iniciaisController = TextEditingController();
  bool _testeIniciado = false;

  @override
  Widget build(BuildContext context) {
    final listaPerguntas = BancoPerguntas.triagens[widget.nomeDoTeste] ?? 
        ['Nenhuma pergunta cadastrada para este teste inicial.'];

    double progresso = (_indicePerguntaAtual + 1) / listaPerguntas.length;
    bool ehMchat = widget.nomeDoTeste.contains('M-CHAT');
    bool ehCars = widget.nomeDoTeste.contains('CARS');

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
            
            // RENDEREZIZAÇÃO CONDICIONAL BASEADA NA ESCALA SELECIONADA
            if (ehMchat) ...[
              _construirOpcaoResposta('Sim', () => _processarRespostaMchat(true, listaPerguntas)),
              _construirOpcaoResposta('Não', () => _processarRespostaMchat(false, listaPerguntas)),
            ] else if (ehCars) ...[
              // Botões customizados com pontuações clínicas de 1 a 4 da CARS
              _construirOpcaoResposta('Nota 1: Dentro dos limites da normalidade', () => _processarRespostaPadrao(1.0, totalPerguntas: listaPerguntas)),
              _construirOpcaoResposta('Nota 2: Autismo levemente anormal / Leve', () => _processarRespostaPadrao(2.0, totalPerguntas: listaPerguntas)),
              _construirOpcaoResposta('Nota 3: Autismo moderadamente anormal / Moderado', () => _processarRespostaPadrao(3.0, totalPerguntas: listaPerguntas)),
              _construirOpcaoResposta('Nota 4: Autismo gravemente anormal / Grave', () => _processarRespostaPadrao(4.0, totalPerguntas: listaPerguntas)),
            ] else ...[
              _construirOpcaoResposta('Nunca', () => _processarRespostaPadrao(0.0, totalPerguntas: listaPerguntas)),
              _construirOpcaoResposta('Raramente', () => _processarRespostaPadrao(1.0, totalPerguntas: listaPerguntas)),
              _construirOpcaoResposta('Às vezes', () => _processarRespostaPadrao(2.0, totalPerguntas: listaPerguntas)),
              _construirOpcaoResposta('Frequentemente', () => _processarRespostaPadrao(3.0, totalPerguntas: listaPerguntas)),
              _construirOpcaoResposta('Sempre', () => _processarRespostaPadrao(4.0, totalPerguntas: listaPerguntas)),
            ],
          ],
        ),
      ),
    );
  }

  void _processarRespostaMchat(bool respondeuSim, List<String> totalPerguntas) {
    int numeroPergunta = _indicePerguntaAtual + 1;
    bool pontuaNoSim = (numeroPergunta == 2 || numeroPergunta == 5 || numeroPergunta == 12);
    double pontos = 0.0;

    if (pontuaNoSim && respondeuSim) pontos = 1.0;
    if (!pontuaNoSim && !respondeuSim) pontos = 1.0;

    _pontuacaoTotal += pontos;
    _avancarOuFinalizar(totalPerguntas);
  }

  void _processarRespostaPadrao(double pontos, {required List<String> totalPerguntas}) {
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

    void _exibirResultadoFinal() {
    String recomendacao = '';
    bool ehMchat = widget.nomeDoTeste.contains('M-CHAT');
    bool ehCars = widget.nomeDoTeste.contains('CARS');
    bool ehAsrs = widget.nomeDoTeste.contains('ASRS');
    bool ehAta = widget.nomeDoTeste.contains('ATA');
    bool ehAbc = widget.nomeDoTeste.contains('ABC');
    bool ehAtencao = widget.nomeDoTeste.contains('Atenção');
    bool ehMemoria = widget.nomeDoTeste.contains('Memória');
    bool ehSnap = widget.nomeDoTeste.contains('SNAP');
    bool ehConners = widget.nomeDoTeste.contains('Conners');
    bool ehVanderbilt = widget.nomeDoTeste.contains('Vanderbilt');
    bool ehSdq = widget.nomeDoTeste.contains('SDQ');
    bool ehScared = widget.nomeDoTeste.contains('SCARED');
    bool ehRosenberg = widget.nomeDoTeste.contains('Rosenberg');

    if (ehMchat) {
      if (_pontuacaoTotal <= 2) {
        recomendacao = 'RISCO BAIXO.\nContinue acompanhando o desenvolvimento.';
      } else if (_pontuacaoTotal <= 7) {
        recomendacao = 'RISCO MÉDIO.\nRecomenda-se aplicar a entrevista de seguimento ou avaliação detalhada.';
      } else {
        recomendacao = 'RISCO ALTO.\nEncaminhamento imediato para avaliação diagnóstica especializada.';
      }
    } else if (ehCars) {
      if (_pontuacaoTotal < 30) {
        recomendacao = 'PONTUAÇÃO ABAIXO DO PONTO DE CORTE.\nDesenvolvimento dentro dos limites de normalidade estrutural para autismo.';
      } else if (_pontuacaoTotal <= 36.5) {
        recomendacao = 'GRAU DE AUTISMO: LEVE A MODERADO.\nIndica presença de sintomas compatíveis com TEA de nível leve ou moderado.';
      } else {
        recomendacao = 'GRAU DE AUTISMO: GRAVE.\nSintomas severos. Recomendável plano intensivo de terapia e acompanhamento especializado.';
      }
    } else if (ehAsrs) {
      if (_pontuacaoTotal >= 24) {
        recomendacao = 'SINAL DE ALERTA PARA TDAH SINALIZADO.\nA pontuação total indica uma frequência elevada de sintomas. Recomenda-se encaminhamento para avaliação detalhada.';
      } else {
        recomendacao = 'RASTREIO DENTRO DA NORMALIDADE.\nSintomas abaixo do ponto de corte epidemiológico para TDAH.';
      }
    } else if (ehAta) {
      if (_pontuacaoTotal >= 15) {
        recomendacao = 'SINAL DE ALERTA POSITIVO PARA TRAÇOS AUTÍSTICOS.\nA pontuação total atingiu ou superou o ponto de corte clínico (>= 15 pontos). Recomenda-se fortemente o encaminhamento para avaliação diagnóstica especializada.';
      } else {
        recomendacao = 'RASTREIO ABAIXO DO PONTO DE CORTE CLÍNICO.\nA pontuação indica presença de traços abaixo do limite de triagem epidemiológica.';
      }
    } else if (ehAbc) {
      if (_pontuacaoTotal < 47) {
        recomendacao = 'BAIXA PROBABILIDADE DE AUTISMO.\nSintomas abaixo do ponto de corte epidemiológico estrutural da escala ABC.';
      } else if (_pontuacaoTotal <= 53) {
        recomendacao = 'RESULTADO LIMÍTROFE / DUVIDOSO.\nPontuação na zona cinzenta de diagnóstico. Recomenda-se acompanhamento longitudinal e reavaliação em 6 meses.';
      } else if (_pontuacaoTotal <= 67) {
        recomendacao = 'PROBABILIDADE MODERADA DE TEA.\nIndícios comportamentais moderados compatíveis com o espectro. Encaminhar para avaliação clínica interdisciplinar.';
      } else {
        recomendacao = 'ALTA PROBABILIDADE DE AUTISMO.\nSintomas severos e altamente indicativos de TEA. Necessário encaminhamento imediato para neuropediatra ou psiquiatra infantil.';
      }
    } else if (ehAtencao) {
      if (_pontuacaoTotal >= 18) {
        recomendacao = 'SINAL DE ALERTA PARA DÉFICIT DE ATENÇÃO.\nA pontuação indica um padrão de desatenção visual significativamente superior à média esperada. Sugere-se investigação pedagógica ou clínica neuropsicológica.';
      } else {
        recomendacao = 'PONTUAÇÃO DE ATENÇÃO NORMAL.\nNível de foco dentro dos parâmetros típicos.';
      }
    } else if (ehMemoria) {
      if (_pontuacaoTotal >= 14) {
        recomendacao = 'SINAL DE ALERTA PARA SOBRECARGA DE MEMÓRIA DE TRABALHO.\nPontuação elevada sugerindo dificuldades na retenção imediata de dados.';
      } else {
        recomendacao = 'MEMÓRIA DE CURTO PRAZO DENTRO DA NORMALIDADE.\nCapacidade adaptativa estável.';
      }
    } else if (ehSnap) {
      if (_pontuacaoTotal >= 23) {
        recomendacao = 'SINAL DE ALERTA SINALIZADO PELO SNAP-IV.\nA pontuação acumulada indica presença significativa de sintomas associados à desatenção ou hiperatividade.';
      } else {
        recomendacao = 'RESULTADO DENTRO DA PARIDADE POPULACIONAL NO SNAP-IV.';
      }
    } else if (ehConners) {
      if (_pontuacaoTotal >= 20) {
        recomendacao = 'SINAL DE ALERTA ATIVO (CONNERS-3).\nIndicadores elevados de comportamentos de oposição ou dificuldades de conduta.';
      } else {
        recomendacao = 'ESCALA CONNERS-3 DENTRO DA NORMALIDADE.';
      }
    } else if (ehVanderbilt) {
      if (_pontuacaoTotal >= 22) {
        recomendacao = 'SINAL DE ALERTA PARA COMPORTAMENTO ESCOLAR (VANDERBILT).\nPontuação indica dificuldades de regulação executiva em sala de aula.';
      } else {
        recomendacao = 'ESCALA VANDERBILT DENTRO DOS PADRÕES TÍPICOS.';
      }
    } else if (ehSdq) {
      if (_pontuacaoTotal >= 14) {
        recomendacao = 'SINAL DE ALERTA EMOCIONAL/CONDUTA (SDQ).\nA pontuação total indica sofrimento emocional ou dificuldades de relacionamento acima da média populacional. Recomendável suporte psicopedagógico.';
      } else {
        recomendacao = 'ESCALA SDQ DENTRO DA NORMALIDADE.\nEquilíbrio adaptativo socioemocional e relacional estável.';
      }
    } else if (ehScared) {
      if (_pontuacaoTotal >= 12) {
        recomendacao = 'SINAL DE ALERTA PARA SINTOMAS DE ANSIEDADE (SCARED).\nA pontuação sugere indicadores elevados de ansiedade de separação, fobia social ou nervosismo. Indicado acompanhamento psicológico inicial.';
      } else {
        recomendacao = 'RASTREIO DE ANSIEDADE NORMAL.\nSintomas regulatórios dentro dos parâmetros comportamentais saudáveis.';
      }
    } else if (ehRosenberg) {
      if (_pontuacaoTotal < 15) {
        recomendacao = 'SINAL DE ALERTA PARA BAIXA AUTOESTIMA (ROSENBERG).\nA pontuação indica fragilidade na percepção de valor próprio e segurança emocional. Recomenda-se reforço de intervenções de suporte psicopedagógico ou terapia.';
      } else {
        recomendacao = 'AUTOESTIMA SAUDÁVEL / ESTÁVEL.\nPercepção positiva de qualidades e autovalorização consolidada.';
      }
    } else {
      recomendacao = 'Triagem concluída. Avalie a pontuação de acordo com os critérios específicos do manual desta escala.';
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resultado: ${_iniciaisController.text}', style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Pontuação total: $_pontuacaoTotal pontos.\n\nDiretriz Clínica:\n$recomendacao', style: const TextStyle(fontSize: 16)),
          actions: [
          // NOVO BOTÃO: Gerar Relatório em PDF
            TextButton.icon(
              icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
              label: const Text('Gerar Laudo PDF', style: TextStyle(color: Colors.red, fontSize: 16)),
              onPressed: () {
                // Chama o motor do PDF injetando os dados reais da triagem atual
                ServicoPdf.gerarECompartilharLaudo(
                  iniciaisPaciente: _iniciaisController.text,
                  nomeDoTeste: widget.nomeDoTeste,
                  pontuacao: _pontuacaoTotal,
                  recomendacao: recomendacao,
                );
              },
            ),
          // Botão tradicional de fechar
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); 
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
