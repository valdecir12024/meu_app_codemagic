import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicoHistorico {
  static const String _chaveHistorico = 'neuroapp_historico_v3';

  /// 1. SALVAMENTO BLINDADO: Aceita qualquer formato de pontos e grava com segurança
  static Future<bool> salvarRelatorio({
    required String nome,
    required String teste,
    required dynamic pontuacao,
    required String classificacao,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final stringAtual = prefs.getString(_chaveHistorico);
      List<dynamic> listaExistente = [];

      if (stringAtual != null && stringAtual.isNotEmpty) {
        try {
          listaExistente = jsonDecode(stringAtual);
        } catch (_) {
          listaExistente = [];
        }
      }

      // Converte qualquer entrada (seja double, int ou String) para texto limpo no JSON
      final stringPontos = pontuacao.toString();

      final novoItem = {
        'nome': nome.trim().toUpperCase(),
        'teste': teste.trim(),
        'pontuacao': stringPontos,
        'classificacao': classificacao.trim(),
        'data': DateTime.now().toIso8601String(),
      };

      listaExistente.insert(0, novoItem);
      return await prefs.setString(_chaveHistorico, jsonEncode(listaExistente));
    } catch (e) {
      debugPrint('Erro crítico de gravação física no banco: $e');
      return false;
    }
  }

  /// 2. LEITURA PADRONIZADA: Retorna a lista tratada e limpa contra nulos para a tela de histórico
  static Future<List<Map<String, dynamic>>> obterHistorico() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final stringAtual = prefs.getString(_chaveHistorico);

      if (stringAtual == null || stringAtual.isEmpty) {
        return [];
      }

      final List<dynamic> listaCrua = jsonDecode(stringAtual);
      
      // Converte e limpa o mapa de dados garantindo integridade absoluta dos campos
      return listaCrua.map((item) {
        final mapa = Map<String, dynamic>.from(item);
        return {
          'nome': mapa['nome'] ?? 'N.I.',
          'teste': mapa['teste'] ?? 'Triagem Geral',
          'pontuacao': mapa['pontuacao'] ?? '0',
          'classificacao': mapa['classificacao'] ?? 'Sem dados de laudo.',
          'data': mapa['data'] ?? '',
        };
      }).toList();
    } catch (e) {
      debugPrint('Erro crítico na leitura do histórico local: $e');
      return [];
    }
  }

  /// 3. LIMPEZA DE SEGURANÇA: Permite zerar o banco em caso de testes de estresse
  static Future<bool> limparTodoOHistorico() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_chaveHistorico);
    } catch (e) {
      debugPrint('Erro ao resetar banco do histórico: $e');
      return false;
    }
  }
}
