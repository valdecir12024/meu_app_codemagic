import 'package:flutter/material.dart';
import '../dados/servico_historico.dart';

class TelaHistorico extends StatefulWidget {
  const TelaHistorico({super.key});

  @override
  State<TelaHistorico> createState() => _TelaHistoricoState();
}

class _TelaHistoricoState extends State<TelaHistorico> {
  List<Map<String, dynamic>> _historicoCompleto = [];
  List<Map<String, dynamic>> _historicoFiltrado = [];
  bool _carregando = true;
  String _filtroEscala = 'Todos';
  final TextEditingController _buscaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  // REVISADO: Chamada direta e protegida ao método estático oficial em português
  Future<void> _carregarDados() async {
    try {
      final dados = await ServicoHistorico.obterHistorico();
      
      setState(() {
        _historicoCompleto = dados;
        _historicoFiltrado = dados;
        _carregando = false;
      });
    } catch (e) {
      debugPrint('Erro ao carregar histórico visual: $e');
      setState(() {
        _carregando = false;
      });
    }
  }

  void _filtrarHistorico(String texto) {
    setState(() {
      _historicoFiltrado = _historicoCompleto.where((item) {
        final nome = (item['nome'] ?? '').toString().toLowerCase();
        final teste = (item['teste'] ?? '').toString().toLowerCase();
        final busca = texto.toLowerCase();
        
        final bateTexto = nome.contains(busca) || teste.contains(busca);
        final bateEscala = _filtroEscala == 'Todos' || teste.contains(_filtroEscala.toLowerCase());
        
        return bateTexto && bateEscala;
      }).toList();
    });
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
                // Campo de Busca Dinâmica
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _buscaController,
                    onChanged: _filtrarHistorico,
                    decoration: InputDecoration(
                      labelText: 'Buscar por paciente ou teste...',
                      prefixIcon: const Icon(Icons.search, color: Colors.deepPurple),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),

                // Filtros rápidos por Categoria de Escala em Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: ['Todos', 'M-CHAT', 'CARS', 'SNAP-IV', 'ASRS-18', 'HADS'].map((escala) {
                      final ehSelecionado = _filtroEscala == escala;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 12.0),
                        child: ChoiceChip(
                          label: Text(escala),
                          selected: ehSelecionado,
                          selectedColor: Colors.deepPurple,
                          labelStyle: TextStyle(
                            color: ehSelecionado ? Colors.white : Colors.black87,
                            fontWeight: ehSelecionado ? FontWeight.bold : FontWeight.normal,
                          ),
                          backgroundColor: Colors.white,
                          onSelected: (bool selecionado) {
                            setState(() {
                              _filtroEscala = selecionado ? escala : 'Todos';
                              _filtrarHistorico(_buscaController.text);
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // Listagem Proativa e Protegida dos Relatórios do Banco
                Expanded(
                  child: _historicoFiltrado.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhum relatório encontrado.',
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: _historicoFiltrado.length,
                          itemBuilder: (context, index) {
                            final item = _historicoFiltrado[index];
                            final nome = item['nome'] ?? 'Não Informado';
                            final teste = item['teste'] ?? 'Teste Geral';
                            final pontuacao = item['pontuacao'] ?? '0';
                            final classificationRaw = item['classificacao'] ?? 'Sem classificação disponível.';

                            // Identifica se há alerta clínico de forma reativa para colorir a tag
                            final possuiAlerta = classificationRaw.toString().contains('ALERTA') || 
                                                 classificationRaw.toString().contains('CRÍTICO') || 
                                                 classificationRaw.toString().contains('ELEVADO') || 
                                                 classificationRaw.toString().contains('GRAVE');

                            return Card(
                              elevation: 1,
                              margin: const EdgeInsets.only(bottom: 12.0),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: possuiAlerta ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                                  child: Icon(
                                    possuiAlerta ? Icons.warning : Icons.check_circle,
                                    color: possuiAlerta ? Colors.red : Colors.green,
                                  ),
                                ),
                                title: Text(
                                  nome,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                subtitle: Text('$teste\nPontuação: $pontuacao pts'),
                                trailing: const Icon(Icons.chevron_right),
                                isThreeLine: true,
                                onTap: () {
                                  // Abre o laudo descritivo completo em uma janela limpa
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(teste, style: const TextStyle(fontWeight: FontWeight.bold)),
                                      content: SingleChildScrollView(
                                        child: Text('Paciente: $nome\n\n$classificationRaw'),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('Fechar', style: TextStyle(color: Colors.deepPurple)),
                                        ),
                                      ],
                                    ),
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
} // FECHA A CLASSE _TELAHISTORICOSTATE DE FORMA PERFEITA
