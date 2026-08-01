import '../dados/escalas_neuro.dart';
import '../dados/escalas_comportamento.dart';
import '../dados/escalas_socioemocional.dart';
import '../dados/escalas_adulto.dart'; // ADICIONADO: Import do novo banco de adultos

class BancoPerguntas {
  // Mapa unificador mestre que a TelaQuestionario lê de forma automatizada
  static final Map<String, List<String>> triagens = {
    // Puxa e unifica todas as perguntas das escalas de Neuro infantis
    ...EscalasNeuro.perguntas,

    // Puxa e unifica todas as perguntas das escalas de Comportamento infantis
    ...EscalasComportamento.perguntas,

    // Puxa e unifica todas as perguntas das escalas Socioemocionais infantis
    ...EscalasSocioemocional.perguntas,

    // Puxa e unifica todas as perguntas das novas escalas de Adulto e EJA
    ...EscalasAdulto.perguntas,
  };
}
