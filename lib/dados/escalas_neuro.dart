class EscalasNeuro {
  // 20 Perguntas Oficiais do M-CHAT-R/F
  static final List<String> perguntasMchat = [
    '1. Se você apontar para algo na sala, a criança olha para o que você está apontando?',
    '2. Você já se perguntou se seu(sua) filho(a) pode ser surdo(a)?',
    '3. A criança faz brincadeiras de faz-de-conta ou imaginação?',
    '4. A criança gosta de subir nas coisas (ex: móveis, brinquedos do parque)?',
    '5. A criança faz movimentos incomuns com os dedos perto dos olhos?',
    '6. A criança aponta com um dedo para pedir algo ou pedir ajuda?',
    '7. A criança aponta com um dedo para mostrar algo interessante para você?',
    '8. A criança se interessa por outras crianças?',
    '9. A criança mostra coisas para você trazendo-as até você ou segurando-as para você ver?',
    '10. A criança responde quando você a chama pelo nome?',
    '11. Quando você sorri para a criança, ela sorri de volta?',
    '12. A criança se incomoda com ruídos diários (ex: aspirador de pó ou música alta)?',
    '13. A criança já anda?',
    '14. A criança olha nos seus olhos quando você fala com ela, brinca com ela ou a veste?',
    '15. A criança tenta imitar o que você faz (ex: dar tchau, bater palmas)?',
    '16. Se você virar a cabeça para olhar para algo, a criança vira a cabeça para ver o que você está olhando?',
    '17. A criança tenta fazer com que você olhe para ela?',
    '18. A criança entende quando você diz para ela fazer algo (ex: "coloque o livro na mesa")?',
    '19. Se algo incomum acontece, a criança olha para o seu rosto para ver como você reage?',
    '20. A criança gosta de atividades de movimento (ex: ser balançada ou pulada no seu joelho)?',
  ];

  // 15 Critérios Clínicos Oficiais da Escala CARS
  static final List<String> perguntasCars = [
    'I. Relações Pessoais: Resposta ou isolamento em relação ao contato humano.',
    'II. Imitação: Capacidade de imitar sons, palavras ou movimentos corporais.',
    'III. Resposta Emocional: Grau de adequação da resposta emocional às situações.',
    'IV. Uso do Corpo: Coordenação motora, agilidade e presença de maneirismos (ex: andar na ponta dos pés).',
    'V. Uso de Objetos: Interesse por brinquedos e capacidade de dar utilidade funcional a eles.',
    'VI. Resposta a Mudanças: Resistência ou dificuldade de adaptação a mudanças de rotina.',
    'VII. Resposta Visual: Uso do olhar, contato visual ou fixação em estímulos visuais específicos.',
    'VIII. Resposta Auditiva: Sensibilidade a ruídos, barulhos ou desatenção a chamados sonoros.',
    'IX. Resposta do Paladar, Olfato e Tato: Reação ou interesse incomum por cheiros, texturas ou sabores.',
    'X. Medo ou Nervosismo: Medo desproporcional ou ausência de medo diante de perigos reais.',
    'XI. Comunicação Verbal: Presença de ecolalia, alterações de tom ou atraso severo na fala.',
    'XII. Comunicação Não-Verbal: Uso de gestos, postura ou expressões para se comunicar.',
    'XIII. Nível de Atividade: Presença de hiperatividade motora ou letargia extrema.',
    'XIV. Nível e Consistência do Funcionamento Intelectual: Desempenho cognitivo geral e habilidades isoladas.',
    'XV. Impressão Geral: Avaliação subjetiva do clínico com base nos sintomas observados.',
  ];

  // 6 Perguntas de Rastreio Rápido Crítico da ASRS-18 (Parte A)
  static final List<String> perguntasAsrs = [
    '1. Com que frequência você tem dificuldade para finalizar os detalhes finais de um projeto, após as partes difíceis já terem sido feitas?',
    '2. Com que frequência você tem dificuldade para colocar as coisas em ordem quando está organizando uma tarefa ou atividade?',
    '3. Com que frequência você tem dificuldade para se lembrar de compromissos ou obrigações?',
    '4. Quando você tem uma tarefa que exige muito esforço mental, com que frequência você evita ou adia o início?',
    '5. Com que frequência você fica mexendo as mãos ou os pés quando tem que permanecer sentado por muito tempo?',
    '6. Com que frequência você se sente ativo demais, como se estivesse movido por um motor?',
  ];

  // Critérios de Rastreio da Escala ATA (Traços Autísticos)
  static final List<String> perguntasAta = [
    '1. Apresenta isolamento ou dificuldade extrema em interagir com outras crianças de sua idade?',
    '2. Age como se não escutasse o que lhe é dito, ignorando chamados pelo nome?',
    '3. Demonstra resistência severa e crises de birra diante de mudanças de rotina ou ambiente?',
    '4. Apego excessivo, rígido ou incomum a objetos específicos ou partes deles?',
    '5. Apresenta risos ou sorrisos inapropriados sem motivo contextual aparente?',
    '6. Demonstra ausência de medo diante de perigos reais ou medos desproporcionais a objetos inofensivos?',
  ];

  // Sinais de Alerta Selecionados da Escala ABC (Behavior Checklist)
  static final List<String> perguntasAbc = [
    '1. Evita ativamente o contato visual direto com o avaliador ou familiares?',
    '2. Gira objetos de forma repetitiva ou foca obsessivamente em partes específicas de brinquedos?',
    '3. Apresenta flutuações severas de humor e crises de choro ou riso sem motivo aparente?',
    '4. Não reage a estímulos dolorosos intensos ou demonstra hipersensibilidade ao toque leve?',
    '5. Repete palavras ou frases curtas ditas por outros (ecolalia) de forma contínua?',
    '6. Apresenta maneirismos motores repetitivos como bater as mãos (flapping) ou balançar o corpo?',
  ];

  static final Map<String, List<String>> perguntas = {
    'M-CHAT-R/F (TEA Inicial)': perguntasMchat,
    'Escala CARS (Autismo Infantil)': perguntasCars,
    'Escala ASRS-18 (Rastreio TDAH)': perguntasAsrs,
    'Escala ATA (Traços Autísticos)': perguntasAta,
    'Escala ABC (Behavior Checklist)': perguntasAbc,
  };
}
