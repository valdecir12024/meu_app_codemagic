class EscalasSocioemocional {
  // 25 Itens Oficiais de Rastreio do Questionário SDQ
  static final List<String> perguntasSdq = [
    '1. Tenta ser atencioso(a) com os sentimentos dos outros.',
      '2. É inquieto(a), hiperativo(a), não consegue ficar parado(a) muito tempo.',
      '3. Queixa-se frequentemente de dores de cabeça, de estômago ou de enjoos.',
      '4. Divide de boa vontade as coisas com outras crianças (brinquedos, lápis, etc.).',
      '5. Tem muitas explosões de raiva ou perde facilmente o controle.',
      '6. É uma criança solitária, prefere brincar sozinho(a).',
      '7. Geralmente é obediente, faz o que os adultos lhe pedem.',
      '8. Tem muitas preocupações ou parece se preocupar com tudo.',
      '9. É prestativo(a) se alguém está magoado, chateado ou doente.',
      '10. Fica continuamente se mexendo na cadeira ou remexendo as mãos.',
      '11. Tem pelo menos um(a) bom(a) amigo(a).',
      '12. Briga frequentemente com outras crianças ou intimida os colegas.',
      '13. Frequentemente parece triste, desanimado(a) ou choroso(a).',
      '14. Geralmente é querido(a) por outras crianças.',
      '15. Distrai-se facilmente, tem dificuldade para se concentrar.',
      '16. Fica nervoso(a) ou dependente em situações novas; perde facilmente a confiança.',
      '17. É gentil com crianças mais novas.',
      '18. Frequentemente acusa os outros de mentir ou trapacear.',
      '19. Sofre perseguição ou intimidação por parte de outras crianças (bullying).',
      '20. Frequentemente oferece-se para ajudar os outros (pais, professores, crianças).',
      '21. Pensa antes de agir.',
      '22. Pega coisas que não são suas (em casa, na escola ou em outros lugares).',
      '23. Dá-se melhor com adultos do que com outras crianças.',
      '24. Tem muitos medos, assusta-se facilmente.',
      '25. Completa as tarefas que começa; tem boa capacidade de atenção.'
  ];

  // 10 Perguntas Oficiais de Triagem Curta da Escala SCARED (Ansiedade)
  static final List<String> perguntasScared = [
    '1. Sente um medo ou desconforto inexplicável quando precisa falar ou se expor em público?',
    '2. Fica extremamente nervoso(a) ou chora quando precisa se afastar dos pais ou de casa?',
    '3. Preocupa-se excessivamente sobre o que as outras pessoas ou colegas pensam a seu respeito?',
    '4. Sente o coração bater muito rápido ou falta de ar quando passa por uma situação estressante?',
    '5. Preocupa-se muito com o futuro ou com a possibilidade de coisas ruins acontecerem?',
    '6. Tem pesadelos frequentes ou medo intenso de dormir sozinho(a) no quarto?',
    '7. Sente-se muito tímido(a) ou desconfortável perto de pessoas que não conhece bem?',
    '8. Preocupa-se excessivamente se faz as coisas bem feitas na escola ou tarefas?',
    '9. Sente medo intenso ou pânico repentino sem que haja uma razão clara e real?',
    '10. Sente medo de ir à escola ou de enfrentar ambientes sociais cheios.',
  ];

  // 10 Itens Oficiais Completos da Escala de Autoestima de Rosenberg
  static final List<String> perguntasRosenberg = [
    '1. Sente que é uma pessoa de valor, pelo menos tanto quanto as outras pessoas ao seu redor?',
    '2. Sente que possui várias qualidades positivas e potencial para evoluir?',
    '3. Tende a se sentir um fracasso completo quando as coisas não saem como planejado?',
    '4. É capaz de fazer as coisas tão bem quanto a maioria das outras pessoas da sua idade?',
    '5. Sente que não tem muito do que se orgulhar em relação às suas próprias atitudes?',
    '6. Desenvolve uma atitude positiva e acolhedora em relação a si mesmo(a)?',
    '7. De forma geral, sente-se totalmente satisfeito(a) consigo mesmo(a) no dia a dia?',
    '8. Gostaria de poder ter mais respeito e admiração por si mesmo(a)?',
    '9. Sente-se inútil ou incapaz em determinadas situações cotidianas?',
    '10. Pensa por vezes que não é uma pessoa boa ou correta sob nenhum aspecto.',
  ];

  static final Map<String, List<String>> perguntas = {
    'Questionário SDQ (Conduta e Emoção)': perguntasSdq,
    'Escala SCARED (Triagem de Ansiedade)': perguntasScared,
    'Escala Rosenberg (Autoestima Inicial)': perguntasRosenberg,
  };
}
