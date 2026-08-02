import 'package:flutter/material.dart';

class TelaManual extends StatelessWidget {
  const TelaManual({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text('Guia Técnico de Aplicação'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Suporte à Decisão Clínica e Roteiro de Observação',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
          ),
          // ===================================================================
          // SEÇÃO 1: DIRETRIZES DA ABA 1 (NEURO)
          // ===================================================================
          _construirCardCategoria(
            titulo: 'Aba 1: Diretrizes Neuro',
            cor: Colors.blue,
            icon: Icons.psychology,
            manuais: [
              _ItemManual(
                tituloEscala: 'M-CHAT-R/F (TEA Inicial)',
                roteiroPerguntas: 'Entrevista direta com pais/responsáveis de crianças entre 16 e 30 meses. Foco em comportamentos de Sim ou Não.',
                focoObservacao: 'Observe a atenção compartilhada, o contato visual ao comando do nome e o uso espontâneo do gesto de apontar para mostrar interesse.',
                reguaDecisao: 'Cada resposta "Não" (exceto itens 2, 5 e 12) soma 1 ponto. Pontuação >= 3 exige monitoramento; >= 8 risco elevado.',
              ),
              _ItemManual(
                tituloEscala: 'Escala CARS (Autismo Infantil)',
                roteiroPerguntas: 'Aplicação observacional retrospectiva (15 categorias). O avaliador pontua com base na sessão clínica, relatórios escolares e pais.',
                focoObservacao: 'Avalie a modulação do afeto, presença de maneirismos repetitivos (flapping), seletividade alimentar severa e reações a ruídos.',
                reguaDecisao: 'Notas de 1.0 a 4.0 evoluindo de meio em meio ponto. Soma < 30 (típico), 30 a 36.5 (leve/moderado), >= 37 (grave).',
              ),
              _ItemManual(
                tituloEscala: 'Escala ABC (Autism Behavior Checklist)',
                roteiroPerguntas: 'Comportamentos respondidos por Sim/Não através de informantes primários (professores ou familiares).',
                focoObservacao: 'Foco em 5 subescalas: Sensorial, Relacionamento, Uso do Corpo/Objetos, Linguagem e Autocuidado.',
                reguaDecisao: 'Cada item marcado como "Sim" extrai um peso estatístico de 2 a 4. Escore total >= 54 indica risco moderado; >= 68 alta probabilidade.',
              ),
            ],
          ),

          const SizedBox(height: 12),
          // ===================================================================
          // SEÇÃO 2: DIRETRIZES DA ABA 2 (COMPORTAMENTO)
          // ===================================================================
          _construirCardCategoria(
            titulo: 'Aba 2: Diretrizes Comportamento',
            cor: Colors.orange,
            icon: Icons.accessibility_new,
            manuais: [
              _ItemManual(
                tituloEscala: 'SNAP-IV (TDAH e TOD Inicial)',
                roteiroPerguntas: 'Avaliação de frequência direcionada a pais e professores sobre comportamentos em sala de aula e na rotina familiar.',
                focoObservacao: 'Analise os 9 primeiros itens para desatenção crônica, os 9 seguintes para hiperatividade/impulsividade e os 8 finais para oposição desafiadora.',
                reguaDecisao: 'Respostas variam por gradação de frequência. Concentração acentuada de marcações em "Frequentemente/Sempre" sugere rastreio positivo clínico.',
              ),
              _ItemManual(
                tituloEscala: 'Escala ICU (Traços Insensíveis e Frios)',
                roteiroPerguntas: 'Investigação de rigidez comportamental e padrões afetivos em ambiente infantojuvenil.',
                focoObservacao: 'Observe a ausência real de remorso, frieza em tratos relacionais cotidianos ou aparente indiferença a punições severas.',
                reguaDecisao: 'Escore limite de corte estabelecido em >= 25 pontos indicando risco elevado para traços de insensibilidade emocional.',
              ),
            ],
          ),

          const SizedBox(height: 12),
          // ===================================================================
          // SEÇÃO 3: DIRETRIZES DA ABA 3 (SOCIOEMOCIONAL)
          // ===================================================================
          _construirCardCategoria(
            titulo: 'Aba 3: Diretrizes Socioemocional',
            cor: Colors.green,
            icon: Icons.emoji_emotions,
            manuais: [
              _ItemManual(
                tituloEscala: 'SDQ (Forças e Dificuldades)',
                roteiroPerguntas: 'Rastreio preventivo rápido de saúde mental infantojuvenil (25 itens estruturados).',
                focoObservacao: 'Isola sintomas emocionais, problemas de conduta, hiperatividade, problemas de relacionamento com colegas e conduta proscial.',
                reguaDecisao: 'Escore total de dificuldades computado na soma das 4 subescalas negativas. Total >= 17 indica perfil clínico/anormal.',
              ),
              _ItemManual(
                tituloEscala: 'Escala de Autoestima de Rosemberg',
                roteiroPerguntas: 'Inventário psicométrico direto autoaplicável ou assistido para mensuração de autovalorização subjetiva.',
                focoObservacao: 'Mapeie o equilíbrio entre autocritica severa, sentimentos de desvalorização ou presença de segurança adaptativa estável.',
                reguaDecisao: 'Escores finais iguais ou inferiores a 15 pontos acendem o alerta clínico indicador de autoestima fragilizada.',
              ),
            ],
          ),

          const SizedBox(height: 12),
          // ===================================================================
          // SEÇÃO 4: DIRETRIZES DA ABA 4 (ADULTO / EJA)
          // ===================================================================
          _construirCardCategoria(
            titulo: 'Aba 4: Diretrizes Adulto / EJA',
            cor: Colors.teal,
            icon: Icons.school,
            manuais: [
              _ItemManual(
                tituloEscala: 'ASRS-18 Completa (TDAH Adulto)',
                roteiroPerguntas: 'Autoavaliação oficial da OMS para investigação de déficit de atenção e inquietude operacional na vida madura.',
                focoObservacao: 'Analise o impacto funcional severo na tripla jornada (trabalho, ambiente doméstico e rotina acadêmica noturna da EJA).',
                reguaDecisao: 'Escore total cumulativo >= 24 pontos estabelece forte indicativo de risco elevado com recomendação de exame neuropsicológico formal.',
              ),
              _ItemManual(
                tituloEscala: 'CAT-Q Completa (Camuflagem Autística)',
                roteiroPerguntas: 'Mensuração de estratégias conscientes e exaustivas utilizadas para imitar interações e mascarar barreiras.',
                focoObservacao: 'Investigue o nível de fadiga mental relatado pelo adulto após eventos em público (comum na manifestação fenotípica feminina).',
                reguaDecisao: 'Escore igual ou superior a 70 pontos aciona o marcador crítico indicando alto risco para esgotamento ou burnout autístico.',
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _construirCardCategoria({
    required String titulo,
    required Color cor,
    required IconData icon,
    required List<_ItemManual> manuais,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: cor.withOpacity(0.3), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: cor.withOpacity(0.1),
          child: Icon(icon, color: cor),
        ),
        title: Text(titulo, style: TextStyle(fontWeight: FontWeight.bold, color: cor, fontSize: 16)),
        children: manuais.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                Text(
                  item.tituloEscala,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: cor),
                ),
                const SizedBox(height: 6),
                _construirLinhaTexto('🎙️ Diretrizes / Roteiro: ', item.roteiroPerguntas),
                _construirLinhaTexto('👁️ O que Observar: ', item.focoObservacao),
                _construirLinhaTexto('⚖️ Régua de Decisão: ', item.reguaDecisao),
                const SizedBox(height: 8),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _construirLinhaTexto(String prefixo, String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.3),
          children: [
            TextSpan(text: prefixo, style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: texto),
          ],
        ),
      ),
    );
  }
}

class _ItemManual {
  final String tituloEscala;
  final String rRoteiroPerguntas; 
  final String fFocoObservacao;
  final String rReguaDecisao;

  _ItemManual({
    required this.tituloEscala,
    required String roteiroPerguntas,
    required String focoObservacao,
    required String reguaDecisao,
  })  : rRoteiroPerguntas = roteiroPerguntas,
        fFocoObservacao = focoObservacao,
        rReguaDecisao = reguaDecisao;

  String get roteiroPerguntas => rRoteiroPerguntas;
  String get focoObservacao => fFocoObservacao;
  String get reguaDecisao => rReguaDecisao;
} // FECHA A CLASSE _ITEMMANUAL DE FORMA CORRETA
