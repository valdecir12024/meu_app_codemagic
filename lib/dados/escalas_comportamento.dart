class EscalasComportamento {
  // Itens Oficiais do SNAP-IV (Rastreio de TDAH/TOD baseado no DSM)
  static final List<String> perguntasSnap = [
    '1. Não consegue prestar muita atenção a detalhes ou comete erros por descuido nos deveres escolares ou outras atividades?',
    '2. Tem dificuldade para manter a atenção em tarefas ou atividades de lazer?',
    '3. Parece não ouvir quando lhe dirigem a palavra diretamente?',
    '4. Não segue instruções até o fim e não consegue terminar deveres escolares, tarefas ou obrigações?',
    '5. Tem dificuldade para organizar tarefas e atividades?',
    '6. Evita, deita antipatia ou reluta em envolver-se em tarefas que exijam esforço mental prolongado?',
    '7. Perde coisas necessárias para tarefas ou atividades (ex: brinquedos, lápis, livros)?',
    '8. É facilmente distraído por estímulos alheios à tarefa?',
    '9. Apresenta esquecimento em atividades diárias?',
  ];

  // Critérios Selecionados da Escala Conners-3 (Rastreio de Conduta e Oposição)
  static final List<String> perguntasConners = [
    '1. É desatento(a) ou se distrai com extrema facilidade durante explicações?',
    '2. É pavio curto, irritável ou estoura verbalmente sem motivos proporcionais?',
    '3. Discute ativamente com adultos ou figuras de autoridade?',
    '4. Desafia ativamente ou se recusa a atender aos pedidos ou regras dos adultos?',
    '5. Propositadamente incomoda ou perturba outras pessoas ao seu redor?',
    '6. Culpa os outros pelos seus próprios erros ou pelo seu mau comportamento?',
  ];

  // Critérios de Desempenho e Foco em Sala de Aula da Escala Vanderbilt
  static final List<String> perguntasVanderbilt = [
    '1. Interrompe ou se intromete nas atividades, jogos ou conversas dos outros colegas?',
    '2. Tem extrema dificuldade em esperar a sua vez em filas ou brincadeiras coletivas?',
    '3. Agita as mãos ou os pés ou se remexe na cadeira de forma contínua?',
    '4. Abandona sua cadeira em sala de aula ou em outras situações nas quais se espera que permaneça sentado?',
    '5. Corre ou escala em demasia em situações nas quais isto é inapropriado?',
    '6. Tem dificuldade para brincar ou engajar-se silenciosamente em atividades de lazer?',
  ];

  static final Map<String, List<String>> perguntas = {
    'SNAP-IV (TDAH e TOD Inicial)': perguntasSnap,
    'Escala Conners-3 (Conduta e Foco)': perguntasConners,
    'Vanderbilt (Comportamento Escolar)': perguntasVanderbilt,
  };
}
