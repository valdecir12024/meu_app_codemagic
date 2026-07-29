class EscalasComportamento {
  // 18 Perguntas Oficiais Completas do SNAP-IV (Critérios do DSM)
  static final List<String> perguntasSnap = [
    '1. Não consegue prestar muita atenção a detalhes ou comete erros por descuido nos deveres escolares ou outras atividades?',
    '2. Tem dificuldade para manter a atenção em tarefas ou atividades de lazer?',
    '3. Parece não ouvir quando lhe dirigem a palavra diretamente?',
    '4. Não segue instruções até o fim e não consegue terminar deveres escolares, tarefas ou obrigações?',
    '5. Tem dificuldade para organizar tarefas e atividades?',
    '6. Evita, demonstra antipatia ou reluta em envolver-se em tarefas que exijam esforço mental prolongado?',
    '7. Perde coisas necessárias para tarefas ou atividades (ex: brinquedos, lápis, livros)?',
    '8. É facilmente distraído por estímulos alheios à tarefa?',
    '9. Apresenta esquecimento em atividades diárias?',
    '10. Agita as mãos ou os pés ou se remexe na cadeira?',
    '11. Abandona sua cadeira em sala de aula ou em outras situações nas quais se espera que permaneça sentado?',
    '12. Corre ou escala em demasia em situações nas quais isto é inapropriado?',
    '13. Tem dificuldade para brincar ou engajar-se silenciosamente em atividades de lazer?',
    '14. Está "a mil" ou frequentemente age como se estivesse movido por um motor?',
    '15. Fala em demasia?',
    '16. Responde abruptamente antes de as perguntas terem sido completadas?',
    '17. Tem dificuldade para aguardar sua vez?',
    '18. Interrompe os outros ou se intromete (ex: mete-se em conversas ou jogos)?',
  ];

  // 10 Itens de Triagem Rápida da Escala Conners-3 (Conduta e Oposição)
  static final List<String> perguntasConners = [
    '1. É desatento(a) ou se distrai com extrema facilidade durante explicações.',
    '2. É pavio curto, irritável ou estoura verbalmente sem motivos proporcionais.',
    '3. Discute ativamente com adultos ou figuras de autoridade.',
    '4. Desafia ativamente ou se recusa a atender aos pedidos ou regras dos adultos.',
    '5. Propositadamente incomoda ou perturba outras pessoas ao seu redor.',
    '6. Culpa os outros pelos seus próprios erros ou pelo seu mau comportamento.',
    '7. É frequentemente hostil, vingativo(a) ou busca revanche por pequenos motivos.',
    '8. Demonstra fúria, ressentimento ou chora intensamente quando contrariado(a).',
    '9. Tem extrema dificuldade em focar em um trabalho chato ou repetitivo.',
    '10. Mexe-se continuamente na cadeira e demonstra inquietação física marcante.',
  ];

  // 12 Itens de Desempenho e Foco em Sala de Aula da Escala Vanderbilt
  static final List<String> perguntasVanderbilt = [
    '1. Interrompe ou se intromete nas atividades, jogos ou conversas dos outros colegas.',
    '2. Tem extrema dificuldade em esperar a sua vez em filas ou brincadeiras coletivas.',
    '3. Agita as mãos ou os pés ou se remexe na cadeira de forma contínua.',
    '4. Abandona sua cadeira em sala de aula ou em outras situações esperadas.',
    '5. Corre ou escala em demasia em situações nas quais isto é inapropriado.',
    '6. Tem dificuldade para brincar ou engajar-se silenciosamente em atividades de lazer.',
    '7. Perde materiais necessários para tarefas ou atividades escolares (lápis, livros).',
    '8. Apresenta dificuldades acentuadas em organizar suas próprias tarefas diárias.',
    '9. Evita ou demonstra forte aversão a tarefas que exijam esforço mental prolongado.',
    '10. Distrai-se muito facilmente por estímulos visuais ou sonoros externos.',
    '11. Esquece com frequência compromissos, prazos ou materiais de estudo diários.',
    '12. Não consegue focar em detalhes em folhas de atividades, cometendo erros por descuido.',
  ];

  static final Map<String, List<String>> perguntas = {
    'SNAP-IV (TDAH e TOD Inicial)': perguntasSnap,
    'Escala Conners-3 (Conduta e Foco)': perguntasConners,
    'Vanderbilt (Comportamento Escolar)': perguntasVanderbilt,
  };
}
