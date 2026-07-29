  void _exibirResultadoFinal() {
    String recomendacao = '';
    bool ehMchat = widget.nomeDoTeste.contains('M-CHAT');
    bool ehCars = widget.nomeDoTeste.contains('CARS');
    bool ehAsrs = widget.nomeDoTeste.contains('ASRS');
    bool ehAta = widget.nomeDoTeste.contains('ATA');
    bool ehAbc = widget.nomeDoTeste.contains('ABC');

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
    } else {
      recomendacao = 'Triagem concluída. Avalie a pontuação de acordo com os critérios específicos do manual desta escala.';
    }

    // AQUI ESTÁ A CORREÇÃO: Removidos os 'const' inválidos e corrigido o 'this.context' para 'context'
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
                Navigator.pop(context); // Fecha o AlertDialog de forma limpa
                Navigator.pop(context); // Fecha a tela do teste de forma limpa
              },
              child: const Text('Concluir', style: TextStyle(color: Colors.deepPurple, fontSize: 16)),
            ),
          ],
        );
      },
    );
  }
