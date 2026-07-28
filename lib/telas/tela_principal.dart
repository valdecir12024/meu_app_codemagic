import 'package:flutter/material.dart';
import 'tela_questionario.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaQuestionario(nomeDoTeste: testes[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
