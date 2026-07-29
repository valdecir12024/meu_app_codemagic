import 'escalas_neuro.dart';
import 'escalas_comportamento.dart';

class BancoPerguntas {
  static final Map<String, List<String>> triagens = {
    // Injeta as escalas de Neuro
    ...EscalasNeuro.perguntas,

    // Injeta as novas escalas de Comportamento de forma limpa
    ...EscalasComportamento.perguntas,
  };
}
