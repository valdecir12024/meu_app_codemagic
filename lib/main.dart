import 'package:flutter/material.dart';

void main() {
  runApp(const MeuAppReal());
}

class MeuAppReal extends StatelessWidget {
  const MeuAppReal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeuroApp',
      debugShowCheckedModeBanner: false, 
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
            const Icon(
              Icons.rocket_launch,
              size: 80,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 16),
            const Text(
              'Bem-vindo ao NeuroApp',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            const TextField(
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
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
            _construirListaTestes([
              'Triagem de Atenção Visual',
              'Memória de Curto Prazo',
              'Velocidade de Processamento',
            ], Colors.blue),
            _construirListaTestes([
              'Escala de Impulsividade Inicial',
              'Rastreio de Hiperatividade',
              'Foco em Tarefas Escolares',
            ], Colors.orange),
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
              // Próxima etapa
            },
          ),
        );
      },
    );
  }
}
