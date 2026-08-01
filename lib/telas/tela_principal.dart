import 'package:flutter/material.dart';
import 'tela_questionario.dart';
import 'tela_manual.dart'; // Mantém o import correto do guia técnico
import 'tela_identificacao.dart'; // <- Linha adicionada aqui
import 'tela_perfil.dart';

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
          // AMARRAÇÃO CORRIGIDA: Botões superiores totalmente alinhados e fechados
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              tooltip: 'Meu Perfil',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaPerfil()),
                );
              },
            ),
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
            // Aba 1: Neuro (Alinhada com as suas escalas oficiais)
            _construirListaTestes([
              'M-CHAT-R/F (TEA Inicial)',
              'Escala CARS (Autismo Infantil)',
              'Escala ASRS-18 (Rastreio TDAH)',
              'Escala ATA (Traços Autísticos)',
              'Escala ABC (Behavior Checklist)',
              'Triagem de Atenção Visual',
              'Memória de Curto Prazo',
            ], Colors.blue),

            // Aba 2: Comportamento (CORRIGIDO: Combo completo de 13 testes)
            _construirListaTestes([
              'SNAP-IV (TDAH e TOD Inicial)',
              'Escala Conners-3 (Conduta e Foco)',
              'Vanderbilt (Comportamento Escolar)',
              'Escala Basic 3',
              'Escala ICU (Traços Insensíveis e Frios)',
              'Escala CRIES-13 (Estresse Pós-Traumático)',
              'Escala IAT (Dependência de Internet)',
              'Escala MBI (Inventário de Burnout)',
              'Escala CFQ (Falhas Cognitivas)',
              'Escala MSI-BPD (Traços de Personalidade)',
              'Escala CRAFFT 2.1 (Rastreio de Substâncias)',
              'Checklist de Vitimização (Bullying)',
              'Inventário Big Five (Personalidade)',
            ], Colors.orange),
            // Aba 3: Socioemocional (Alinhada com os testes de ansiedade/autoestima)
            _construirListaTestes([
              'SDQ (Forças e Dificuldades)',
              'Escala SCARED (Ansiedade Infantil)',
              'Escala de Autoestima de Rosemberg',
            ], Colors.green),
          ],
        ),
      ),
    );
  }

  // Função auxiliar unificada e protegida para desenhar a lista de testes
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
              // Abre a tela de identificação empurrando o nome do teste selecionado
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaIdentificacao(nomeDoTeste: testes[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
