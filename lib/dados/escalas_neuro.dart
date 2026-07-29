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

  static final Map<String, List<String>> perguntas = {
    'M-CHAT-R/F (TEA Inicial)': perguntasMchat,
    'Escala CARS (Autismo Infantil)': [
      'Item 1: Relações Pessoais (Grau de isolamento ou resposta ao contato)',
      'Item 2: Imitação (Capacidade de imitar sons, palavras ou movimentos)',
      'Item 3: Resposta Emocional (Apropriação da reação à situação)',
    ],
    'Escala ASRS-18 (Rastreio TDAH)': [
      'Com que frequência você tem dificuldade para finalizar os detalhes finais de um projeto?',
      'Com que frequência você tem dificuldade para colocar as coisas em ordem em uma tarefa?',
      'Com que frequência você evita ou adia tarefas que exigem muito esforço mental?',
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
