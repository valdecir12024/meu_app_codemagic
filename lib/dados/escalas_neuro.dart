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

    // 18 Perguntas Oficiais Completas da Escala ASRS-18
  static final List<String> perguntasAsrs = [
    // PARTE A (Rastreio Rápido - Itens 1 a 6)
    '1. Com que frequência você tem dificuldade para finalizar os detalhes finais de um projeto, após as partes difíceis já terem sido feitas?',
    '2. Com que frequência você tem dificuldade para colocar as coisas em ordem quando está organizando uma tarefa ou atividade?',
    '3. Com que frequência você tem dificuldade para se lembrar de compromissos ou obrigações?',
    '4. Quando você tem uma tarefa que exige muito esforço mental, com que frequência você evita ou adia o início?',
    '5. Com que frequência você fica mexendo as mãos ou os pés quando tem que permanecer sentado por muito tempo?',
    '6. Com que frequência você se sente ativo demais, como se estivesse movido por um motor?',
    // PARTE B (Aprofundamento - Itens 7 a 18)
    '7. Com que frequência você comete erros por descuido quando tem que trabalhar num projeto chato ou difícil?',
    '8. Com que frequência você tem dificuldade para manter a atenção quando está fazendo um trabalho chato ou repetitivo?',
    '9. Com que frequência você tem dificuldade para se concentrar no que as pessoas dizem, mesmo quando estão falando diretamente com você?',
    '10. Com que frequência você perde as coisas ou tem dificuldade de encontrar objetos em casa ou no trabalho?',
    '11. Com que frequência você se distrai com barulhos ou atividades ao seu redor?',
    '12. Com que frequência você sai do seu lugar em reuniões ou em outras situações nas quais se espera que fique sentado?',
    '13. Com que frequência você se sente inquieto ou agitado?',
    '14. Com que frequência você tem dificuldade para sossegar e relaxar quando tem tempo livre para você?',
    '15. Com que frequência você se pega falando demais em situações sociais?',
    '16. Quando alguém está falando com você, com que frequência você se pega terminando as frases da pessoa antes dela concluir?',
    '17. Com que frequência você tem dificuldade para esperar a sua vez em situações em que isso é necessário?',
    '18. Com que frequência você interrompe os outros quando eles estão ocupados?',
  ];

    // 23 Itens Oficiais Completos da Escala ATA (Traços Autísticos)
  static final List<String> perguntasAta = [
    '1. Dificuldade em interagir com outras crianças de sua idade.',
    '2. Apresenta isolamento social e prefere manter-se isolado(a).',
    '3. Age como se não escutasse o que lhe é dito, ignorando chamados pelo nome.',
    '4. Resistência severa e crises de birra diante de mudanças de rotina ou ambiente.',
    '5. Fixação ou apego excessivo, rígido ou incomum a objetos específicos.',
    '6. Dificuldade em aprender e usar a linguagem de forma funcional.',
    '7. Apresenta risos, sorrisos ou gargalhadas inapropriadas sem motivo contextual.',
    '8. Ausência de medo diante de perigos reais ou medos desproporcionais a objetos inofensivos.',
    '9. Apresenta maneirismos motores repetitivos (ex: flapping de mãos, balançar o corpo).',
    '10. Não olha nos olhos quando falam com ele(a) (evitação do contato visual).',
    '11. Apresenta ecolalia (repetição imediata ou tardia de frases e palavras de terceiros).',
    '12. Gira objetos de forma repetitiva ou foca obsessivamente em partes de brinquedos.',
    '13. Demonstra hipersensibilidade ou hiposensibilidade a sons (tapa os ouvidos ou ignora barulhos).',
    '14. Apego excessivo a uma rotina diária rígida (se quebra a rotina, entra em crise).',
    '15. Não responde a manifestações de afeto ou carinho dos pais ou cuidadores.',
    '16. Anda na ponta dos pés com frequência considerável.',
    '17. Tem apego a objetos bizarros ou incomuns (ex: pedaço de barbante, tampa de garrafa).',
    '18. Apresenta hiperatividade motora desorganizada ou letargia extrema.',
    '19. Demonstra reações extremas a texturas, cheiros ou sabores de alimentos.',
    '20. Apresenta dificuldades acentuadas no sono ou na regulação do humor.',
    '21. Usa os objetos e brinquedos de forma não funcional (ex: apenas enfileira ou bate).',
    '22. Apresenta autoagressividade ou morde-se/bate a cabeça quando frustrado(a).',
    '23. Apresenta fascinação visual por objetos que giram (ex: ventilador, rodas de carrinhos).',
  ];

  // Sinais de Alerta Selecionados da Escala ABC (Behavior Checklist)
  static final List<String> perguntasAbc = [
    'Escala ABC (Behavior Checklist)': [
      '1. Gira em torno de si por longo período de tempo.',
      '2. Aprende uma tarefa, mas esquece rapidamente.',
      '3. É raro atender a estímulos não-verbais sociais/ambientais.',
      '4. Ausência de resposta para solicitações verbais (parece surdo).',
      '5. Sobressalta-se ou demonstra terror com ruídos cotidianos inofensivos.',
      '6. Flutuações severas de humor sem motivo aparente ou contextual.',
    ],
  ];

  static final Map<String, List<String>> perguntas = {
    'M-CHAT-R/F (TEA Inicial)': perguntasMchat,
    'Escala CARS (Autismo Infantil)': perguntasCars,
    'Escala ASRS-18 (Rastreio TDAH)': perguntasAsrs,
    'Escala ATA (Traços Autísticos)': perguntasAta,
    'Escala ABC (Behavior Checklist)': perguntasAbc,
  };
}
