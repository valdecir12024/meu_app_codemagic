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
    // 4. DIRETRIZES DA ESCALA ICU (TRAÇOS INSENSÍVEIS E FRIOS)
    if (nomeDoTeste.contains('ICU')) {
      if (pontuacao >= 25) {
        return 'Resultado ICU: RISCO ELEVADO.\n\nEscore indica presença marcante de traços de insensibilidade emocional e rigidez comportamental. Recomendado acompanhamento psicológico focado em empatia e habilidades sociais.';
      } else {
        return 'Resultado ICU: DESENVOLVIMENTO TÍPICO.\n\nEscore dentro dos padrões esperados para a faixa etária. Manter monitoramento regular de conduta.';
      }
    }

    // 5. DIRETRIZES DA ESCALA CRIES-13 (ESTRESSE PÓS-TRAUMÁTICO)
    if (nomeDoTeste.contains('CRIES-13')) {
      if (pontuacao >= 30) {
        return 'Resultado CRIES-13: INDICATIVO DE ESTRESSE PÓS-TRAUMÁTICO (TEPT).\n\nPontuação severa (CRIES >= 30). Presença crítica de pensamentos intrusivos e comportamentos de esquiva. Encaminhar para intervenção psicológica especializada imediatamente.';
      } else {
        return 'Resultado CRIES-13: RISCO BAIXO.\n\nSintomas de estresse ou trauma abaixo do ponto de corte clínico.';
      }
    }

    // 6. DIRETRIZES DA ESCALA IAT (DEPENDÊNCIA DE INTERNET)
    if (nomeDoTeste.contains('IAT')) {
      if (pontuacao >= 31) {
        return 'Resultado IAT: DEPENDÊNCIA CRÍTICA DA INTERNET.\n\nUso problemático e abusivo de telas com prejuízos severos na rotina de sono e estudo. Recomendada orientação familiar e reestruturação de rotina com suporte terapêutico.';
      } if (pontuacao >= 15) {
        return 'Resultado IAT: USO MODERADO / ALERTA.\n\nZona de atenção. Apresenta sinais iniciais de distração digital. Sugere-se estabelecer limites saudáveis de tempo de tela.';
      }
      return 'Resultado IAT: USO SAUDÁVEL.\n\nUtilização de internet e telas dentro dos limites adaptativos.';
    }

    // 7. DIRETRIZES DA ESCALA MBI (INVENTÁRIO DE BURNOUT)
    if (nomeDoTeste.contains('MBI')) {
      if (pontuacao >= 22) {
        return 'Resultado MBI: INDICATIVO DE SÍNDROME DE BURNOUT.\n\nEscore aponta exaustão emocional severa e esgotamento associado à rotina. Recomendado suporte e acompanhamento de saúde mental.';
      } else {
        return 'Resultado MBI: PERFIL DE ENGAJAMENTO SAUDÁVEL.\n\nNíveis de estresse e cansaço dentro dos parâmetros ocupacionais toleráveis.';
      }
    }
    // 8. DIRETRIZES DA ESCALA CFQ (FALHAS COGNITIVAS)
    if (nomeDoTeste.contains('CFQ')) {
      if (pontuacao >= 20) {
        return 'Resultado CFQ: ALERTA DE FALHAS COGNITIVAS.\n\nAlto índice de esquecimentos na rotina diária, lapsos de atenção e distratibilidade operacional. Sugere-se investigação neurológica ou treino cognitivo.';
      } else {
        return 'Resultado CFQ: DESEMPENHO OPERACIONAL ADEQUADO.\n\nMemória e atenção executiva funcionando dentro dos padrões esperados.';
      }
    }
    // 9. DIRETRIZES DA ESCALA MSI-BPD (TRAÇOS DE PERSONALIDADE)
    if (nomeDoTeste.contains('MSI-BPD')) {
      if (pontuacao >= 7) {
        return 'Resultado MSI-BPD: MARCADOR DE ALERTA DE PERSONALIDADE.\n\nEscore igual ou maior que 7 aponta forte presença de traços de instabilidade emocional acentuada. Recomendado encaminhamento para avaliação especializada com psiquiatra ou psicólogo clínico.';
      } else {
        return 'Resultado MSI-BPD: PERFIL DENTRO DA NORMALIDADE.\n\nSintomas de instabilidade afetiva ou impulsividade abaixo do limiar de triagem.';
      }
    }

    // 10. DIRETRIZES DA ESCALA CRAFFT 2.1 (RASTREIO DE SUBSTÂNCIAS)
    if (nomeDoTeste.contains('CRAFFT')) {
      if (pontuacao >= 2) {
        return 'Resultado CRAFFT 2.1: RASTREIO POSITIVO (RISCO ELEVADO).\n\nPontuação indica risco significativo associado ao uso de substâncias. Necessita de intervenção breve, orientação e encaminhamento especializado.';
      } else {
        return 'Resultado CRAFFT 2.1: BAIXO RISCO.\n\nNenhum padrão de uso nocivo identificado nesta triagem inicial.';
      }
    }

    // 11. DIRETRIZES DO CHECKLIST DE VITIMIZAÇÃO (BULLYING)
    if (nomeDoTeste.contains('Vitimização')) {
      if (pontuacao >= 12) {
        return 'Resultado: ALERTA CRÍTICO DE CONVIVÊNCIA ESCOLAR.\n\nEscore aponta alto índice de vitimização por bullying ou cyberbullying. Exige intervenção imediata da gestão escolar, acolhimento psicopedagógico e orientação familiar.';
      } else {
        return 'Resultado: AMBIENTE DE CONVIVÊNCIA DENTRO DO ESPERADO.\n\nIndicadores de vitimização pontuais ou abaixo do nível de alerta institucional.';
      }
    }

    // 12. DIRETRIZES DO INVENTÁRIO BIG FIVE (PERSONALIDADE)
    if (nomeDoTeste.contains('Big Five')) {
      return 'Resultado Big Five: PERFIL COMPUTADO COM SUCESSO.\n\nAs tendências de Extroversão, Amabilidade, Conscienciosidade, Estabilidade Emocional e Abertura foram mapeadas para o relatório descritivo completo.';
    }

    return 'Triagem Concluída.\n\nDados computados com sucesso para o relatório do paciente.';
  }
}
