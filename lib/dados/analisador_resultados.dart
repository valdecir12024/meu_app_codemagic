class AnalisadorResultados {
  static String obterAvaliacao(String nomeDoTeste, num pontuacao) {
    // 1. ESCALAS DE NEURO (AUTISMO E TRIAGENS)
    if (nomeDoTeste.contains('M-CHAT')) {
      if (pontuacao <= 2) return 'Risco: BAIXO.\n\nIndicativo de desenvolvimento típico. Manter acompanhamento de rotina.';
      if (pontuacao <= 7) return 'Risco: MODERADO.\n\nSugerido aplicar os itens de seguimento ou monitoramento clínico em 3 meses.';
      return 'Risco: ALTO.\n\nMarcadores de risco severos para TEA. Encaminhar para avaliação diagnóstica especializada.';
    }

    if (nomeDoTeste.contains('CARS')) {
      if (pontuacao < 30) return 'Resultado: Sem Autismo.\n\nPontuação abaixo do ponto de corte.';
      if (pontuacao <= 36.5) return 'Resultado: Autismo Leve a Moderado.\n\nIndica sintomas presentes em grau manejável. Recomenda-se acompanhamento.';
      return 'Resultado: Autismo Grave.\n\nSintomas severos e impactantes. Encaminhamento clínico prioritário.';
    }

    if (nomeDoTeste.contains('ATA')) {
      if (pontuacao >= 15) return 'Resultado: ACIMA DO PONTO DE CORTE (Positivo).\n\nPresença significativa de traços autísticos (ATA >= 15). Recomendado encaminhamento neurológico.';
      return 'Resultado: ABAIXO DO PONTO DE CORTE.\n\nTraços autísticos dentro do esperado para triagem populacional.';
    }

    if (nomeDoTeste.contains('ABC')) {
      if (pontuacao >= 68) return 'Resultado: Alta Probabilidade de TEA.\n\nPontuação severa (ABC >= 68). Recomendada intervenção multidisciplinar imediata.';
      if (pontuacao >= 54) return 'Resultado: Moderada Probabilidade de TEA.\n\nSintomas limítrofes. Necessita de investigação clínica aprofundada.';
      return 'Resultado: Baixa Probabilidade.\n\nComportamentos típicos dentro do checklist avaliado.';
    }

    if (nomeDoTeste.contains('Atenção Visual')) {
      if (pontuacao >= 8) return 'Resultado: Alerta de Desatenção.\n\nAlto índice de distratibilidade visual. Sugere-se adaptação ambiental escolar.';
      return 'Resultado: Desempenho Típico.\n\nFoco e sustentação visual dentro da normalidade.';
    }

    if (nomeDoTeste.contains('Memória')) {
      if (pontuacao <= 3) return 'Resultado: Alerta de Retenção.\n\nDificuldade em evocar instruções de curto prazo. Sugere-se treino cognitivo.';
      return 'Resultado: Retenção Adequada.\n\nMemória operacional funcionando dentro do esperado.';
    }

    // Encaminha as demais escalas para a segunda parte da função auxiliar
    return _obterAvaliacaoParte2(nomeDoTeste, pontuacao);
  }

  static String _obterAvaliacaoParte2(String nomeDoTeste, num pontuacao) {
    // 2. ESCALAS DE COMPORTAMENTO E TDAH
    if (nomeDoTeste.contains('ASRS-18') || nomeDoTeste.contains('SNAP-IV')) {
      if (pontuacao >= 12) return 'Resultado: ACIMA DO PONTO DE CORTE.\n\nIndicativo forte de sintomas clássicos de TDAH. Recomendável investigação clínica.';
      return 'Resultado: Dentro da Normalidade.\n\nSintomas abaixo do limiar de triagem.';
    }

    if (nomeDoTeste.contains('Conners')) {
      if (pontuacao >= 15) return 'Resultado: Alerta Comportamental.\n\nMarcadores de conduta, oposição ou impulsividade elevados. Sugere-se orientação parental.';
      return 'Resultado: Conduta Adequada.\n\nComportamento social e adaptativo dentro da média.';
    }

    // ADICIONADA: Regra oficial para a Escala Basic 3
    if (nomeDoTeste.contains('Basic 3')) {
      if (pontuacao < 10) {
        return 'Resultado Basic 3: ALERTA NO DESENVOLVIMENTO.\n\nA pontuação total ficou abaixo do esperado para a faixa etária. Recomendada triagem neuropsicológica complementar.';
      } else {
        return 'Resultado Basic 3: DESENVOLVIMENTO ADEQUADO.\n\nAs competências básicas avaliadas encontram-se dentro dos marcos de desenvolvimento esperados.';
      }
    }

    // 3. ESCALAS SOCIOEMOCIONAIS E ANSIEDADE
    if (nomeDoTeste.contains('SDQ')) {
      if (pontuacao >= 17) return 'Resultado: Perfil Clínico/Anormal.\n\nEscore total de dificuldades elevado (SDQ >= 17). Necessita de suporte psicoterapêutico.';
      if (pontuacao >= 14) return 'Resultado: Perfil Limítrofe.\n\nZona de atenção. Recomendado monitoramento escolar e familiar.';
      return 'Resultado: Perfil Típico.\n\nEquilíbrio de forças e capacidades emocionais adequado.';
    }

    if (nomeDoTeste.contains('SCARED')) {
      if (pontuacao >= 25) return 'Resultado: Indicativo de Transtorno de Ansiedade.\n\nPontuação elevada (SCARED >= 25). Sugere-se avaliação psicológica para ansiedade/pânico.';
      return 'Resultado: Nível de Ansiedade Típico.\n\nReações emocionais normais para a faixa etária.';
    }

    // Garantindo o texto descritivo cirúrgico para a escala de Rosemberg
    if (nomeDoTeste.contains('Rosemberg')) {
      if (pontuacao <= 15) {
        return 'Resultado Rosemberg: AUTOESTIMA BAIXA.\n\nO escore indica a presença de sentimentos de desvalorização pessoal e insegurança. Recomendável suporte e acolhimento emocional.';
      } else {
        return 'Resultado Rosemberg: AUTOESTIMA SAUDÁVEL.\n\nPercepção de autovalorização positiva, segura e equilibrada.';
      }
    }

    return 'Triagem Concluída.\n\nDados computados com sucesso para o relatório do paciente.';
  }
}
