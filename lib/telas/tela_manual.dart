import 'package:flutter/material.dart';

class TelaManual extends StatelessWidget {
  const TelaManual({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text('Guia Técnico de Escalas'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Diretrizes Científicas de Triagem',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
          const SizedBox(height: 8),
          const Text(
            'Consulte os pontos de corte e critérios oficiais para suporte à interpretação clínica e educacional:',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),

          // CARD 1: DIRETRIZES NEURO (M-CHAT E CARS)
          _construirCardManual(
            titulo: 'M-CHAT-R/F (Autismo Inicial)',
            cor: Colors.blue,
            conteudo: '• População: Crianças entre 16 e 30 meses.\n'
                      '• Foco: Rastreio precoce de risco para TEA.\n'
                      '• Pontuação de Risco (0 a 20 pontos):\n'
                      '  - 0 a 2 pontos: Baixo Risco. Acompanhar rotina.\n'
                      '  - 3 a 7 pontos: Risco Moderado. Monitorar próximo trimestre.\n'
                      '  - 8 a 20 pontos: Alto Risco. Encaminhar para especialista.',
          ),

          _construirCardManual(
            titulo: 'Escala CARS (Autismo Infantil)',
            cor: Colors.blue,
            conteudo: '• População: Crianças a partir de 2 anos.\n'
                      '• Foco: Severidade dos sintomas comportamentais.\n'
                      '• Pontuação de Corte (15 a 60 pontos):\n'
                      '  - Abaixo de 30: Desenvolvimento dentro do esperado.\n'
                      '  - 30 a 36.5: Autismo de Grau Leve a Moderado.\n'
                      '  - 37 a 60: Autismo de Grau Severo/Grave.',
          ),
          // CARD 2: DIRETRIZES DE COMPORTAMENTO
          _construirCardManual(
            titulo: 'SNAP-IV e ASRS-18 (TDAH)',
            cor: Colors.orange,
            conteudo: '• SNAP-IV: Voltado a crianças e adolescentes escolares.\n'
                      '• ASRS-18: Triagem de sintomas em adultos.\n'
                      '• Ponto de Corte Clínico:\n'
                      '  - Presença de 6 ou mais sintomas marcados como "Frequentemente" ou "Sempre" nas subescalas indica resultado positivo acima do ponto de corte.',
          ),

          _construirCardManual(
            titulo: 'Escala Conners-3 (Conduta)',
            cor: Colors.orange,
            conteudo: '• Foco: Triagem de oposição, conduta e impulsividade.\n'
                      '• Pontuação Alerta:\n'
                      '  - Escores brutos acumulados que ultrapassam 15 pontos indicam necessidade de orientação parental e triagem aprofundada.',
          ),

          // CARD 3: DIRETRIZES SOCIOEMOCIONAIS
          _construirCardManual(
            titulo: 'Questionário SDQ (Forças e Dificuldades)',
            cor: Colors.green,
            conteudo: '• População: 4 a 17 anos (Escolar/Clínico).\n'
                      '• Pontuação Total de Dificuldades (0 a 40):\n'
                      '  - 0 a 13 pontos: Perfil Clínico Típico.\n'
                      '  - 14 a 16 pontos: Perfil Limítrofe (Atenção).\n'
                      '  - 17 a 40 pontos: Perfil Clínico Anormal (Encaminhar).',
          ),

          _construirCardManual(
            titulo: 'Escala SCARED (Ansiedade)',
            cor: Colors.green,
            conteudo: '• Foco: Rastreio de pânico, ansiedade e fobia social.\n'
                      '• Ponto de Corte:\n'
                      '  - Pontuação total igual ou maior que 25 pontos é indicativa de rastreio positivo para transtornos de ansiedade na infância.',
          ),

          _construirCardManual(
            titulo: 'Escala de Autoestima de Rosemberg',
            cor: Colors.green,
            conteudo: '• Foco: Avaliação global do autovalor pessoal.\n'
                      '• Pontuação Total (0 a 30):\n'
                      '  - 15 pontos ou menos: Indicativo de Autoestima Baixa.\n'
                      '  - Acima de 15 pontos: Autoestima Saudável.',
          ),
        ],
      ),
    );
  }

  // Função auxiliar para desenhar o design dos cards de instrução
  Widget _construirCardManual({required String titulo, required Color cor, required String conteudo}) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(width: 4, height: 18, color: cor),
                const SizedBox(width: 8),
                Text(
                  titulo,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 24),
            Text(
              conteudo,
              style: const TextStyle(fontSize: 14, height: 1.4, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
