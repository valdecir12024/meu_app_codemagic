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
  final TextEditingController _codigoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _verificarPeriodoDeTestes();
  }

  // Lógica matemática que calcula o prazo de 15 dias no celular do usuário
  Future<void> _verificarPeriodoDeTestes() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Busca a data da primeira abertura. Se não existir, grava a data de hoje.
    String? dataInstalacaoStr = prefs.getString('data_primeira_abertura');
    DateTime dataInstalacao;

    if (dataInstalacaoStr == null) {
      dataInstalacao = DateTime.now();
      await prefs.setString('data_primeira_abertura', dataInstalacao.toIso8601String());
    } else {
      dataInstalacao = DateTime.parse(dataInstalacaoStr);
    }

    // Calcula a diferença de dias entre hoje e a data que o app foi aberto pela primeira vez
    final diferencaDias = DateTime.now().difference(dataInstalacao).inDays;

    // Se o usuário já usou a chave de liberação definitiva, pula o bloqueio
    bool jaAtivado = prefs.getBool('app_ativado_definitivo') ?? false;

    if (diferencaDias >= 15 && !jaAtivado) {
      setState(() {
        _periodoExpirado = true; // Ativa a tela de bloqueio
      });
    } else {
      // Se ainda estiver dentro dos 15 dias, aguarda 2 segundos e vai para o Login normal
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

  // Função para validar o código que você dará ao cliente para liberar o app
  void _validarCodigoAtivacao() async {
    // Você pode mudar esse código 'NEURO2026' para a senha que você quiser criar
    if (_codigoController.text == 'NEURO2026') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('app_ativado_definitivo', true);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aplicativo Ativado com Sucesso!'), backgroundColor: Colors.green),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TelaLogin()),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Código inválido. Entre em contato com o suporte.'), backgroundColor: Colors.red),
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
                    const SizedBox(height: 12),
                    const Text(
                      'Seus 15 dias de avaliação gratuita terminaram. Para liberar o acesso definitivo às triagens, insira o código de ativação:',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    const SizedBox(height: 32),
                    
                    // CORREÇÃO: Removidos os termos 'const' conflitantes e ajustada a opacidade universal
                    TextField(
                      controller: _codigoController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Código de Ativação',
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
