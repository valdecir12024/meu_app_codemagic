import 'package:flutter/material.dart';
import 'tela_questionario.dart';

class TelaIdentificacao extends StatefulWidget {
  final String nomeDoTeste;
  const TelaIdentificacao({super.key, required this.nomeDoTeste});

  @override
  State<TelaIdentificacao> createState() => _TelaIdentificacaoState();
}

class _TelaIdentificacaoState extends State<TelaIdentificacao> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _instituicaoController = TextEditingController();
  
  // Lógica da LGPD: Controla se o termo de consentimento foi aceito
  bool _termoConsentimentoAceito = false;

  // Função interna que exibe o texto jurídico completo do Termo de Consentimento
  void _exibirTextoDoTermo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Termo de Consentimento - LGPD', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const SingleChildScrollView(
          child: Text(
            'Em observância à Lei Geral de Proteção de Dados (Lei nº 13.709/2018), '
            'os dados de saúde e neurodesenvolvimento aqui coletados destinam-se exclusivamente '
            'à triagem inicial preventiva. O profissional declara ter obtido a autorização '
            'prévia e por escrito dos pais ou responsáveis legais do menor avaliado. '
            'Os relatórios gerados são armazenados localmente no dispositivo de forma protegida, '
            'e a exportação em PDF mascara os dados nominais sob a forma de iniciais para '
            'garantir o sigilo e a privacidade do paciente.',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Ok, entendi', style: TextStyle(color: Colors.deepPurple, fontSize: 16)),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text('Identificação do Paciente'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Iniciando: ${widget.nomeDoTeste}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome Completo do Paciente *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, insira o nome do paciente.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _idadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Idade',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _instituicaoController,
                decoration: const InputDecoration(
                  labelText: 'Escola / Instituição Clínica',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school),
                ),
              ),
              const SizedBox(height: 24),
              
              // COMPONENTE LGPD: Bloco visual reativo de consentimento obrigatorio
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _termoConsentimentoAceito ? Colors.deepPurple.withOpacity(0.5) : Colors.black12),
                ),
                child: CheckboxListTile(
                  title: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Declaro que coletei a autorização formal dos responsáveis.',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.info_outline, color: Colors.deepPurple),
                        tooltip: 'Ler termo jurídico',
                        onPressed: _exibirTextoDoTermo,
                      ),
                    ],
                  ),
                  value: _termoConsentimentoAceito,
                  activeColor: Colors.deepPurple,
                  onChanged: (bool? valorNovo) {
                    setState(() {
                      _termoConsentimentoAceito = valorNovo ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              const SizedBox(height: 32),
              
              ElevatedButton(
                // O botão só executa a navegação se o formulário for válido E o termo for aceito
                onPressed: _termoConsentimentoAceito
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TelaQuestionario(
                                nomeDoTeste: widget.nomeDoTeste,
                                nomePaciente: _nomeController.text,
                                idadePaciente: _idadeController.text.isEmpty ? 'Não Informada' : _idadeController.text,
                                instituicao: _instituicaoController.text.isEmpty ? 'Não Informada' : _instituicaoController.text,
                              ),
                            ),
                          );
                        }
                      }
                    : null, // Deixa o botão visualmente desativado/cinza se não marcar o Checkbox
                style: ElevatedButton.styleFrom(
                  backgroundColor: _termoConsentimentoAceito ? Colors.deepPurple : Colors.grey.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Iniciar Triagem', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
