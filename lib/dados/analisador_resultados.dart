import 'package:flutter/material.dart';

class AnalisadorResultados {
  /// Motor mestre de análise científica e geração de relatórios descritivos das 44 escalas
  static String obterAvaliacao(String nomeDoTeste, num pontuacao) {
    final teste = nomeDoTeste.trim().toLowerCase();

    // =========================================================================
    // SEÇÃO 1: DIRETRIZES DA ABA 1 (NEURO - INFANTIL E TRIAGENS RÁPIDAS)
    // =========================================================================
    
    // 1. M-CHAT-R/F (Triagem de TEA Inicial)
    if (teste.contains('m-chat')) {
      if (pontuacao >= 8) return 'Resultado M-CHAT-R/F: RISCO ELEVADO PARA TEA.\n\nEscore crítico indicando forte presença de marcadores de desenvolvimento social e comunicativo atípico. Recomendado encaminhamento para avaliação neuropediátrica formal.';
      if (pontuacao >= 3) return 'Resultado M-CHAT-R/F: RISCO MODERADO PARA TEA.\n\nZona de atenção e monitoramento clínico. Sugere-se aplicação da entrevista de seguimento ou reavaliação do desenvolvimento em 3 meses.';
      return 'Resultado M-CHAT-R/F: RISCO BAIXO.\n\nMarcos do desenvolvimento social, comunicativo e de jogo operando dentro dos parâmetros de normalidade esperados.';
    }

    // 2. ESCALA CARS (Avaliação de Autismo Infantil com Pontuação Decimal)
    if (teste.contains('cars')) {
      if (pontuacao >= 37) return 'Resultado Escala CARS: INDICATIVO DE AUTISMO GRAVE.\n\nEscore aponta comprometimento severo e generalizado em múltiplas áreas de interatividade, comportamento e processamento sensório. Exige suporte multiprofissional especializado intensivo.';
      if (pontuacao >= 30) return 'Resultado Escala CARS: INDICATIVO DE AUTISMO LEVE A MODERADO.\n\nPontuação inserida na zona clínica de rastreio positivo. Recomendada investigação diagnóstica aprofundada com equipe interdisciplinar.';
      return 'Resultado Escala CARS: ABAIXO DO LIMIAR CLÍNICO.\n\nOs comportamentos observados mantêm-se dentro dos parâmetros de variabilidade típica esperados para a faixa etária.';
    }

    // 3. ESCALA ASRS-18 (Versão Rastreio Inicial Infantil/Juvenil)
    if (teste.contains('asrs-18 (rastreio') || (teste.contains('asrs-18') && !teste.contains('completa'))) {
      if (pontuacao >= 4) return 'Resultado ASRS-18: ALERTA DE SINTOMAS DE TDAH.\n\nPresença marcante de critérios de desatenção ou hiperatividade/impulsividade com impacto funcional aparente. Recomendado encaminhamento para triagem neuropsicológica especializada.';
      return 'Resultado ASRS-18: PERFIL DENTRO DA NORMALIDADE.\n\nIndicadores de foco, sustentação atencional e inquietude operando abaixo do ponto de corte de triagem clínica.';
    }

    // 4. ESCALA ATA (Associação de Traços Autísticos)
    if (teste.contains('ata')) {
      if (pontuacao >= 15) return 'Resultado Escala ATA: ALERTA CLÍNICO POSITIVO.\n\nEscore indica alta concentração de traços autísticos populacionais (ATA >= 15). Necessita de encaminhamento para avaliação especializada fonoaudiológica e neurológica.';
      return 'Resultado Escala ATA: PERFIL ADAPTATIVO POPULACIONAL.\n\nIndicadores de interação e comportamento enquadram-se dentro dos padrões de normalidade para triagem inicial.';
    }

    // 5. ESCALA ABC (Autism Behavior Checklist com Ponto de Corte Krug)
    if (teste.contains('abc')) {
      if (pontuacao >= 68) return 'Resultado Escala ABC: ALTA PROBABILIDADE DE COMPORTAMENTO ATÍPICO (TEA).\n\nPontuação severa (ABC >= 68). Forte indicativo de barreiras severas de conduta, linguagem e socialização. Recomendada intervenção multidisciplinar imediata.';
      if (pontuacao >= 54) return 'Resultado Escala ABC: MODERADA PROBABILIDADE DE COMPORTAMENTO ATÍPICO.\n\nSintomas limítrofes e zona de penumbra clínica. Necessita de investigação comportamental e neuropsicopedagógica aprofundada.';
      return 'Resultado Escala ABC: BAIXA PROBABILIDADE / DESENVOLVIMENTO TÍPICO.\n\nComportamentos mapeados operando dentro das faixas adaptativas esperadas.';
    }

    // 6. TRIAGEM DE ATENÇÃO VISUAL & MEMÓRIA DE CURTO PRAZO
    if (teste.contains('atenção visual') || teste.contains('memória')) {
      if (pontuacao >= 8) return 'Resultado: ALERTA DE COMPROMETIMENTO OPERACIONAL/EXECUTIVO.\n\nEscore aponta fadiga atencional, alto índice de distratibilidade ou falhas de retenção imediata acima da média. Recomendado treino cognitivo estruturado e adaptação ambiental escolar.';
      return 'Resultado: DESEMPENHO EXECUTIVO ADEQUADO.\n\nHabilidades de foco sustentado, varredura visual e memória operacional funcionando plenamente dentro dos parâmetros normais.';
    }
    // =========================================================================
    // SEÇÃO 2: DIRETRIZES DA ABA 2 (COMPORTAMENTO - INFANTIL E JUVENIL)
    // =========================================================================
    
    // 7. SNAP-IV (Rastreio de TDAH e TOD)
    if (teste.contains('snap')) {
      if (pontuacao >= 50) return 'Resultado SNAP-IV: ALERTA DE RISCO COMBINADO (TDAH/TOD).\n\nNíveis elevados de desatenção, hiperatividade e oposição com prejuízo acadêmico ou social manifesto. Recomendada avaliação multiprofissional urgente.';
      return 'Resultado SNAP-IV: INDICADORES COMPORTAMENTAIS TOLERÁVEIS.\n\nPadrões de conduta e foco operando dentro dos limites esperados para a rotina familiar e escolar.';
    }

    // 8. ESCALA CONNERS-3 (Problemas de Conduta e Oposição)
    if (teste.contains('conners')) {
      if (pontuacao >= 65) return 'Resultado Conners-3: PERFIL COMPORTAMENTAL SEVERO.\n\nMarcadores críticos de impulsividade, problemas de conduta e oposição acentuada. Necessita de intervenção focada e orientação parental estruturada.';
      return 'Resultado Conners-3: DENTRO DA FAIXA ADAPTATIVA.\n\nRegulação de conduta e respeito às regras sociais operando dentro dos parâmetros de normalidade.';
    }

    // 9. VANDERBILT (Comportamento Escolar e Acadêmico)
    if (teste.contains('vanderbilt')) {
      if (pontuacao >= 35) return 'Resultado Vanderbilt: PREJUÍZO COMPORTAMENTAL EM AMBIENTE ESCOLAR.\n\nEscore aponta dificuldades severas de foco e conduta especificamente na sala de aula. Recomendada intervenção pedagógica e suporte psicopedagógico.';
      return 'Resultado Vanderbilt: PERFIL ADAPTADO À ROTINA ESCOLAR.\n\nHabilidades de regulação emocional e foco operando de forma saudável no ambiente acadêmico.';
    }

    // 10. ESCALA BASIC 3 (Competências do Desenvolvimento)
    if (teste.contains('basic 3')) {
      if (pontuacao < 10) return 'Resultado Basic 3: ALERTA NO DESENVOLVIMENTO COGNITIVO/SOCIAL.\n\nA pontuação total ficou abaixo do esperado para a faixa etária. Recomendada triagem neuropsicológica complementar para identificar possíveis barreiras.';
      return 'Resultado Basic 3: DESENVOLVIMENTO ADEQUADO.\n\nAs competências básicas avaliadas encontram-se plenamente dentro dos marcos de desenvolvimento típicos esperados.';
    }

    // 11. ESCALA ICU (Traços Insensíveis e Frios)
    if (teste.contains('icu')) {
      if (pontuacao >= 25) return 'Resultado ICU: RISCO ELEVADO DE RIGIDEZ AFETIVA.\n\nEscore indica presença marcante de traços de insensibilidade emocional. Recomendado acompanhamento psicológico focado em empatia e desenvolvimento de habilidades interpessoais.';
      return 'Resultado ICU: DESENVOLVIMENTO AFETIVO TÍPICO.\n\nEscore dentro dos padrões esperados para a faixa etária. Padrões de socialização operando sem sinais de alerta clínicos.';
    }

    // 12. ESCALA CRIES-13 (Estresse Pós-Traumático)
    if (teste.contains('cries-13') || teste.contains('cries')) {
      if (pontuacao >= 30) return 'Resultado CRIES-13: INDICATIVO DE ESTRESSE PÓS-TRAUMÁTICO (TEPT).\n\nPontuação severa. Presença crítica de pensamentos intrusivos, pesadelos e comportamentos de esquiva. Encaminhar para intervenção psicológica especializada imediatamente.';
      return 'Resultado CRIES-13: RISCO BAIXO DE TRAUMA.\n\nSintomas de estresse ou trauma situam-se abaixo do ponto de corte clínico.';
    }

    // 13. ESCALA IAT (Dependência de Internet e Telas)
    if (teste.contains('iat') || teste.contains('internet')) {
      if (pontuacao >= 31) return 'Resultado IAT: DEPENDÊNCIA CRÍTICA DA INTERNET.\n\nUso problemático e abusivo de telas com prejuízos severos na rotina de sono, estudo e isolamento social. Recomendada orientação familiar rígida e suporte terapêutico.';
      if (pontuacao >= 15) return 'Resultado IAT: USO MODERADO / ZONA DE ALERTA.\n\nZona de atenção. Apresenta sinais iniciais de distração digital e desregulação de tempo. Sugere-se estabelecer limites saudáveis de tela.';
      return 'Resultado IAT: USO SAUDÁVEL E CONTROLADO.\n\nUtilização de internet e tecnologias digitais operando dentro dos limites adaptativos saudáveis.';
    }

    // 14. ESCALA MBI (Inventário de Burnout Acadêmico)
    if (teste.contains('mbi') || teste.contains('burnout')) {
      if (pontuacao >= 22) return 'Resultado MBI: INDICATIVO DE SÍNDROME DE BURNOUT ACADÊMICO.\n\nEscore aponta exaustão emocional severa e esgotamento associado à rotina severa de cobranças. Recomendado suporte e acompanhamento de saúde mental focado em manejo de estresse.';
      return 'Resultado MBI: PERFIL DE ENGAJAMENTO SAUDÁVEL.\n\nNíveis de estresse, cansaço e frustração mantêm-se dentro dos parâmetros ocupacionais e acadêmicos toleráveis.';
    }

    // 15. ESCALA CFQ (Cognitive Failures Questionnaire / Falhas Cognitivas)
    if (teste.contains('cfq')) {
      if (pontuacao >= 20) return 'Resultado CFQ: ALERTA DE FALHAS COGNITIVAS NA ROTINA.\n\nAlto índice de esquecimentos rotineiros, lapsos de atenção sustentada e distratibilidade operacional. Sugere-se investigação neurológica ou treino neurocognitivo.';
      return 'Resultado CFQ: DESEMPENHO OPERACIONAL ADEQUADO.\n\nHabilidades de memória e atenção executiva cotidiana funcionando plenamente dentro dos padrões esperados.';
    }
    if (teste.contains('msi-bpd') || teste.contains('msi')) {
      if (pontuacao >= 7) return 'Resultado MSI-BPD: MARCADOR DE ALERTA DE PERSONALIDADE.\n\nEscore aponta forte presença de traços de instabilidade emocional severa, impulsividade e oscilações relacionais. Recomendado encaminhamento para avaliação especializada com psiquiatra.';
      return 'Resultado MSI-BPD: PERFIL DENTRO DA NORMALIDADE.\n\nSintomas de instabilidade afetiva ou reatividade emocional situam-se abaixo do limiar de triagem clínica.';
    }

    if (teste.contains('crafft')) {
      if (pontuacao >= 2) return 'Resultado CRAFFT 2.1: RASTREIO POSITIVO (RISCO ELEVADO).\n\nPontuação indica comportamento de risco associado ao uso de substâncias químicas. Necessita de intervenção breve, orientação familiar direta e encaminhamento especializado.';
      return 'Resultado CRAFFT 2.1: BAIXO RISCO / NEGATIVO.\n\nNenhum padrão de uso nocivo ou comportamento de risco associado a substâncias foi identificado nesta triagem.';
    }

    if (teste.contains('vitimização') || teste.contains('bullying')) {
      if (pontuacao >= 12) return 'Resultado: ALERTA CRÍTICO DE CONVIVÊNCIA ESCOLAR (VÍTMA DE BULLYING).\n\nEscore aponta alto índice de sofrimento por práticas agressivas ou cyberbullying. Exige intervenção imediata da equipe gestora, acolhimento psicopedagógico e orientação familiar.';
      return 'Resultado: AMBIENTE DE CONVIVÊNCIA DENTRO DO ESPERADO.\n\nIndicadores de conflitos interpessoais situam-se em níveis pontuais ou abaixo do nível de alerta institucional.';
    }

    if (teste.contains('big five') || teste.contains('personalidade')) {
      return 'Resultado Big Five: PERFIL PERSONALÍSTICO COMPUTADO COM SUCESSO.\n\nAs tendências de Extroversão, Amabilidade, Conscienciosidade, Estabilidade Emocional e Abertura foram processadas e mapeadas para o relatório descritivo final.';
    }

    // =========================================================================
    // SEÇÃO 3: DIRETRIZES DA ABA 3 (SOCIOEMOCIONAL - INFANTIL E GERAL)
    // =========================================================================
    if (teste.contains('sdq')) {
      if (pontuacao >= 17) return 'Resultado SDQ: PERFIL CLÍNICO / ANORMAL.\n\nEscore total de dificuldades elevado (SDQ >= 17). Presença marcante de barreiras emocionais, hiperatividade ou problemas de relacionamento. Altamente recomendado suporte terapêutico focado.';
      if (pontuacao >= 14) return 'Resultado SDQ: PERFIL LIMÍTROFE.\n\nZona de atenção and monitoramento preventivo. Apresenta indicadores moderados de sofrimento. Sugere-se orientação escolar e familiar continuada.';
      return 'Resultado SDQ: PERFIL TÍPICO / EQUILIBRADO.\n\nEquilíbrio adequado de forças e capacidades emocionais. Habilidades prosciais e condutas operando dentro da normalidade.';
    }

    if (teste.contains('scared')) {
      if (pontuacao >= 25) return 'Resultado Escala SCARED: ALERTA CLÍNICO DE ANSIEDADE.\n\nPontuação na zona crítica (SCARED >= 25). Forte indicativo de presença de sintomas de pânico, ansiedade generalizada ou fobias na infância/adolescência. Recomendada avaliação psicoterápica.';
      return 'Resultado Escala SCARED: NÍVEL DE ANSIEDADE TÍPICO.\n\nReações emocionais normais para a faixa etária. Ausência de marcadores severos de estresse ou evitação ansiosa.';
    }

    if (teste.contains('rosemberg')) {
      if (pontuacao <= 15) return 'Resultado Escala de Rosemberg: AUTOESTIMA FRAGILIZADA.\n\nO escore aponta a presença marcante de sentimentos de desvalorização pessoal, autocrítica severa e insecurity. Recomendável acolhimento e suporte terapêutico.';
      return 'Resultado Escala de Rosemberg: AUTOESTIMA SAUDÁVEL.\n\nPercepção global de autovalorização positiva, segura, confiante e equilibrada dentro dos parâmetros adaptativos esperados.';
    }

    if (teste.contains('hads')) {
      if (pontuacao >= 11) return 'Resultado HADS: INDICATIVO CLÍNICO DE ALERTA.\n\nEscore aponta níveis elevados e críticos de sintomas ansiosos ou depressivos de triagem. Recomendável encaminhamento para avaliação especializada em saúde mental.';
      if (pontuacao >= 8) return 'Resultado HADS: CASO LIMÍTROFE (ZONA DE ATENÇÃO).\n\nSintomas operando em nível moderado. Sugere-se monitoramento preventivo e suporte psicoterapêutico emocional inicial.';
      return 'Resultado HADS: DENTRO DA NORMALIDADE.\n\nIndicadores de ansiedade e depressão situam-se integralmente dentro dos parâmetros típicos esperados.';
    }

    if (teste.contains('gifts')) {
      if (pontuacao >= 5) return 'Resultado GIFTS: MARCADOR DE ALTAS HABILIDADES / SUPERDOTAÇÃO (AH/SD).\n\nForte indicativo de potencial superior, curiosidade obsessiva e criatividade avançada. Recomendado enriquecimento curricular e acompanhamento psicopedagógico especializado.';
      return 'Resultado GIFTS: DESENVOLVIMENTO DENTRO DO ESPERADO.\n\nCompetências, marcos cognitivos e ritmos de aprendizado acompanham a média típica esperada para a faixa etária.';
    }

    if (teste.contains('dislexia') && !teste.contains('adulto')) {
      if (pontuacao >= 6) return 'Resultado: RASTREIO POSITIVO PARA TRAÇOS DE DISLEXIA.\n\nEscore aponta marcadores significativos de barreira na velocidade de leitura, escrita e processamento fonológico. Recomendado encaminhamento para avaliação fonoaudiológica.';
      return 'Resultado: DESEMPENHO EM LEITURA DENTRO DO ESPERADO.\n\nHabilidades de processamento de escrita, alfabetização e leitura operando sem sinais de alerta clínicos ou funcionais.';
    }

    if (teste.contains('eat')) {
      if (pontuacao >= 5) return 'Resultado EAT: ALERTA CRÍTICO DE COMPORTAMENTO ALIMENTAR.\n\nEscore aponta indicativo severo de atitudes alimentares disfuncionais ou distorção de percepção corporal. Recomendado acompanhamento preventivo com psicólogo e nutricionista.';
      return 'Resultado EAT: PERFIL ALIMENTAR SAUDÁVEL.\n\nRelação com a alimentação, rituais de refeição e percepção corporal operando dentro da normalidade cotidiana.';
    }

    if (teste.contains('igi')) {
      if (pontuacao >= 21) return 'Resultado IGI: ALTO ÍNDICE DE GRATIDÃO SUBJETIVA.\n\nEscore aponta excelente nível de percepção positiva, resiliência e bem-estar subjetivo. Indicador associado a uma saúde mental estável e protetiva contra estresse.';
      return 'Resultado IGI: ÍNDICE DE GRATIDÃO MODERADO / BAIXO.\n\nSugerido o desenvolvimento guiado de práticas reflexivas para fortalecimento de bem-estar emocional, reestruturação cognitiva e enfrentamento de crises.';
    }

    if (teste.contains('mdq')) {
      if (pontuacao >= 7) return 'Resultado MDQ: ALERTA DE OSCILAÇÃO DE HUMOR ACIMA DO LIMIAR.\n\nEscore indica forte presença de sintomas de instabilidade energética, impulsividade ou oscilações cíclicas de humor. Altamente recomendada a avaliação diagnóstica especializada com médico psiquiatra.';
      return 'Resultado MDQ: PERFIL DE HUMOR DENTRO DA NORMALIDADE.\n\nSintomas de oscilações acentuadas, ciclotimia ou episódios impulsivos situam-se abaixo do limiar de alerta de triagem clínica.';
    }

    if (teste.contains('erotomaníaca') && !teste.contains('adulto')) {
      if (pontuacao >= 6) return 'Resultado: RISCO CRÍTICO DE IDEAÇÃO OBSESSIVA E APEGO DESADAPTATIVO.\n\nEscore aponta forte indicativo de fixações românticas ilusórias e padrões de instabilidade interpessoal severa. Exige encaminhamento imediato para psicoterapia clínica aprofundada.';
      return 'Resultado: PADRÕES AFETIVOS DENTRO DA EXPECTATIVA.\n\nNão foram identificados sinais de alerta, idealizações extremas ou fixações obsessivas nesta triagem inicial.';
    }

    if (teste.contains('discalculia')) {
      if (pontuacao >= 6) return 'Resultado: RASTREIO POSITIVO PARA TRAÇOS DE DISCALCULIA.\n\nEscore aponta marcadores significativos de dificuldade no processamento numérico, senso de quantidade e operações matemáticas elementares. Recomendado suporte psicopedagógico focado.';
      return 'Resultado: PROCESSAMENTO MATEMÁTICO DENTRO DO ESPERADO.\n\nHabilidades de cálculo, ordenamento numeral e raciocínio lógico-matemático operando sem indicadores de alerta clínicos.';
    }
    // =========================================================================
    // SEÇÃO 4: DIRETRIZES DA ABA 4 (ADULTO / EJA - VERSÕES COMPLETAS)
    // =========================================================================
    if (teste.contains('asrs-18 completa') || teste.contains('asrs-v1.1')) {
      if (pontuacao >= 24) return 'Resultado ASRS-18: FORTE INDICATIVO DE TDAH EM ADULTOS (RISCO ELEVADO).\n\nEscore aponta alta frequência de sintomas graves de desatenção e hiperatividade/impulsividade com impacto funcional. Altamente recomendada avaliação neuropsicológica ou psiquiátrica formal.';
      if (pontuacao >= 18) return 'Resultado ASRS-18: MARCADOR DE ATENÇÃO (RISCO MODERADO).\n\nPresença de sintomas limítrofes. Sugere-se adaptações ambientais na EJA, treino de foco e monitoramento preventivo regular.';
      return 'Resultado ASRS-18: DENTRO DA NORMALIDADE.\n\nSintomas de desatenção, inquietude ou labilidade operacional situam-se abaixo do limiar de triagem clínica.';
    }

    if (teste.contains('dislexia adulto')) {
      if (pontuacao >= 6) return 'Resultado: RASTREIO POSITIVO PARA TRAÇOS DE DISLEXIA EM ADULTOS.\n\nIndicadores apontam ocorrência de dificuldades crônicas em leitura silenciosa, retenção de mensagens e escrita ortográfica. Recomendado suporte psicopedagógico focado na EJA.';
      return 'Resultado: DESEMPENHO EM LEITURA DENTRO DO ESPERADO.\n\nHabilidades de processamento de escrita e leitura fluindo dentro dos parâmetros típicos corporativos e acadêmicos.';
    }

    if (teste.contains('aq-10')) {
      if (pontuacao >= 6) return 'Resultado AQ-10: ALERTA DE TRAÇOS DO ESPECTRO AUTISTA EM ADULTOS.\n\nEscore igual ou maior que 6 indica necessidade de uma investigação clínica aprofundada para o espectro autista na vida adulta. Sugere-se encaminhamento especializado para diagnóstico.';
      return 'Resultado AQ-10: PERFIL DE RESPONSIVIDADE DENTRO DO ESPERADO.\n\nIndicadores de interação social, atenção dividida e padrões comportamentais operando abaixo do ponto de corte de triagem.';
    }

    if (teste.contains('freudenberger')) {
      if (pontuacao >= 20) return 'Resultado: RISCO CRÍTICO DE EXAUSTÃO EXECUTIVA (BURNOUT).\n\nEscore aponta forte sobrecarga física e mental decorrente da tripla jornada (trabalho, casa e estudos no EJA). Essencial intervenção focada na redução de estresse e suporte em saúde mental.';
      return 'Resultado: NÍVEL DE ESTRESSE DENTRO DO TOLERÁVEL.\n\nIndicadores de cansaço mental ocupacional ou fadiga crônica operando dentro dos parâmetros adaptativos de normalidade.';
    }

    if (teste.contains('beck') || teste.contains('bdi')) {
      if (pontuacao >= 21) return 'Resultado BDI: INDICATIVO DE DISFORIA / DEPRESSÃO MODERADA A SEVERA.\n\nEscore aponta sofrimento psíquico acentuado com impactos diretos no humor, apetite e visão de futuro. Altamente recomendada avaliação especializada com psicólogo clínico ou médico psiquiatra.';
      if (pontuacao >= 12) return 'Resultado BDI: SINTOMATOLOGIA LEVE / ZONA DE ATENÇÃO.\n\nPresença de indicadores moderados de desânimo ou apatia afetiva. Sugere-se escuta acolhedora, monitoramento de rotina e suporte inicial.';
      return 'Resultado BDI: ÍNDICE DE HUMOR DENTRO DA NORMALIDADE.\n\nIndicadores de estabilidade afetiva operando de forma saudável dentro dos parâmetros adaptativos esperados.';
    }

    if (teste.contains('tas-20') || teste.contains('alexitimia')) {
      if (pontuacao >= 61) return 'Resultado TAS-20: PRESENÇA MARCANTE DE ALEXITIMIA.\n\nEscore indica severa dificuldade na identificação, diferenciação e expressão verbal das próprias emoções e sentimentos. Recomendado suporte psicoterápico focado em regulação emocional.';
      if (pontuacao >= 52) return 'Resultado TAS-20: PERFIL LIMÍTROFE.\n\nZona de transição. Apresenta dificuldades moderadas ou pontuais em traduzir sensações corporais em termos emocionais claros.';
      return 'Resultado TAS-20: CAPACIDADE ADAPTATIVA EMOCIONAL PRESERVADA.\n\nProcessamento e expressão emocional fluindo sem indicadores de alerta clínicos.';
    }

    if (teste.contains('cat-q') || teste.contains('camuflagem')) {
      if (pontuacao >= 70) return 'Resultado CAT-Q: ALTO ÍNDICE DE CAMUFLAGEM SOCIAL (COMPENSAÇÃO).\n\nEscore aponta uso exaustivo de estratégias conscientes para imitar comportamentos e esconder dificuldades de interação (comum no autismo feminino). Risco severo de esgotamento/burnout autístico.';
      return 'Resultado CAT-Q: NÍVEL DE CAMUFLAGEM SOCIAL DENTRO DO ESPERADO.\n\nEstratégias de imitação social ou mascaramento operando abaixo do limiar de sobrecarga crônica funcional.';
    }

    if (teste.contains('aq-50')) {
      if (pontuacao >= 26) return 'Resultado AQ-50: FORTE INDICATIVO DE TRAÇOS DO ESPECTRO AUTISTA (RISCO ELEVADO).\n\nEscore igual ou superior a 26 pontua criticamente em áreas cruciais de atenção a detalhes, comunicação e imaginação. Recomenda-se encaminhamento para investigação clínica especializada.';
      return 'Resultado AQ-50: RASTREIO NEGATIVO DE TRAÇOS AUTÍSTICOS.\n\nPadrões de comportamento, linguagem e interação social operando dentro da variabilidade típica esperada.';
    }

    if (teste.contains('gq-asc')) {
      if (pontuacao >= 55) return 'Resultado GQ-ASC: FORTE INDICATIVO DE NUANCES DO ESPECTRO AUTISTA (PERFIL FEMININO).\n\nEscore aponta presença crítica de marcadores sutis de camuflagem social, exaustão adaptativa e seletividade sensorial característicos da manifestação fenotípica feminina. Recomendada avaliação especializada.';
      return 'Resultado GQ-ASC: RASTREIO NEGATIVO PARA O PERFIL AVALIADO.\n\nComportamentos, rituais e reações afetivas operando dentro dos parâmetros de variabilidade típica.';
    }

    if (teste.contains('srs-2')) {
      if (pontuacao >= 40) return 'Resultado SRS-2: INDICATIVO DE COMPROMETIMENTO EM RESPONSIVIDADE SOCIAL.\n\nEscore indica dificuldades marcantes no reconhecimento de pistas sociais, comunicação recíproca e engajamento interpessoal cotidiano. Sugere-se encaminhamento clínico.';
      return 'Resultado SRS-2: DESEMPENHO SOCIAL E EMPATIA DENTRO DO ESPERADO.\n\nHabilidades de interatividade, responsividade afetiva e empatia operando sem marcadores de risco.';
    }

    if (teste.contains('spm-2')) {
      if (pontuacao >= 30) return 'Resultado SPM-2: ALERTA CRÍTICO DE DISFUNÇÃO REATIVA SENSORIAL.\n\nEscore aponta forte presença de hipersensibilidades auditivas, visuais, táteis ou vestibulares com impacto severo na rotina. Recomendada consulta com Terapeuta Ocupacional especializada em Integração Sensorial.';
      return 'Resultado SPM-2: INTEGRAÇÃO E PROCESSAMENTO SENSORIAL PRESERVADOS.\n\nResposta a estímulos ambientais, texturas e poluição sonora operando dentro da normalidade.';
    }

    if (teste.contains('raads-r')) {
      if (pontuacao >= 26) return 'Resultado RAADS-R: FORTE INDICATIVO DE TRANSTORNO DO ESPECTRO AUTISTA (RISCO ELEVADO).\n\nEscore igual ou superior a 26 pontua criticamente em áreas de linguagem, sensório e interatividade social na vida adulta. Altamente recomendado encaminhamento para diagnóstico neuropsicológico formal.';
      return 'Resultado RAADS-R: RASTREIO NEGATIVO CLÍNICO.\n\nIndicadores de interação, empatia e interesses mantêm-se abaixo do ponto de corte de triagem.';
    }

    if (teste.contains('whodas 2.0')) {
      if (pontuacao >= 24) return 'Resultado WHODAS 2.0: ÍNDICE DE DEFICIÊNCIA / RESTRIÇÃO FUNCIONAL ELEVADA.\n\nEscore indica impacto severo e restrições marcantes na mobilidade, autocuidado, aprendizagem (escola/EJA) e participação social. Recomendado suporte multiprofissional.';
      if (pontuacao >= 12) return 'Resultado WHODAS 2.0: RESTRIÇÃO FUNCIONAL MODERADA.\n\nZona de atenção. Apresenta dificuldades pontuais no gerenciamento das rotinas diárias e estudos.';
      return 'Resultado WHODAS 2.0: FUNCIONALIDADE EXECUTIVA PRESERVADA.\n\nCapacidade de autogestão, mobilidade e participação social fluindo sem restrições significativas.';
    }

    if (teste.contains('ideação erotomaníaca') && teste.contains('adulto')) {
      if (pontuacao >= 6) return 'Resultado: RISCO CRÍTICO DE IDEAÇÃO OBSESSIVA E APEGO DESADAPTATIVO.\n\nEscore aponta forte indicativo de fixações românticas ilusórias e padrões de instabilidade interpessoal severa na vida adulta. Exige encaminhamento imediato para psicoterapia clínica aprofundada.';
      return 'Resultado: PADRÕES AFETIVOS ADULTOS DENTRO DA EXPECTATIVA.\n\nNão foram identificados sinais de alerta ou fixações obsessivas nesta triagem inicial.';
    }

    return 'Triagem Concluída.\n\nEscore computado com sucesso para fins de relatório descritivo.';
  }
} // FECHA A CLASSE ANALISADORRESULTADOS DE FORMA PERFEITA
