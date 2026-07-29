import 'escalas_neuro.dart';
import 'escalas_comportamento.dart';
import 'escalas_socioemocional.dart';

class BancoPerguntas {
  static final Map<String, List<String>> triagens = {
    'Triagem de Atenção Visual': [
      'Com que frequência o indivíduo se distrai facilmente com estímulos visuais ao seu redor?',
      'Apresenta dificuldade em focar em detalhes em folhas de atividades ou telas?',
      'Evita ou reluta em engajar-se em tarefas que exigem espaço mental prolongado?',
    ],
    'Memória de Curto Prazo': [
      'Esquece instruções simples logo após elas terem sido ditas?',
      'Tem dificuldade em reter sequências de números ou palavras por alguns segundos?',
      'Perde objetos de uso diário com frequência (lápis, brinquedos, chaves)?',
    ],
    
    // Injeta as três categorias oficiais de forma limpa e independente
    ...EscalasNeuro.perguntas,
    ...EscalasComportamento.perguntas,
    ...EscalasSocioemocional.perguntas,
  };
}
