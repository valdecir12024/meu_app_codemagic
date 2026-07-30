class AnalisadorResultados {
  static String obtenerAvaliacao(String nomeDoTeste, double pontuacao) {
    if (nomeDoTeste.contains('M-CHAT')) {
      if (pontuacao <= 2) {
        return 'Nível de Risco: BAIXO.\n\nA pontuação indica baixo risco para TEA. Recomenda-se acompanhamento de rotina do desenvolvimento.';
      } else if (pontuacao <= 7) {
        return 'Nível de Risco: MODERADO.\n\nA pontuação indica risco moderado. Sugere-se monitoramento e acompanhamento.';
      } else {
        return 'Nível de Risco: ALTO.\n\nA pontuação indica alto risco para TEA. É altamente recomendável encaminhar para avaliação especializada.';
      }
    }

    if (nomeDoTeste.contains('CARS')) {
      if (pontuacao < 30) {
        return 'Resultado CARS: ABAIXO DO PONTO DE CORTE (Não-Autista).\n\nA pontuação total ficou abaixo de 30 pontos, indicando que o indivíduo não se enquadra nos critérios clínicos da escala.';
      } else if (pontuacao <= 36.5) {
        return 'Resultado CARS: AUTISMO LEVE A MODERADO.\n\nA pontuação entre 30 e 36.5 indica a presença de sintomas de autismo em grau leve ou moderado. Recomendado acompanhamento multiprofissional.';
      } else {
        return 'Resultado CARS: AUTISMO GRAVE.\n\nA pontuação acima de 37 indica forte presença de marcadores comportamentais severos de autismo. Encaminhamento clínico prioritário.';
      }
    }

    if (nomeDoTeste.contains('ASRS-18') || nomeDoTeste.contains('SNAP-IV')) {
      if (pontuacao >= 12) {
        return 'Resultado: ACIMA DO PONTO DE CORTE.\n\nA pontuação sugere uma presença significativa de sintomas clássicos de TDAH. Recomendável investigação clínica.';
      } else {
        return 'Resultado: DENTRO DA NORMALIDADE.\n\nSintomas relatados abaixo do ponto de corte.';
      }
    }

    return 'Triagem Concluída.\n\nResultado gerado com sucesso para fins de triagem inicial.';
  }
}
