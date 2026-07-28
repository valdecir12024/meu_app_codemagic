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
            onTap: () {            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navega para a tela do teste enviando o nome dele dinamicamente
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaQuestionario(nomeDoTeste: testes[index]),
                ),
              );
            },
              // Próxima etapa
            },
          ),
        );
      },
    );
  }
}
class TelaQuestionario extends StatelessWidget {
  final String nomeDoTeste;

  const TelaQuestionario({super.key, required this.nomeDoTeste});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: Text(nomeDoTeste),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Indicador de progresso fictício
            const LinearProgressIndicator(
              value: 0.3, // 30% concluído
              backgroundColor: Colors.black12,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
            const SizedBox(height: 24),
            
            // Pergunta de exemplo
            const Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black12),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Com que frequência o indivíduo apresenta dificuldade em manter a atenção em tarefas longas ou atividades lúdicas?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Opções de Resposta (Estilo Escala Likert)
            _construirOpcaoResposta('Nunca', () {}),
            _construirOpcaoResposta('Raramente', () {}),
            _construirOpcaoResposta('Às vezes', () {}),
            _construirOpcaoResposta('Frequentemente', () {}),
            _construirOpcaoResposta('Sempre', () {}),
            
            const Spacer(),

            // Botão Avançar
            ElevatedButton(
              onPressed: () {
                // Fechar o teste e simular finalização por enquanto
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Resposta registrada temporariamente!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Próxima Pergunta', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  // Função auxiliar para criar os botões das alternativas
  Widget _construirOpcaoResposta(String texto, VoidCallback aoPressionar) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: OutlinedButton(
        onPressed: aoPressionar,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          side: const BorderSide(color: Colors.deepPurple),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          alignment: Alignment.centerLeft,
        ),
        child: Text(
          texto,
          style: const TextStyle(fontSize: 16, color: Colors.deepPurple, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
