import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ServicoHistorico {
  // Função para salvar uma nova triagem na memória do celular
  static Future<void> salvarRelatorio({
    required String nome,
    required String teste,
    required String pontuacao,
    required String classificacao,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Puxa a lista de relatórios já existentes
    List<String> historicoDisponivel = prefs.getStringList('historico_triagens') ?? [];
    
    // Cria o mapa com os dados da nova triagem atual
    Map<String, String> novoRelatorio = {
      'nome': nome,
      'teste': teste,
      'pontuacao': pontuacao,
      'classificacao': classificacao,
      'data': '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
    };
    
    // Transforma o mapa em texto (JSON) e adiciona na lista
    historicoDisponivel.add(jsonEncode(novoRelatorio));
    
    // Salva a lista atualizada de volta na memória do aparelho
    await prefs.setStringList('historico_triagens', historicoDisponivel);
  }

  // Função para ler todos os relatórios salvos
  static Future<List<Map<String, dynamic>>> obterHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> listaTexto = prefs.getStringList('historico_triagens') ?? [];
    
    // Converte o texto de volta para o formato de lista de mapas do Flutter
    return listaTexto.map((item) => jsonDecode(item) as Map<String, dynamic>).toList().reversed.toList();
  }
}
