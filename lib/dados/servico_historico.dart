import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
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

  /// 3. EXPORTAÇÃO REAL PARA EXCEL (CSV): Transforma o histórico em planilha física compartilhável
  static Future<void> exportarParaExcelCSV(BuildContext context) async {
    try {
      final dados = await obterHistorico();
      if (dados.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nenhum dado encontrado no histórico para exportar.'), backgroundColor: Colors.orange),
        );
        return;
      }

      // Cria o cabeçalho da planilha (Padrão Excel)
      StringBuffer csvConteudo = StringBuffer();
      csvConteudo.writeln('DATA;PACIENTE;TRIAGEM;PONTUACAO;RESULTADO CLINICO');

      // Preenche as linhas com os relatórios salvos no banco
      for (var item in dados) {
        String dataFormatada = '';
        if (item['data'] != null && item['data'].toString().isNotEmpty) {
          try {
            DateTime dt = DateTime.parse(item['data']);
            dataFormatada = '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
          } catch (_) {
            dataFormatada = item['data'].toString();
          }
        }

        // Limpa quebras de linha nos laudos para não quebrar as células do Excel
        String laudoLimpo = item['classificacao'].toString().replaceAll('\n', ' ').replaceAll(';', ',');

        csvConteudo.writeln('$dataFormatada;${item['nome']};${item['teste']};${item['pontuacao']};$laudoLimpo');
      }

      // Salva o arquivo temporário no diretório seguro do aplicativo
      final diretorio = await getTemporaryDirectory();
      final caminhoArquivo = '${diretorio.path}/historico_triagens_neuroapp.csv';
      final arquivoFisico = File(caminhoArquivo);
      await arquivoFisico.writeAsString(csvConteudo.toString(), encoding: utf8);

      // Dispara a folha de compartilhamento nativa do celular (WhatsApp, Email, etc)
      final xFile = XFile(caminhoArquivo);
      await Share.shareXFiles([xFile], text: 'Planilha de Histórico de Triagens - NeuroApp');

    } catch (e) {
      debugPrint('Erro ao exportar planilha Excel: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao gerar planilha: $e'), backgroundColor: Colors.red),
      );
    }
  }

  /// 4. LIMPEZA DE SEGURANÇA: Permite zerar o banco em caso de testes de estresse
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
