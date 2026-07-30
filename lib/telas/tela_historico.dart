import 'package:flutter/material.dart';
import '../dados/servico_historico.dart';
import '../servicos/servicos_pdf.dart'; // Importa o seu serviço de PDF

class TelaHistorico extends StatelessWidget {
  const TelaHistorico({super.key});

  // Função auxiliar interna para gerar as iniciais automaticamente (Conformidade LGPD)
  String _extrairIniciais(String nomeCompleto) {
    if (nomeCompleto.trim().isEmpty) return 'P.A.';
    List<String> partes = nomeCompleto.trim().split(' ');
    String iniciais = '';
    for (var parte in partes) {
      if (parte.isNotEmpty) {
        iniciais += '${parte[0].toUpperCase()}.';
      }
    }
    return iniciais;
  }

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
              
              final nomePaciente = item['nomePaciente'] ?? item['nome'] ?? 'Paciente';
              final nomeTeste = item['nomeTeste'] ?? item['teste'] ?? 'Teste Não Informado';
              final dataFormatada = item['data'] ?? 'Sem data';
              
              // Recupera a pontuação tratando se ela vier como String ou número
              final rawPontuacao = item['pontuacao'] ?? 0.0;
              final double pontuacaoObtida = double.tryParse(rawPontuacao.toString()) ?? 0.0;
              
              // Garante a recuperação do texto descritivo clínico que salvamos
              final classificacaoClinica = item['classificacao'] ?? 'Triagem concluída com sucesso.';

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
                  trailing: const Icon(Icons.share, color: Colors.deepPurple), // Ícone mudado para representar compartilhamento
                  onTap: () async {
                    // AMARRAÇÃO COMPLETA: Dispara o seu serviço de PDF nativo!
                    final iniciais = _extrairIniciais(nomePaciente);
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gerando laudo em PDF para $iniciais...')),
                    );

                    await ServicoPdf.gerarECompartilharLaudo(
                      iniciaisPaciente: iniciais,
                      nomeDoTeste: nomeTeste,
                      pontuacao: pontuacaoObtida,
                      recomendacao: classificacaoClinica,
                    );
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
