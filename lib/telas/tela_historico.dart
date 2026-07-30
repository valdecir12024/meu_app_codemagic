import 'package:flutter/material.dart';
import '../dados/servico_historico.dart';

class TelaHistorico extends StatelessWidget {
  const TelaHistorico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text('Histórico de Triagens'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: ServicoHistorico.obterHistorico(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.deepPurple));
          }
          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum relatório salvo no histórico local.', 
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          final historico = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: historico.length,
            itemBuilder: (context, index) {
              final item = historico[index];
              
              // Garante a leitura correta das chaves salvas pela tela do questionário
              final nomePaciente = item['nomePaciente'] ?? item['nome'] ?? 'Paciente';
              final nomeTeste = item['nomeTeste'] ?? item['teste'] ?? 'Teste Não Informado';
              final dataFormatada = item['data'] ?? 'Sem data';
              final pontuacaoObtida = item['pontuacao'] ?? 0;

              return Card(
                elevation: 1,
                margin: const EdgeInsets.only(bottom: 12.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red.withOpacity(0.1),
                    child: const Icon(Icons.picture_as_pdf, color: Colors.red),
                  ),
                  title: Text(
                    nomePaciente, 
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('$nomeTeste\nData: $dataFormatada • Pontos: $pontuacaoObtida'),
                  isThreeLine: true,
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Próxima aplicação de agrupamento: acionar a abertura do PDF
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
