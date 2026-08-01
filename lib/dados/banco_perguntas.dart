import '../dados/escalas_neuro.dart';
import '../dados/escalas_comportamento.dart';
import '../dados/escalas_socioemocional.dart';
import '../dados/escalas_adulto.dart';

class BancoPerguntas {
  static final Map<String, List<String>> triagens = {
    // 1. CARREGA TODAS AS PERGUNTAS DE TODOS OS ARQUIVOS AUTOMATICAMENTE
    ...EscalasNeuro.perguntas,
    ...EscalasComportamento.perguntas,
    ...EscalasSocioemocional.perguntas,
    ...EscalasAdulto.perguntas,

    // 2. PROTEÇÃO ADICIONAL: Amarrações explícitas para garantir que nenhum nome cortado na Tela Principal dê erro
    'M-CHAT-R/F (TEA Inicial)': EscalasNeuro.perguntas['M-CHAT-R/F'] ?? EscalasNeuro.perguntas['M-CHAT'] ?? [],
    'Escala CARS (Autismo Infantil)': EscalasNeuro.perguntas['Escala CARS'] ?? EscalasNeuro.perguntas['CARS'] ?? [],
    'Escala ASRS-18 (Rastreio TDAH)': EscalasNeuro.perguntas['Escala ASRS-18'] ?? EscalasNeuro.perguntas['ASRS-18'] ?? [],
    'Escala ATA (Traços Autísticos)': EscalasNeuro.perguntas['Escala ATA'] ?? EscalasNeuro.perguntas['ATA'] ?? [],
    'Escala ABC (Behavior Checklist)': EscalasNeuro.perguntas['Escala ABC'] ?? EscalasNeuro.perguntas['ABC'] ?? [],
    
    'Triagem de Atenção Visual': EscalasNeuro.perguntas['Triagem de Atenção Visual'] ?? 
        EscalasNeuro.perguntas['Atenção Visual'] ?? 
        ['1. Apresenta distratibilidade acentuada em tarefas simples?', '2. Dificuldade em manter o foco visual sustentado?'],
        
    'Memória de Curto Prazo': EscalasNeuro.perguntas['Memória de Curto Prazo'] ?? 
        EscalasNeuro.perguntas['Memória'] ?? 
        ['1. Dificuldade em reter instruções faladas imediatamente?', '2. Apresenta lapsos de retenção operacional recente?'],
  };
}
