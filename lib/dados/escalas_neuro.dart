class EscalasNeuro {
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

  // Os 15 Critérios Clínicos Oficiais da Escala CARS
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

  static final Map<String, List<String>> perguntas = {
    'M-CHAT-R/F (TEA Inicial)': perguntasMchat,
    'Escala CARS (Autismo Infantil)': perguntasCars, // Injeta a lista com os 15 itens oficiais
    'Escala ASRS-18 (Rastreio TDAH)': [
      'Com que frequência você tem dificuldade para finalizar os detalhes finais de um projeto?',
      'Com que frequência você tem dificuldade para colocar as coisas em ordem em uma tarefa?',
      'Com que frequência você evita ou adia tarefas que exigem muito espaço mental?',
    ],
    'Escala ATA (Traços Autísticos)': [
      'Apresenta dificuldade em interagir com outras crianças de sua idade?',
      'Age como se não escutasse o que lhe é dito, ignorando chamados?',
      'Demonstra resistência severa a mudanças de rotina ou ambiente?',
    ],
    'Escala ABC (Behavior Checklist)': [
      'Apresenta reações extremas de isolamento social e recusa de contato?',
      'Gira objetos de forma repetitiva ou foca em partes específicas de brinquedos?',
      'Apresenta flutuações severas de humor sem motivo aparente?',
    ],
  };
}
