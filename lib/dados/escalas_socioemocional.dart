class EscalasSocioemocional {
  // Itens Reais do Questionário SDQ (Strengths and Difficulties Questionnaire)
  static final List<String> perguntasSdq = [
    '1. Costuma se queixar de dores de cabeça, de estômago ou enjôos com frequência?',
    '2. Tem muitas preocupações ou parece se preocupar com muitas coisas diariamente?',
    '3. Frequentemente perde o controle emocional, manifestando acessos de raiva ou mau humor?',
    '4. É uma pessoa que tende a ser solitária ou prefere brincar/ficar sozinha?',
    '5. É facilmente liderada ou manipulada por outras crianças ou colegas?',
    '6. Demonstra muitas manifestações de medo e assusta-se com facilidade diante do novo?',
    '7. Tende a ser prestativa e compartilha objetos voluntariamente com os pares?',
  ];

  // Perguntas de Rastreio Crítico da Escala SCARED (Ansiedade Infantil e Escolar)
  static final List<String> perguntasScared = [
    '1. Sente um medo ou desconforto inexplicável quando precisa falar ou se expor em público?',
    '2. Fica extremamente nervoso(a) ou chora quando precisa se afastar dos pais ou de casa?',
    '3. Preocupa-se excessivamente sobre o que as outras pessoas ou colegas pensam a seu respeito?',
    '4. Sente o coração bater muito rápido ou falta de ar quando passa por uma situação estressante?',
    '5. Preocupa-se muito com o futuro ou com a possibilidade de coisas ruins acontecerem?',
    '6. Tem pesadelos frequentes ou medo intenso de dormir sozinho(a) no quarto?',
  ];

  // Itens de Rastreio Inicial da Escala de Autoestima de Rosenberg
  static final List<String> perguntasRosenberg = [
    '1. Sente que é uma pessoa de valor, pelo menos tanto quanto as outras pessoas ao seu redor?',
    '2. Sente que possui várias qualidades positivas e potencial para evoluir no aprendizado?',
    '3. Tende a se sentir um fracasso completo quando as coisas não saem exatamente como planejado?',
    '4. É capaz de fazer as coisas tão bem quanto a maioria das outras pessoas da sua idade?',
    '5. Sente que não tem muito do que se orgulhar em relação às suas próprias atitudes?',
    '6. Desenvolve uma atitude positiva e acolhedora em relação a si mesmo(a)?',
  ];

  static final Map<String, List<String>> perguntas = {
    'Questionário SDQ (Conduta e Emoção)': perguntasSdq,
    'Escala SCARED (Triagem de Ansiedade)': perguntasScared,
    'Escala Rosenberg (Autoestima Inicial)': perguntasRosenberg,
  };
}
