import 'package:flutter/material.dart';

void main() {
  runApp(const MeuAppReal());
}

class MeuAppReal extends StatelessWidget {
  const MeuAppReal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App Real',
      debugShowCheckedModeBanner: false, // Remove a faixa de debug do topo
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TelaLogin(),
    );
  }
}

class TelaLogin extends StatelessWidget {
  const TelaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ícone ou Logo temporária
            const Icon(
              Icons.rocket_launch,
              size: 80,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 16),
            
            // Título
            const Text(
              'Bem-vindo ao App',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),

            // Campo de E-mail
            const TextField(
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),

            // Campo de Senha
            const TextField(
              obscureText: true, // Esconde as letras da senha
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 24),

                       // Botão de Entrar
            ElevatedButton(
              onPressed: () {
                // Navega para a Tela Principal de forma segura
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaPrincipal()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Entrar', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7), // Fundo cinza claro estilo iOS
      appBar: AppBar(
        title: const Text('NeuroApp - Painel'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false, // Sem botão de voltar
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pop(context); // Sair do app
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Olá, Paciente/Profissional!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Selecione uma das atividades abaixo:',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            
            // Grade de Cards Clicáveis
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 colunas
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _criarCardMenu(
                    icon: Icons.psychology, 
                    titulo: 'Avaliação', 
                    cor: Colors.blue,
                  ),
                  _criarCardMenu(
                    icon: Icons.analytics, 
                    titulo: 'Resultados', 
                    cor: Colors.orange,
                  ),
                  _criarCardMenu(
                    icon: Icons.fitness_center, 
                    titulo: 'Treinamento', 
                    cor: Colors.green,
                  ),
                  _criarCardMenu(
                    icon: Icons.settings, 
                    titulo: 'Ajustes', 
                    cor: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função auxiliar para desenhar cada quadradinho (Card) do menu
  Widget _criarCardMenu({required IconData icon, required String titulo, required Color cor}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          // Ação ao clicar no card (programaremos nas próximas etapas)
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: cor),
              const SizedBox(height: 12),
              Text(
                titulo,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


