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
    // 13. DIRETRIZES DA ESCALA HADS (ANSIEDADE E DEPRECÃO)
    if (nomeDoTeste.contains('HADS')) {
      if (pontuacao >= 11) {
        return 'Resultado HADS: INDICATIVO CLÍNICO DE ALERTA.\n\nEscore aponta níveis elevados e críticos de sintomas ansiosos ou depressivos. Recomendável encaminhamento para avaliação especializada em saúde mental.';
      } if (pontuacao >= 8) {
        return 'Resultado HADS: CASO LIMÍTROFE (ZONA DE ATENÇÃO).\n\nSintomas em nível moderado. Sugere-se monitoramento preventivo e suporte emocional inicial.';
      }
      return 'Resultado HADS: DENTRO DA NORMALIDADE.\n\nIndicadores de ansiedade e depressão dentro dos parâmetros típicos esperados.';
    }

    // 14. DIRETRIZES DO PROTOCOLO GIFTS (ALTAS HABILIDADES)
    if (nomeDoTeste.contains('GIFTS')) {
      if (pontuacao >= 5) {
        return 'Resultado GIFTS: MARCADOR DE ALTAS HABILIDADES / SUPERDOTAÇÃO (AH/SD).\n\nForte indicativo de potencial superior e criatividade avançada. Recomendado enriquecimento curricular e acompanhamento psicopedagógico especializado.';
      } else {
        return 'Resultado GIFTS: DESENVOLVIMENTO DENTRO DO ESPERADO.\n\nCompetências e marcos cognitivos acompanham a média típica para a faixa etária.';
      }
    }

    // 15. DIRETRIZES DA TRIAGEM DE DISLEXIA
    if (nomeDoTeste.contains('Dislexia')) {
      if (pontuacao >= 6) {
        return 'Resultado: RASTREIO POSITIVO PARA TRAÇOS DE DISLEXIA.\n\nEscore aponta marcadores significativos de dificuldade na leitura, escrita e processamento fonológico. Recomendado encaminhamento para avaliação fonoaudiológica e neuropsicopedagógica.';
      } else {
        return 'Resultado: DESEMPENHO EM LEITURA DENTRO DO ESPERADO.\n\nHabilidades de processamento de escrita e leitura operando sem sinais de alerta clínicos.';
      }
    }

    // 16. DIRETRIZES DA TRIAGEM EAT (TRANSTORNOS ALIMENTARES)
    if (nomeDoTeste.contains('EAT')) {
      if (pontuacao >= 5) {
        return 'Resultado EAT: ALERTA CRÍTICO DE COMPORTAMENTO ALIMENTAR.\n\nEscore aponta forte indicativo de atitudes alimentares disfuncionais ou distorção de imagem. Recomendado acompanhamento preventivo com psicólogo e nutricionista.';
      } else {
        return 'Resultado EAT: PERFIL ALIMENTAR SAUDÁVEL.\n\nRelação com a alimentação e percepção corporal operando dentro da normalidade.';
      }
    }
    // 17. DIRETRIZES DO IGI (ÍNDICE DE GRATIDÃO INTEGRAL)
    if (nomeDoTeste.contains('IGI')) {
      if (pontuacao >= 21) {
        return 'Resultado IGI: ALTO ÍNDICE DE GRATIDÃO.\n\nEscore aponta excelente nível de percepção positiva, resiliência e bem-estar subjetivo. Indicador associado a uma saúde mental estável e protetiva.';
      } else {
        return 'Resultado IGI: ÍNDICE DE GRATIDÃO MODERADO/BAIXO.\n\nSugerido o desenvolvimento de práticas reflexivas para fortalecimento de bem-estar emocional e enfrentamento de estresse.';
      }
    }

    // 18. DIRETRIZES DO MDQ (RASTREIO DE TRANSTORNO DE HUMOR)
    if (nomeDoTeste.contains('MDQ')) {
      if (pontuacao >= 7) {
        return 'Resultado MDQ: ALERTA DE OSCILAÇÃO DE HUMOR ACIMA DO PONTO DE CORTE.\n\nEscore indica forte presença de sintomas de instabilidade energética ou oscilações cíclicas de humor. Altamente recomendada a avaliação especializada com médico psiquiatra.';
      } else {
        return 'Resultado MDQ: PERFIL DE HUMOR DENTRO DA NORMALIDADE.\n\nSintomas de oscilações ou impulsividade abaixo do limiar de alerta de triagem clínica.';
      }
    }

    // 19. DIRETRIZES DE IDEAÇÃO EROTOMANÍACA E APEGO BORDERLINE
    if (nomeDoTeste.contains('Erotomaníaca')) {
      if (pontuacao >= 6) {
        return 'Resultado: RISCO CRÍTICO DE IDEAÇÃO OBSESSIVA E APEGO DESADAPTATIVO.\n\nEscore aponta forte indicativo de fixações românticas ilusórias e padrões de instabilidade interpessoal severa. Exige encaminhamento imediato para psicoterapia clínica aprofundada.';
      } else {
        return 'Resultado: PADRÕES AFETIVOS DENTRO DA EXPECTATIVA.\n\nNão foram identificados sinais de alerta ou fixações obsessivas nesta triagem inicial.';
      }
    }

    // 20. DIRETRIZES DO CHECKLIST DE DISCALCULIA
    if (nomeDoTeste.contains('Discalculia')) {
      if (pontuacao >= 6) {
        return 'Resultado: RASTREIO POSITIVO PARA TRAÇOS DE DISCALCULIA.\n\nEscore aponta marcadores significativos de dificuldade no processamento numérico, senso numérico e habilidades matemáticas elementares. Recomendado acompanhamento psicopedagógico especializado.';
      } else {
        return 'Resultado: PROCESSAMENTO MATEMÁTICO DENTRO DO ESPERADO.\n\nHabilidades de cálculo e raciocínio lógico-matemático operando sem indicadores de alerta clínicos.';
      }
    }
    // === BLOCOS DE DIRETRIZES DA ABA ADULTO / EJA ===

    // 21. DIRETRIZES DA ESCALA ASRS-18 COMPLETA (TDAH ADULTO)
    if (nomeDoTeste.contains('ASRS-18')) {
      if (pontuacao >= 24) {
        return 'Resultado ASRS-18: FORTE INDICATIVO DE TDAH EM ADULTOS (RISCO ELEVADO).\n\nEscore aponta alta frequência de sintomas de desatenção e hiperatividade/impulsividade com impacto funcional. Altamente recomendada avaliação neuropsicológica ou psiquiátrica.';
      } if (pontuacao >= 18) {
        return 'Resultado ASRS-18: MARCADOR DE ATENÇÃO (RISCO MODERADO).\n\nPresença de sintomas limítrofes. Sugere-se adaptações ambientais, treino de foco e monitoramento preventivo.';
      }
      return 'Resultado ASRS-18: DENTRO DA NORMALIDADE.\n\nSintomas de desatenção e inquietude operando abaixo do limiar de triagem clínica.';
    }

    // 22. DIRETRIZES DO CHECKLIST DE DISLEXIA ADULTO
    if (nomeDoTeste.contains('Dislexia Adulto')) {
      if (pontuacao >= 6) {
        return 'Resultado: RASTREIO POSITIVO PARA TRAÇOS DE DISLEXIA EM ADULTOS.\n\nIndicadores apontam persistência de dificuldades crônicas em leitura silenciosa, escrita e processamento ortográfico. Recomendado suporte psicopedagógico focado na EJA.';
      } else {
        return 'Resultado: DESEMPENHO EM LEITURA DENTRO DO ESPERADO.\n\nHabilidades de processamento de escrita e leitura fluindo dentro dos parâmetros típicos.';
      }
    }

    // 23. DIRETRIZES DA ESCALA AQ-10 COMPLETA (AUTISMO ADULTO INICIAL)
    if (nomeDoTeste.contains('AQ-10')) {
      if (pontuacao >= 6) {
        return 'Resultado AQ-10: ALERTA DE TRAÇOS DO ESPECTRO AUTISTA.\n\nEscore igual ou maior que 6 indica necessidade de uma investigação clínica aprofundada para o espectro autista na vida adulta. Sugere-se encaminhamento especializado.';
      } else {
        return 'Resultado AQ-10: PERFIL DE RESPONSIVIDADE DENTRO DO ESPERADO.\n\nIndicadores de interação social e padrões comportamentais operando abaixo do ponto de corte.';
      }
    }

    // 24. DIRETRIZES DA ESCALA DE BURNOUT DE FREUDENBERGER
    if (nomeDoTeste.contains('Freudenberger')) {
      if (pontuacao >= 20) {
        return 'Resultado: RISCO CRÍTICO DE EXAUSTÃO EXECUTIVA (BURNOUT).\n\nEscore aponta forte sobrecarga decorrente da tripla jornada de trabalho, casa e estudos na EJA. Essencial intervenção focado na redução de estresse e suporte em saúde mental.';
      } else {
        return 'Resultado: NÍVEL DE ESTRESSE DENTRO DO TOLERÁVEL.\n\nIndicadores de cansaço mental ocupacional operando dentro dos parâmetros de normalidade.';
      }
    }
    // 25. DIRETRIZES DO INVENTÁRIO DE DEPRESSÃO DE BECK (BDI)
    if (nomeDoTeste.contains('Beck')) {
      if (pontuacao >= 21) {
        return 'Resultado BDI: INDICATIVO DE DISFORIA / DEPRESSÃO MODERADA A SEVERA.\n\nEscore aponta sofrimento psíquico acentuado com impactos diretos no humor, apetite e sono. Altamente recomendada avaliação especializada com psicólogo clínico ou médico psiquiatra.';
      } if (pontuacao >= 12) {
        return 'Resultado BDI: SINTOMATOLOGIA LEVE / ZONA DE ATENÇÃO.\n\nPresença de indicadores moderados de desânimo. Sugere-se escuta acolhedora, monitoramento de rotina e suporte inicial.';
      }
      return 'Resultado BDI: INDICE DE HUMOR DENTRO DA NORMALIDADE.\n\nIndicadores de estabilidade afetiva operando dentro dos parâmetros adaptativos esperados.';
    }

    // 26. DIRETRIZES DA TAS-20 COMPLETA (ALEXITIMIA)
    if (nomeDoTeste.contains('TAS-20')) {
      if (pontuacao >= 61) {
        return 'Resultado TAS-20: PRESENÇA MARCANTE DE ALEXITIMIA.\n\nEscore indica severa dificuldade na identificação, diferenciação e expressão verbal das próprias emoções e sentimentos. Recomendado suporte psicoterápico focado em regulação emocional.';
      } if (pontuacao >= 52) {
        return 'Resultado TAS-20: PERFIL LIMÍTROFE.\n\nZona de transição. Apresenta dificuldades moderadas ou pontuais em traduzir sensações corporais em termos emocionais.';
      }
      return 'Resultado TAS-20: CAPACIDADE ADAPTATIVA PRESERVADA.\n\nProcessamento e expressão emocional fluindo sem indicadores de alerta clínicos.';
    }

    // 27. DIRETRIZES DA CAT-Q COMPLETA (CAMUFLAGEM AUTÍSTICA)
    if (nomeDoTeste.contains('CAT-Q')) {
      if (pontuacao >= 70) {
        return 'Resultado CAT-Q: ALTO ÍNDICE DE CAMUFLAGEM SOCIAL (COMPENSAÇÃO).\n\nEscore aponta uso exaustivo de estratégias conscientes para imitar comportamentos e esconder dificuldades de interação. Comum em perfis subdiagnosticados (como o autismo feminino). Risco de esgotamento/burnout autístico.';
      } else {
        return 'Resultado CAT-Q: NÍVEL DE CAMUFLAGEM DENTRO DO ESPERADO.\n\nEstratégias de imitação social operando abaixo do limiar de sobrecarga crônica.';
      }
    }

    // 28. DIRETRIZES DA ESCALA AQ-50 COMPLETA (AUTISMO ADULTO)
    if (nomeDoTeste.contains('AQ-50')) {
      if (pontuacao >= 26) {
        return 'Resultado AQ-50: FORTE INDICATIVO DE TRAÇOS DO ESPECTRO AUTISTA (RISCO ELEVADO).\n\nEscore igual ou superior a 26 pontua significativamente nas subescalas de atenção a detalhes, comunicação e imaginação. Recomenda-se encaminhamento para investigação clínica especializada.';
      } else {
        return 'Resultado AQ-50: RASTREIO NEGATIVO.\n\nPadrões de comportamento e interação social operando dentro da variabilidade típica esperada.';
      }
    }
    // 29. DIRETRIZES DA ESCALA GQ-ASC COMPLETA (AUTISMO FEMININO)
    if (nomeDoTeste.contains('GQ-ASC')) {
      if (pontuacao >= 55) {
        return 'Resultado GQ-ASC: FORTE INDICATIVO DE NUANCES DO ESPECTRO AUTISTA (PERFIL FEMININO).\n\nEscore aponta presença crítica de marcadores sutis de camuflagem social, exaustão adaptativa e seletividade sensorial característicos da manifestação fenotípica feminina. Recomendada avaliação especializada.';
      } else {
        return 'Resultado GQ-ASC: RASTREIO NEGATIVO.\n\nComportamentos e reações operando dentro dos parâmetros de variabilidade típica.';
      }
    }

    // 30. DIRETRIZES DA ESCALA SRS-2 ADULTO (RESPONSIVIDADE SOCIAL)
    if (nomeDoTeste.contains('SRS-2')) {
      if (pontuacao >= 40) {
        return 'Resultado SRS-2: INDICATIVO DE COMPROMETIMENTO EM RESPONSIVIDADE SOCIAL.\n\nEscore indica dificuldades marcantes no reconhecimento de pistas sociais, comunicação recíproca e engajamento interpessoal cotidiano. Sugere-se encaminhamento clínico.';
      } else {
        return 'Resultado SRS-2: DESEMPENHO SOCIAL DENTRO DO ESPERADO.\n\nHabilidades de interatividade e empatia operando sem marcadores de risco.';
      }
    }

    // 31. DIRETRIZES DA ESCALA SPM-2 ADULTO (PROCESSAMENTO SENSORIAL)
    if (nomeDoTeste.contains('SPM-2')) {
      if (pontuacao >= 30) {
        return 'Resultado SPM-2: ALERTA CRÍTICO DE DISFUNÇÃO REATIVA SENSORIAL.\n\nEscore aponta forte presença de hipersensibilidades auditivas, visuais, táteis ou vestibulares com impacto severo na rotina. Recomendada consulta com Terapeuta Ocupacional especializada em Integração Sensorial.';
      } else {
        return 'Resultado SPM-2: INTEGRAÇÃO SENSORIAL PRESERVADA.\n\nProcessamento e resposta a estímulos ambientais operando dentro da normalidade.';
      }
    }

    // 32. DIRETRIZES DA ESCALA RAADS-R COMPLETA (AUTISMO ADULTO)
    if (nomeDoTeste.contains('RAADS-R')) {
      if (pontuacao >= 26) {
        return 'Resultado RAADS-R: FORTE INDICATIVO DE TRANSTORNO DO ESPECTRO AUTISTA (RISCO ELEVADO).\n\nEscore igual ou superior a 26 pontua criticamente em áreas cruciais de linguagem, sensório e interatividade social na vida adulta. Altamente recomendado encaminhamento para diagnóstico neuropsicológico formal.';
      } else {
        return 'Resultado RAADS-R: RASTREIO NEGATIVO.\n\nIndicadores de interação e interesses mantêm-se abaixo do ponto de corte clínico.';
      }
    }

    // 33. DIRETRIZES DA ESCALA WHODAS 2.0 COMPLETA (FUNCIONALIDADE OMS)
    if (nomeDoTeste.contains('WHODAS 2.0')) {
      if (pontuacao >= 24) {
        return 'Resultado WHODAS 2.0: ÍNDICE DE DEFICIÊNCIA / RESTRIÇÃO FUNCIONAL ELEVADA.\n\nEscore indica impacto severo e restrições marcantes na mobilidade, autocuidado, aprendizagem (escola/EJA) e participação social. Recomendado suporte multiprofissional.';
      } if (pontuacao >= 12) {
        return 'Resultado WHODAS 2.0: RESTRIÇÃO FUNCIONAL MODERADA.\n\nZona de atenção. Apresenta dificuldades pontuais no gerenciamento das rotinas diárias e estudos.';
      }
      return 'Resultado WHODAS 2.0: FUNCIONALIDADE PRESERVADA.\n\nCapacidade de autogestão e participação social fluindo sem restrições significativas.';
    }

    // 34. DIRETRIZES DE IDEAÇÃO EROTOMANÍACA E APEGO BORDERLINE (ADULTO)
    if (nomeDoTeste.contains('Ideação Erotomaníaca')) {
      if (pontuacao >= 6) {
        return 'Resultado: RISCO CRÍTICO DE IDEAÇÃO OBSESSIVA E APEGO DESADAPTATIVO.\n\nEscore aponta forte indicativo de fixações românticas ilusórias e padrões de instabilidade interpessoal severa. Exige encaminhamento imediato para psicoterapia clínica aprofundada.';
      } else {
        return 'Resultado: PADRÕES AFETIVOS DENTRO DA EXPECTATIVA.\n\nNão foram identificados sinais de alerta ou fixações obsessivas nesta triagem inicial.';
      }
    }

    return 'Triagem Concluída.\n\nDados computados com sucesso para o relatório do paciente.';
  }
}
