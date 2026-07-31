import 'package:flutter/material.dart';
import 'tela_questionario.dart';
import 'tela_identificacao.dart';
import 'tela_historico.dart';
import 'tela_manual.dart';

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
           // NOVO: Botão para abrir o histórico local
           IconButton(
             icon: const Icon(Icons.history),
             onPressed: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const TelaHistorico()),
               );
             },
           ),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu_book),
              tooltip: 'Guia Técnico',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaManual()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () => Navigator.pop(context),
            ),
          ],
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
          // Aba 1: Neuro (Atualizada com as suas escalas oficiais)
            _construirListaTestes([
              'M-CHAT-R/F (TEA Inicial)',
              'Escala CARS (Autismo Infantil)',
              'Escala ASRS-18 (Rastreio TDAH)',
              'Escala ATA (Traços Autísticos)',
              'Escala ABC (Behavior Checklist)',
              'Triagem de Atenção Visual',
              'Memória de Curto Prazo',
            ], Colors.blue),
          // Aba 2: Comportamento (Alinhada perfeitamente com os nomes do banco)
            _construirListaTestes([
              'SNAP-IV (TDAH 18 Itens)',
              'Escala Conners (10 Perguntas)',
              'Escala Basic 3 (12 Perguntas)',
            ], Colors.orange),
          // Aba 3: Socioemocional (Atualizada com as escalas reais do esqueleto)
            _construirListaTestes([
              'Questionário SDQ (Conduta e Emoção)',
              'Escala SCARED (Triagem de Ansiedade)',
              'Escala Rosenberg (Autoestima Inicial)',
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
            builder: (context) => TelaIdentificacao(nomeDoTeste: testes[index]),     ),
              );
            },
          ),
        );
      },
    );
  }
}
