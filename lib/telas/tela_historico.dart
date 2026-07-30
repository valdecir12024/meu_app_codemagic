import 'package:flutter/material.dart';
import '../dados/servico_historico.dart';
import '../servicos/servicos_pdf.dart';

class TelaHistorico extends StatefulWidget {
  const TelaHistorico({super.key});

  @override
  State<TelaHistorico> createState() => _TelaHistoricoState();
}

class _TelaHistoricoState extends State<TelaHistorico> {
  List<Map<String, dynamic>> _historicoCompleto = [];
  List<Map<String, dynamic>> _historicoFiltrado = [];
  bool _carregando = true;
  final TextEditingController _buscaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final dados = await ServicoHistorico.obterHistorico();
    setState(() {
      _historicoCompleto = dados;
      _historicoFiltrado = dados;
      _carregando = false;
    });
  }

  void _filtrarPacientes(String textoDigitado) {
    setState(() {
      _historicoFiltrado = _historicoCompleto.where((item) {
        final nome = (item['nomePaciente'] ?? item['nome'] ?? '').toString().toLowerCase();
        return nome.contains(textoDigitado.toLowerCase());
      }).toList();
    });
  }

  String _extrairIniciais(String nomeCompleto) {
    if (nomeCompleto.trim().isEmpty) return 'P.A.';
    List<String> partes = nomeCompleto.trim().split(' ');
    String iniciais = '';
    for (var parte in partes) {
      if (parte.isNotEmpty) iniciais += '${parte.toUpperCase()}.';
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
      body: _carregando
          ? const Center(child: CircularProgressIndicator(color: Colors.deepPurple))
          : Column(
              children: [
                // Aplicação 1: Barra de pesquisa integrada
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _buscaController,
                    onChanged: _filtrarPacientes,
                    decoration: InputDecoration(
                      labelText: 'Buscar paciente por nome...',
                      prefixIcon: const Icon(Icons.search, color: Colors.deepPurple),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _historicoFiltrado.isEmpty
                      ? const Center(child: Text('Nenhum relatório correspondente.'))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          itemCount: _historicoFiltrado.length,
                          itemBuilder: (context, index) {
                            final item = _historicoFiltrado[index];
                            final nomePaciente = item['nomePaciente'] ?? item['nome'] ?? 'Paciente';
                            final nomeTeste = item['nomeTeste'] ?? item['teste'] ?? 'Teste';
                            final dataFormatada = item['data'] ?? 'Sem data';
                            final double pontuacaoObtida = double.tryParse((item['pontuacao'] ?? 0).toString()) ?? 0.0;
                            final classificacaoClinica = item['classificacao'] ?? 'Triagem concluída.';

                            return Card(
                              elevation: 1,
                              margin: const EdgeInsets.only(bottom: 12.0),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.red.withOpacity(0.1),
                                  child: const Icon(Icons.picture_as_pdf, color: Colors.red),
                                ),
                                title: Text(nomePaciente, style: const TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Text('$nomeTeste\nData: $dataFormatada • Pontos: $pontuacaoObtida'),
                                isThreeLine: true,
                                trailing: const Icon(Icons.share, color: Colors.deepPurple),
                                onTap: () async {
                                  final iniciais = _extrairIniciais(nomePaciente);
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
                        ),
                ),
              ],
            ),
    );
  }
}
