class EscalasSocioemocional {
  // 10 Itens Oficiais de Rastreio do Questionário SDQ
  static final List<String> perguntasSdq = [
    '1. Costuma se queixar de dores de cabeça, de estômago ou enjôos com frequência?',
    '2. Tem muitas preocupações ou parece se preocupar com muitas coisas diariamente?',
    '3. Frequentemente perde o controle emocional, manifestando acessos de raiva?',
    '4. É uma pessoa que tende a ser solitária ou prefere brincar/ficar sozinha?',
    '5. É facilmente liderada ou manipulada por outras crianças ou colegas?',
    '6. Demonstra muitas manifestações de medo e assusta-se com facilidade?',
    '7. Tende a ser prestativa e compartilha objetos voluntariamente com os pares?',
    '8. É constantemente pilhada, inquieta ou demonstra sofrimento emocional?',
    '9. Tem melhor relacionamento com adultos do que com crianças da sua idade?',
    '10. Demonstra bom foco em tarefas e consegue finalizá-las de forma estável?',
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
