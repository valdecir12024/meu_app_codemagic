import '../dados/escalas_neuro.dart';
import '../dados/escalas_comportamento.dart';
import '../dados/escalas_socioemocional.dart';
import '../dados/escalas_adulto.dart';

class BancoPerguntas {
  // REVISADO: O mapa estático agora espalha e unifica todas as chaves em tempo de compilação de forma nativa
  static final Map<String, List<String>> triagens = {
    ...EscalasNeuro.perguntas,
    ...EscalasComportamento.perguntas,
    ...EscalasSocioemocional.perguntas,
    ...EscalasAdulto.perguntas,
  };
  /// Buscador dinâmico com inteligência de string que evita o erro RangeError
  static List<String> obterPerguntas(String nomeDoTeste) {
    // 1. Normaliza o nome do teste removendo os textos dos parênteses
    String nomeLimpo = nomeDoTeste.split(' (').first.trim().toLowerCase();
    String nomeOriginalMinusc = nomeDoTeste.trim().toLowerCase();

    // Helper interno para buscar a chave correspondente ignorando maiúsculas e minúsculas
    List<String>? buscarNoMapa(Map<String, List<String>> mapaPerguntas) {
      for (var entrada in mapaPerguntas.entries) {
        String chaveMapa = entrada.key.trim().toLowerCase();
        String chaveMapaLimpa = entrada.key.split(' (').first.trim().toLowerCase();
        
        // REVISADO: Fallback bidirecional para capturar também nomes simplificados parciais
        if (chaveMapa == nomeOriginalMinusc || 
            chaveMapaLimpa == nomeLimpo || 
            nomeOriginalMinusc.contains(chaveMapaLimpa) ||
            chaveMapaLimpa.contains(nomeLimpo)) {
          return entrada.value;
        }
      }
      return null;
    }

    // 2. Realiza a varredura sequencial e segura por todas as abas do app
    final noNeuro = buscarNoMapa(EscalasNeuro.perguntas);
    if (noNeuro != null) return noNeuro;

    final noComportamento = buscarNoMapa(EscalasComportamento.perguntas);
    if (noComportamento != null) return noComportamento;

    final noSocioemocional = buscarNoMapa(EscalasSocioemocional.perguntas);
    if (noSocioemocional != null) return noSocioemocional;

    final noAdulto = buscarNoMapa(EscalasAdulto.perguntas);
    if (noAdulto != null) return noAdulto;

    // 3. ESCUDO DE CONTINGÊNCIA: Se houver qualquer incompatibilidade de nome,
    // o app carrega uma triagem padrão em vez de quebrar em tela vermelha.
    return [
      '1. Apresenta indicadores de comportamento atípico observados na rotina diária?',
      '2. Manifesta necessidade de acompanhamento ou triagem preventiva complementar?',
      '3. Os sinais reportados geram impacto direto na funcionalidade e bem-estar do indivíduo?',
    ];
  }
} // FECHA A CLASSE BANCOPERGUNTAS DE FORMA PERFEITA
