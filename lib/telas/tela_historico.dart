import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import '../dados/servico_historico.dart';
import '../servicos/servicos_pdf.dart';
import 'tela_evolucao.dart';

class TelaHistorico extends StatefulWidget {
  const TelaHistorico({super.key});

  @override
  State<TelaHistorico> createState() => _TelaHistoricoState();
}

class _TelaHistoricoState extends State<TelaHistorico> {
  List<Map<String, dynamic>> _historicoCompleto = [];
  List<Map<String, dynamic>> _historicoFiltrado = [];
  bool _carregando = true;
  String _filtroEscalaSelecionada = 'Todos';
  final TextEditingController _buscaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final dados = await ServicoHistorico.obterHistorico(); // ◄ Altere para obterHistorico
    setState(() {
      _historicoCompleto = dados;
      _historicoFiltrado = dados;
      _carregando = false;
    });
  }

  // Função para converter o banco em planilha Excel/CSV e compartilhar
  Future<void> _exportarPlanilhaCSV() async {
    if (_historicoCompleto.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não há dados para exportar.')),
      );
      return;
    }

    String csvDados = 'Nome Paciente;Escala Aplicada;Pontuacao;Data\n';
    for (var item in _historicoCompleto) {
      final nome = item['nomePaciente'] ?? item['nome'] ?? 'Paciente';
      final teste = item['nomeTeste'] ?? item['teste'] ?? 'Teste';
      final pontos = item['pontuacao'] ?? '0';
      final data = item['data'] ?? 'S/D';
      csvDados += '$nome;$teste;$pontos;$data\n';
    }

    await Share.share(csvDados, subject: 'Planilha de Triagens NeuroApp');
  }

  Future<void> _limparHistoricoCompleto() async {
    final confirmou = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar Histórico?'),
        content: const Text('Isso apagará permanentemente todos os relatórios salvos localmente.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          TextButton(
            onPressed: () => Navigator.pop(context, true), 
            child: const Text('Apagar Tudo', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmou == true) {
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('historico_triagens');
        _carregarDados();
      } catch (e) {
        debugPrint('Erro na limpeza.');
      }
    }
  }

  void _aplicarFiltros() {
    final textoBusca = _buscaController.text.toLowerCase();
    setState(() {
      _historicoFiltrado = _historicoCompleto.where((item) {
        final nome = (item['nomePaciente'] ?? item['nome'] ?? '').toString().toLowerCase();
        final teste = (item['nomeTeste'] ?? item['teste'] ?? '').toString();
        
        bool bateComNome = nome.contains(textoBusca);
        bool bateComEscala = _filtroEscalaSelecionada == 'Todos' || teste.contains(_filtroEscalaSelecionada);
        
        return bateComNome && bateComEscala;
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
        actions: [
          IconButton(
            icon: const Icon(Icons.table_view),
            tooltip: 'Exportar Excel/CSV',
            onPressed: _exportarPlanilhaCSV,
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Limpar tudo',
            onPressed: _limparHistoricoCompleto,
          ),
        ],
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator(color: Colors.deepPurple))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: TextField(
                    controller: _buscaController,
                    onChanged: (_) => _aplicarFiltros(),
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: Row(
                    children: ['Todos', 'M-CHAT', 'CARS', 'SNAP-IV', 'ASRS-18'].map((escala) {
                      final bool ativa = _filtroEscalaSelecionada == escala;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(escala),
                          selected: ativa,
                          selectedColor: Colors.deepPurple,
                          labelStyle: TextStyle(color: ativa ? Colors.white : Colors.deepPurple),
                          onSelected: (bool selecionado) {
                            if (selecionado) {
                              _filtroEscalaSelecionada = escala;
                              _aplicarFiltros();
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 8),
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

                            bool possuiAlerta = (nomeTeste.contains('M-CHAT') && pontuacaoObtida >= 3) ||
                                                (nomeTeste.contains('CARS') && pontuacaoObtida >= 30) ||
                                                (nomeTeste.contains('SNAP-IV') && pontuacaoObtida >= 12);

                            return Card(
                              elevation: 1,
                              margin: const EdgeInsets.only(bottom: 12.0),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                leading: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TelaEvolucao(
                                          nomePaciente: nomePaciente,
                                          nomeTeste: nomeTeste,
                                          registrosDoPaciente: _historicoCompleto,
                                        ),
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.deepPurple.withOpacity(0.1),
                                    child: const Icon(Icons.analytics, color: Colors.deepPurple),
                                  ),
                                ),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: Text(nomePaciente, style: const TextStyle(fontWeight: FontWeight.bold))),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: possuiAlerta ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        possuiAlerta ? 'Alerta Clínico' : 'Típico',
                                        style: TextStyle(
                                          fontSize: 11, 
                                          fontWeight: FontWeight.bold, 
                                          color: possuiAlerta ? Colors.red : Colors.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
