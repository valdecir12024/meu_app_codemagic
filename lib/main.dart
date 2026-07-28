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
    // Configura 3 abas de navegação (Neuro, Comportamento, Socioemocional)
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F7),
        appBar: AppBar(
          title: const Text('NeuroApp - Triagem'),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () => Navigator.pop(context),
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            tabs: [
              Tab(icon: Icon(Icons.psychology), text: 'Neuro'),
              Tab(icon: Icon(Icons.accessibility_new), text: 'Comportamento'),
              Tab(icon: Icon(Icons.emoji_emotions), text: 'Socioemocional'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Aba 1: Neuro
            _construirListaTestes([
              'Triagem de Atenção Visual',
              'Memória de Curto Prazo',
              'Velocidade de Processamento',
            ], Colors.blue),

            // Aba 2: Comportamento
            _construirListaTestes([
              'Escala de Impulsividade Inicial',
              'Rastreio de Hiperatividade',
              'Foco em Tarefas Escolares',
            ], Colors.orange),

            // Aba 3: Socioemocional
            _construirListaTestes([
              'Avaliação de Tolerância à Frustração',
              'Percepção de Empatia',
              'Interação com Pares/Colegas',
            ], Colors.green),
          ],
        ),
      ),
    );
  }

  // Função auxiliar para desenhar a lista de testes dentro de cada categoria
  Widget _construirListaTestes(List<String> testes, Color corIcone) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: testes.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 1,
          margin: const EdgeInsets.only(bottom: 12.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: corIcone.withOpacity(0.1),
              child: Icon(Icons.assignment, color: corIcone),
            ),
            title: Text(
              testes[index],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: const Text('Toque para iniciar a triagem inicial'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Próxima etapa: abrir o questionário do teste clicado
            },
          ),
        );
      },
    );
  }
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


