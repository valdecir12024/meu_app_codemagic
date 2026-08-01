import '../dados/escalas_neuro.dart';
import '../dados/escalas_comportamento.dart';
import '../dados/escalas_socioemocional.dart';
import '../dados/escalas_adulto.dart';

class BancoPerguntas {
  static final Map<String, List<String>> triagens = {};

  // Método de inicialização dinâmica que junta todas as perguntas com proteção total
  static List<String> obterPerguntas(String nomeDoTeste) {
    // 1. Busca os nomes limpando os parênteses para evitar erros de digitação
    String nomeLimpo = nomeDoTeste.split(' (').first.trim();

    // 2. Procura nas Escalas de Neuro
    if (EscalasNeuro.perguntas.containsKey(nomeDoTeste)) return EscalasNeuro.perguntas[nomeDoTeste]!;
    if (EscalasNeuro.perguntas.containsKey(nomeLimpo)) return EscalasNeuro.perguntas[nomeLimpo]!;

    // 3. Procura nas Escalas de Comportamento
    if (EscalasComportamento.perguntas.containsKey(nomeDoTeste)) return EscalasComportamento.perguntas[nomeDoTeste]!;
    if (EscalasComportamento.perguntas.containsKey(nomeLimpo)) return EscalasComportamento.perguntas[nomeLimpo]!;

    // 4. Procura nas Escalas Socioemocionais
    if (EscalasSocioemocional.perguntas.containsKey(nomeDoTeste)) return EscalasSocioemocional.perguntas[nomeDoTeste]!;
    if (EscalasSocioemocional.perguntas.containsKey(nomeLimpo)) return EscalasSocioemocional.perguntas[nomeLimpo]!;

    // 5. Procura nas Escalas de Adultos / EJA
    if (EscalasAdulto.perguntas.containsKey(nomeDoTeste)) return EscalasAdulto.perguntas[nomeDoTeste]!;
    if (EscalasAdulto.perguntas.containsKey(nomeLimpo)) return EscalasAdulto.perguntas[nomeLimpo]!;

    // 6. Escudo de contingência (Evita que o app fique com zero perguntas e dê a tela vermelha)
    return [
      '1. Apresenta indicadores de comportamento atípico observados na rotina?',
      '2. Manifesta necessidade de acompanhamento ou triagem preventiva complementar?',
      '3. Sinais reportados geram impacto direto na funcionalidade diária?',
    ];
  }
}
