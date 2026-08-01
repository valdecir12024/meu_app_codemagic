class EscalasSocioemocional {
  static const Map<String, List<String>> perguntas = {
    // === ESCALAS ORIGINAIS DO NEUROAPP ===
    'SDQ (Forças e Dificuldades)': [
      '1. Tento ser atencioso(a) com os sentimentos dos outros?',
      '2. Sou irrequieto(a), hiperativo(a), não consigo ficar parado(a) por muito tempo?',
      '3. Tenho frequentemente dores de cabeça, dores de estômago ou mal-estar?',
      '4. Compartilho facilmente com os outros (comida, jogos, brinquedos)?',
      '5. Tenho acessos de raiva com frequência ou perco o controle facilmente?',
      '6. Sou um pouco solitário(a) e tendo a brincar ou ficar mais isolado(a)?',
      '7. Geralmente sou obediente e costumo atender aos pedidos dos adultos?',
      '8. Tenho muitas preocupações ou pareço frequentemente ansioso(a) e tenso(a)?',
      '9. Sou prestativo(a) se alguém se machuca, fica chateado ou se sente mal?',
      '10. Estou sempre me agitando ou me movendo na cadeira?',
    ],

    'Escala SCARED (Ansiedade Infantil)': [
      '1. Sinto medo de pessoas ou situações novas de forma muito intensa?',
      '2. Fico muito nervoso(a) quando preciso me afastar dos meus pais ou de casa?',
      '3. Preocupo-me excessivamente com o que vai acontecer no futuro?',
      '4. Sinto falta de ar ou meu coração bate muito rápido quando fico assustado(a)?',
      '5. Tenho medo de falar em público, apresentar trabalhos ou passar vergonha?',
      '6. Preocupo-me muito se as outras pessoas gostam ou não de mim?',
      '7. Sinto-me paralisado(a) ou com muito medo diante de testes ou avaliações?',
      '8. Tenho pesadelos frequentes relacionados a acidentes ou perdas familiares?',
      '9. Evito ir a lugares públicos sozinho(a) por medo de que algo ruim aconteça?',
      '10. Sinto tremores, tonturas ou suor frio quando fico sob forte tensão?',
    ],

    'Escala de Autoestima de Rosemberg': [
      '1. Sinto que sou uma pessoa de valor, pelo menos tanto quanto as outras?',
      '2. Sinto que tenho um conjunto de boas qualidades no meu jeito de ser?',
      '3. Sou inclinado(a) a pensar que sou um(a) fracassado(a) em grande parte do tempo?',
      '4. Sou capaz de fazer as coisas tão bem quanto a maioria das outras pessoas?',
      '5. Sinto que não tenho muito do que me orgulhar na minha trajetória?',
      '6. Tenho uma atitude positiva, otimista e confiante em relação a mim mesmo(a)?',
      '7. No geral, estou muito satisfeito(a) com a pessoa que sou atualmente?',
      '8. Gostaria de poder ter mais respeito por mim mesmo(a) do que tenho hoje?',
      '9. Sinto-me inútil ou incapaz em determinados momentos ou tarefas?',
      '10. Penso que, definitivamente, sou uma pessoa que não serve para nada?',
    ],

    // === NOVAS ESCALAS SOLICITADAS ===
    'Escala HADS (Ansiedade e Depressão)': [
      '1. Sinto-se tenso(a) ou contraído(a) (com os nervos à flor da pele)?',
      '2. Sinto o mesmo prazer de antes pelas coisas que costumava gostar?',
      '3. Tenho uma sensação de medo ou pavor, como se algo ruim fosse acontecer?',
      '4. Sou capaz de rir e ver o lado divertido das coisas como antes?',
      '5. Preocupações ou pensamentos ansiosos passam pela minha mente com frequência?',
      '6. Sinto-me alegre, otimista ou de bom humor no meu dia a dia?',
      '7. Consigo ficar sentado(a) à vontade, relaxado(a) e sem agitação?',
      '8. Sinto-me como se estivesse mais lento(a) para realizar minhas tarefas?',
      '9. Tenho uma sensação ruim de estômago embrulhado ou aperto no peito por ansiedade?',
      '10. Perdi o interesse em cuidar da minha aparência ou higiene pessoal?',
      '11. Sinto-me inquieto(a), agitado(a) e com necessidade de ficar me movendo?',
      '12. Olho para o futuro com otimismo e espero coisas boas da vida?',
      '13. Tenho sensações repentinas de pânico ou desespero sem motivo aparente?',
      '14. Consigo sentir prazer ou apreciar um bom livro, filme ou conversa?',
    ],

    'Protocolo GIFTS (Altas Habilidades)': [
      '1. Demonstra aprendizado ultra rápido de conceitos complexos para a idade?',
      '2. Possui vocabulário avançado, usando termos técnicos ou maduros com facilidade?',
      '3. Manifesta curiosidade obsessiva, questionando o funcionamento profundo das coisas?',
      '4. Apresenta soluções altamente criativas e fora do padrão para resolver problemas?',
      '5. Mostra foco intenso (hiperfoco) e persistência em temas do seu interesse?',
      '6. Expressa sensibilidade aguçada ou forte senso de justiça e empatia?',
      '7. Demonstra memória de longo prazo excepcional para facts, dados ou imagens?',
    ],

    'Checklist de Triagem de Dislexia': [
      '1. Apresenta leitura lenta, silabada, com troca ou omissão de letras e fonemas?',
      '2. Manifesta dificuldade acentuada para associar letras aos seus sons correspondentes?',
      '3. Demonstra lentidão excessiva para copiar textos do quadro ou de livros?',
      '4. Confunde frequentemente a ordem das letras em palavras simples (ex: "b" e "d", "p" e "q")?',
      '5. Tem dificuldade para compreender ou reter o sentido do texto que acabou de ler?',
      '6. Evita ou reluta em engajar-se em atividades que exijam leitura em voz alta?',
      '7. Apresenta erros ortográficos bizarros ou inversões de sílabas na escrita?',
      '8. Demonstra dificuldade para memorizar rimas, sequências ou dias da semana?',
      '9. Confunde direções espaciais básicas como esquerda, direita, acima ou abaixo?',
      '10. Sente cansaço físico ou dores de cabeça relatadas após curtos períodos de leitura?',
    ],
    // 4. TRIAGEM EAT COMPLETA (10 perguntas)
    'Triagem EAT (Transtornos Alimentares)': [
      '1. Preocupa-se excessiva ou obsessivamente com o peso corporal e as calorias dos alimentos?',
      '2. Evita comer quando está com fome por medo de engordar ou perder o controle?',
      '3. Sente uma culpa intensa, arrependimento ou ansiedade logo após realizar as refeições?',
      '4. Apresenta o comportamento de cortar a comida em pedaços milimétricos ou mastigar excessivamente?',
      '5. Sente que a comida ou o controle do peso domina grande parte dos seus pensamentos diários?',
      '6. Percebe sua imagem corporal de forma distorcida (sentir-se acima do peso mesmo estando magro/a)?',
      '7. Pratica exercícios físicos de forma exaustiva ou punitiva com o único objetivo de queimar calorias?',
      '8. Isola-se de eventos sociais ou familiares que envolvam a partilha de refeições?',
      '9. Apresenta episódios de compulsão alimentar seguidos pelo desejo de purgação ou jejum extremo?',
      '10. Sente-se pressionado(a) ou cobrado(a) por padrões estéticos externos e familiares?',
    ],

    // 5. IGI COMPLETO (7 perguntas)
    'IGI (Índice de Gratidão Integral)': [
      '1. Costuma reconhecer e valorizar as pequenas coisas positivas que acontecem no seu dia?',
      '2. Expressa agradecimento de forma frequente às pessoas que te ajudam ou apoiam?',
      '3. Consegue encontrar aprendizados ou pontos de resiliência mesmo diante de dias difíceis?',
      '4. Sente-se satisfeito(a) e grato(a) pelas conquistas e pela vida que possui atualmente?',
      '5. Reflete sobre o impacto positivo que os seus amigos e familiares exercem na sua rotina?',
      '6. Pratica o hábito de pausar e contemplar momentos de calmaria, natureza ou bem-estar?',
      '7. Sente que cultivar uma postura grata melhora o seu humor e o seu relacionamento com os outros?',
    ],

    // 6. MDQ COMPLETO (10 perguntas)
    'MDQ (Rastreio de Transtorno de Humor)': [
      '1. Já teve períodos em que se sentiu tão bem, animado(a) ou hiperativo(a) que as pessoas acharam que não era você?',
      '2. Apresentou fases de irritabilidade extrema, a ponto de gritar com pessoas ou iniciar brigas por motivos bobos?',
      '3. Já se sentiu tão autoconfiante, invencível ou superior aos outros de forma fora do seu comum?',
      '4. Passou por momentos em que precisou dormir muito menos que o habitual e ainda assim manteve energia total?',
      '5. Teve períodos em que seus pensamentos corriam de forma ultra rápida ou sua fala ficou acelerada e difícil de parar?',
      '6. Distraiu-se com tanta facilidade por pequenos estímulos a ponto de não conseguir concluir nenhuma tarefa?',
      '7. Apresentou episódios de impulsividade excessiva em compras, negócios ou decisões sem medir os riscos?',
      '8. Já se envolveu em comportamentos de busca por adrenalina ou comportamentos de risco fora do seu padrão típico?',
      '9. Essas oscilações marcantes de comportamento e energia já foram notadas ou comentadas por familiares e amigos?',
      '10. Esses episódios de oscilação de humor já causaram prejuízos reais, brigas ou problemas no trabalho, escola ou família?',
    ],

    // 7. TRIAGEM DE IDEAÇÃO EROTOMANÍACA E APEGO BORDERLINE COMPLETO (10 perguntas)
    'Ideação Erotomaníaca e Apego Borderline': [
      '1. Nutre a crença fixa e intensa de que uma pessoa (geralmente de status social superior ou figura pública) está secretamente apaixonada por você?',
      '2. Interpreta pequenos sinais casuais ou olhares de terceiros como declarações ocultas de amor ou interesse?',
      '3. Dedica grande parte do dia em tentativas de contato (mensagens, cartas, redes sociais) com essa pessoa, mesmo sem reciprocidade?',
      '4. Sente uma ansiedade desesperadora ou pânico diante da menor suspeita de rejeição ou distanciamento de alguém de quem é apegado(a)?',
      '5. Costuma idealizar uma pessoa de forma extrema em um dia e, logo em seguida, passar a desvalorizá-la ou odiá-la profundamente?',
      '6. Cria cenários fantasiosos complexos e persistentes de relacionamento amoroso com indivíduos com quem tem pouco ou nenhum vínculo real?',
      '7. Apresenta ciúme obsessivo, controlador ou possessivo que costuma assustar ou afastar seus parceiros e amigos?',
      '8. Já realizou comportamentos de vigilância ou perseguição (presencial ou digital) para monitorar a rotina de alguém?',
      '9. Sente um vazio interno crônico que tenta preencher fixando-se obsessivamente na atenção de uma única pessoa?',
      '10. Isola-se de suas obrigações diárias, familiares ou sociais para focar exclusivamente em pensamentos românticos obsessivos?',
    ],

    // 8. CHECKLIST DE TRIAGEM E SINAIS DE DISCALCULIA COMPLETO (10 perguntas)
    'Checklist de Triagem de Discalculia': [
      '1. Apresenta dificuldade acentuada para compreender o conceito de quantidade (ex: saber qual número é maior entre 7 e 9)?',
      '2. Depende excessivamente do uso dos dedos para realizar contagens e somas muito simples e básicas para a idade?',
      '3. Confunde ou inverte frequentemente os sinais das operações matemáticas básicas (como confundir "+" com "x")?',
      '4. Manifesta enorme lentidão ou incapacidade para decorar e reter a tabuada básica na memória?',
      '5. Tem dificuldade crônica para entender e organizar números em colunas de unidade, dezena e centena?',
      '6. Demonstra problemas para ler e interpretar tabelas simples, gráficos ou problemas matemáticos textuais?',
      '7. Confunde de forma recorrente numerais que possuem grafias ou sons visualmente parecidos (ex: "6" e "9", "3" e "8")?',
      '8. Apresenta falhas acentuadas para estimar medidas simples, peso, distâncias ou o valor do troco em compras?',
      '9. Demonstra grande dificuldade para aprender a ler as horas em relógios analógicos de ponteiro?',
      '10. Manifesta forte ansiedade, bloqueio ou recusa emotional quando exposto(a) a tarefas que envolvam cálculos?',
    ],
  }; // Fecha o mapa de perguntas de forma correta
} // Fecha a classe principal
