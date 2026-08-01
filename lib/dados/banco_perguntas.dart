import '../dados/escalas_neuro.dart';
import '../dados/escalas_comportamento.dart';
import '../dados/escalas_socioemocional.dart';
import '../dados/escalas_adulto.dart';

class BancoPerguntas {
  // Mapa unificador mestre que a TelaQuestionario lê de forma automatizada
  static final Map<String, List<String>> triagens = {
    // Insere todas as perguntas de Neuro infantis
    ...EscalasNeuro.perguntas,

    // Insere todas as perguntas de Comportamento infantis
    ...EscalasComportamento.perguntas,

    // Insere todas as perguntas Socioemocionais infantis
    ...EscalasSocioemocional.perguntas,

    // CORREÇÃO: Força o derramamento das 14 novas escalas completas de Adultos e EJA
    ...EscalasAdulto.perguntas,
  };
}
