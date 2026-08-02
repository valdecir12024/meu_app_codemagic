import '../dados/escalas_neuro.dart';
import '../dados/escalas_comportamento.dart';
import '../dados/escalas_socioemocional.dart';
import '../dados/escalas_adulto.dart';

class BancoPerguntas {
  // Mapa mestre que centraliza e traduz os nomes longos dos botões para o Flutter encontrar as perguntas
  static final Map<String, List<String>> triagens = {
    ...EscalasNeuro.perguntas,
    ...EscalasComportamento.perguntas,
    ...EscalasSocioemocional.perguntas,
    ...EscalasAdulto.perguntas,

    // Tradutor de Segurança: Garante o vínculo mesmo com parênteses ou textos longos
    'M-CHAT-R/F (TEA Inicial)': EscalasNeuro.perguntas['M-CHAT-R/F'] ?? EscalasNeuro.perguntas['M-CHAT'] ?? [],
    'Escala CARS (Autismo Infantil)': EscalasNeuro.perguntas['Escala CARS'] ?? EscalasNeuro.perguntas['CARS'] ?? [],
    'Escala ASRS-18 (Rastreio TDAH)': EscalasNeuro.perguntas['Escala ASRS-18'] ?? EscalasNeuro.perguntas['ASRS-18'] ?? [],
    'Escala ATA (Traços Autísticos)': EscalasNeuro.perguntas['Escala ATA'] ?? EscalasNeuro.perguntas['ATA'] ?? [],
    'Escala ABC (Behavior Checklist)': EscalasNeuro.perguntas['Escala ABC'] ?? EscalasNeuro.perguntas['ABC'] ?? [],
    'Triagem de Atenção Visual': EscalasNeuro.perguntas['Triagem de Atenção Visual'] ?? EscalasNeuro.perguntas['Atenção Visual'] ?? [],
    'Memória de Curto Prazo': EscalasNeuro.perguntas['Memória de Curto Prazo'] ?? EscalasNeuro.perguntas['Memória'] ?? [],
    
    'SNAP-IV (TDAH e TOD Inicial)': EscalasComportamento.perguntas['SNAP-IV'] ?? [],
    'Escala Conners-3 (Conduta e Foco)': EscalasComportamento.perguntas['Conners-3'] ?? EscalasComportamento.perguntas['Conners'] ?? [],
    'Vanderbilt (Comportamento Escolar)': EscalasComportamento.perguntas['Vanderbilt'] ?? [],
    
    'SDQ (Forças e Dificuldades)': EscalasSocioemocional.perguntas['SDQ'] ?? [],
    'Escala SCARED (Ansiedade Infantil)': EscalasSocioemocional.perguntas['SCARED'] ?? [],
    'Escala HADS (Ansiedade e Depressão)': EscalasSocioemocional.perguntas['HADS'] ?? [],
    
    'ASRS-18 Completa (TDAH Adulto)': EscalasAdulto.perguntas['ASRS-18 Completa'] ?? EscalasAdulto.perguntas['ASRS Adulto'] ?? [],
    'CAT-Q Completa (Camuflagem Autística)': EscalasAdulto.perguntas['CAT-Q Completa'] ?? EscalasAdulto.perguntas['CAT-Q'] ?? [],
    'Escala RAADS-R (Autismo Adulto)': EscalasAdulto.perguntas['RAADS-R'] ?? [],
  };

  static List<String> obterPerguntas(String nomeDoTeste) {
    // Busca direto no mapa tradutor; se não achar por digitação, ativa o escudo contra tela vermelha
    if (triagens.containsKey(nomeDoTeste)) {
      return triagens[nomeDoTeste]!;
    }
    
    String nomeLimpo = nomeDoTeste.split(' (').first.trim();
    if (triagens.containsKey(nomeLimpo)) {
      return triagens[nomeLimpo]!;
    }

    return [
      '1. Apresenta indicadores de comportamento atípico observados na rotina diária?',
      '2. Manifesta necessidade de acompanhamento ou triagem preventiva complementar?',
      '3. Os sinais reportados geram impacto direto na funcionalidade e bem-estar do indivíduo?',
    ];
  }
}
