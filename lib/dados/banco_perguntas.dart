import 'escalas_neuro.dart';
import 'escalas_comportamento.dart';
import 'escalas_socioemocional.dart';
import 'escala_abc.dart';

class BancoPerguntas {
  static final Map<String, List<String>> triagens = {
    // 1. ATENÇÃO VISUAL COMPLETA (9 perguntas)
    'Triagem de Atenção Visual': [
      '1. Com que frequência deixa de prestar atenção a detalhes ou comete erros por descuido em atividades escolares ou tarefas?',
      '2. Tem dificuldade para manter a atenção em tarefas, explicações ou atividades lúdicas prolongadas?',
      '3. Parece não ouvir quando alguém se dirige diretamente a ele(a) (parece estar com a mente longe)?',
      '4. Tem dificuldade em seguir instruções até o fim e não consegue terminar deveres ou tarefas organizadas?',
      '5. Apresenta dificuldades frequentes para organizar tarefas, materiais, brinquedos e cronogramas de atividades?',
      '6. Evita, demonstra aversão ou reluta em engajar-se em tarefas que exigem esforço mental prolongado ou foco contínuo?',
      '7. Perde com frequência objetos necessários para tarefas ou atividades diárias (lápis, livros, brinquedos, ferramentas)?',
      '8. Distrai-se facilmente por qualquer tipo de estímulo alheio à atividade (visuais ou sonoros externos)?',
      '9. Demonstra esquecimento frequente em atividades e rotinas cotidianas básicas de autocuidado ou estudo?',
    ],

    // 2. MEMÓRIA DE CURTO PRAZO COMPLETA (7 perguntas)
    'Memória de Curto Prazo': [
      '1. Tem dificuldade em lembrar de uma instrução com 2 ou 3 passos que acabou de ser dita?',
      '2. Esquece o início de uma frase longa ou de uma história antes que ela termine?',
      '3. Demonstra dificuldade em memorizar pequenas sequências faladas (como números de telefone ou recados)?',
      '4. Distrai-se e perde o fio da meada no meio de uma contagem ou leitura simples?',
      '5. Apresenta lentidão ou esquecimento ao tentar reproduzir padrões visuais simples apresentados logo antes?',
      '6. Esquece rapidamente o que foi buscar ou fazer ao mudar de um cômodo para outro?',
      '7. Demonstra cansaço ou irritabilidade extrema em atividades que exigem guardar regras mentais ativas (jogos de tabuleiro, etc)?',
    ],
    
    ...EscalasNeuro.perguntas,
    ...EscalasComportamento.perguntas,
    ...EscalasSocioemocional.perguntas,
    'Escala ABC (Behavior Checklist)': EscalaAbc.itens.map((item) => item['pergunta'] as String).toList(),
  };
}
