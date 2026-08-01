import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tela_login.dart';

class TelaSplash extends StatefulWidget {
  const TelaSplash({super.key});

  @override
  State<TelaSplash> createState() => _TelaSplashState();
}

class _TelaSplashState extends State<TelaSplash> {
  bool _periodoExpirado = false;
  String _numeroSerieUnico = ''; // Armazena o ID único gerado para o cliente
  final TextEditingController _codigoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _verificarPeriodoDeTestes();
  }

  Future<void> _verificarPeriodoDeTestes() async {
    final prefs = await SharedPreferences.getInstance();
    
    String? dataInstalacaoStr = prefs.getString('data_primeira_abertura');
    DateTime dataInstalacao;

    if (dataInstalacaoStr == null) {
      dataInstalacao = DateTime.now();
      await prefs.setString('data_primeira_abertura', dataInstalacao.toIso8601String());
      
      // GERAÇÃO DO ID ÚNICO: Pega os últimos 4 dígitos dos milissegundos da instalação
      int idGerado = dataInstalacao.millisecondsSinceEpoch % 10000;
      // Garante que o ID sempre tenha 4 dígitos (ex: 0542)
      String idFormatado = idGerado.toString().padLeft(4, '0');
      await prefs.setString('app_numero_serie', idFormatado);
    } else {
      dataInstalacao = DateTime.parse(dataInstalacaoStr);
    }

    // Recupera o número de série salvo na memória
    setState(() {
      _numeroSerieUnico = prefs.getString('app_numero_serie') ?? '1024';
    });

    final diferencaDias = DateTime.now().difference(dataInstalacao).inDays;
    bool jaAtivado = prefs.getBool('app_ativado_definitivo') ?? false;

    // ALERTA DE TESTE RÁPIDO: Mude o 15 para 0 se quiser ver a tela bloqueada na hora
    if (diferencaDias >= 0 && !jaAtivado) {
      setState(() {
        _periodoExpirado = true;
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TelaLogin()),
          );
        }
      });
    }
  }

  // LÓGICA SECRETA ANTIPIRATARIA: A chave correta é o Número de Série multiplicado por 2
  void _validarCodigoAtivacao() async {
    int numeroSerieInt = int.tryParse(_numeroSerieUnico) ?? 1024;
    int chaveCorretaCalculada = numeroSerieInt * 2;

    if (_codigoController.text == chaveCorretaCalculada.toString()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('app_ativado_definitivo', true);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aplicativo Ativado Definitivamente!'), backgroundColor: Colors.green),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TelaLogin()),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Chave de ativação incorreta para este dispositivo.'), backgroundColor: Colors.red),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: _periodoExpirado 
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock_clock, size: 80, color: Colors.orangeAccent),
                    const SizedBox(height: 24),
                    const Text(
                      'Período de Testes Expirado',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    
                    // Box informativo com o Número de Série Único do dispositivo
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: Text(
                        'NÚMERO DE SÉRIE: $_numeroSerieUnico',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orangeAccent, letterSpacing: 1.2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    const Text(
                      'Seus 15 dias de avaliação gratuita terminaram. Informe o Número de Série acima ao suporte para receber sua chave de ativação definitiva.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    const SizedBox(height: 32),
                    
                    TextField(
                      controller: _codigoController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Código de Ativação Secreto',
                        labelStyle: const TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.vpn_key, color: Colors.white70),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    ElevatedButton(
                      onPressed: _validarCodigoAtivacao,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepPurple,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Ativar Aplicativo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ],
                )
              : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.psychology, size: 100, color: Colors.white),
                    SizedBox(height: 24),
                    Text(
                      'NeuroApp',
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
