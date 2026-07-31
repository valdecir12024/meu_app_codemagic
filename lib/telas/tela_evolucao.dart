import 'package:flutter/material.dart';

class TelaEvolucao extends StatelessWidget {
  final String nomePaciente;
  final String nomeTeste;
  final List<Map<String, dynamic>> registrosDoPaciente;

  const TelaEvolucao({
    super.key,
    required this.nomePaciente,
    required this.nomeTeste,
    required this.registrosDoPaciente,
  });

  @override
  Widget build(BuildContext context) {
    // Filtra e organiza os registros específicos deste paciente para este teste específico
    final examesFiltrados = registrosDoPaciente.where((item) {
      final nome = (item['nomePaciente'] ?? item['nome'] ?? '').toString();
      final teste = (item['nomeTeste'] ?? item['teste'] ?? '').toString();
      return nome == nomePaciente && teste == nomeTeste;
    }).toList().reversed.toList(); // Ordena do mais antigo para o mais recente

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text('Evolução Temporal'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(nomePaciente, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            Text('Escala: $nomeTeste', style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 32),
            
            if (examesFiltrados.length < 2)
              const Expanded(
                child: Center(
                  child: Text(
                    'Realize este mesmo teste mais de uma vez com o paciente para plotar o gráfico comparativo de evolução.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              )
            else
              Expanded(
                child: Column(
                  children: [
                    const Text('Histórico de Pontuações:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    // Renderiza o gráfico de barras verticais de forma nativa e leve
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: examesFiltrados.map((exame) {
                          final pontos = double.tryParse((exame['pontuacao'] ?? 0).toString()) ?? 0.0;
                          final data = exame['data'] ?? 'S/D';
                          
                          // Limita a altura proporcional máxima baseado em escalas de até 60 pontos
                          double alturaBarra = (pontos / 60) * 200;
                          if (alturaBarra < 20) alturaBarra = 20; // Altura mínima visível
                          if (alturaBarra > 250) alturaBarra = 250;

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${pontos.toStringAsFixed(1)} pts', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              const SizedBox(height: 8),
                              Container(
                                width: 45,
                                height: alturaBarra,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.withOpacity(0.8),
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(data, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
