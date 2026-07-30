import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class GeradorPdf {
  // Adicionados os novos parâmetros com valores padrão de segurança
  static pw.Document criarDocumento(
    String nomeTeste, 
    double pontuacao, 
    String classificacao, {
    required String nome,
    required String idade,
    required String instituicao,
  }) {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(32),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('RELATÓRIO DE TRIAGEM INICIAL - NEUROAPP', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 4),
                pw.Text('Documento gerado automaticamente via aplicativo móvel.', style: pw.TextStyle(fontSize: 10, color: PdfColors.grey)),
                pw.Divider(thickness: 2),
                pw.SizedBox(height: 16),
                
                // BLOCO DE IDENTIFICAÇÃO DO PACIENTE/ALUNO
                pw.Text('DADOS DO AVALIADO:', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColors.deepPurple)),
                pw.SizedBox(height: 6),
                pw.Text('Nome Completo: $nome', style: pw.TextStyle(fontSize: 12)),
                pw.Text('Idade: $idade anos', style: pw.TextStyle(fontSize: 12)),
                pw.Text('Instituição (Escola/Clínica): $instituicao', style: pw.TextStyle(fontSize: 12)),
                pw.SizedBox(height: 16),
                pw.Divider(thickness: 1, borderStyle: pw.BorderStyle.dashed),
                pw.SizedBox(height: 16),
                
                pw.Text('Instrumento de Avaliação:', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                pw.Text(nomeTeste, style: pw.TextStyle(fontSize: 14)),
                pw.SizedBox(height: 12),
                
                pw.Text('Desempenho Obtido:', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                pw.Text('$pontuacao pontos.', style: pw.TextStyle(fontSize: 14)),
                pw.SizedBox(height: 12),
                
                pw.Text('Classificação / Análise de Rastreio:', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                pw.Text(classificacao.isEmpty ? 'Pontuação registrada para fins de acompanhamento.' : classificacao, style: pw.TextStyle(fontSize: 14, color: PdfColors.deepPurple, fontWeight: pw.FontWeight.bold)),
                
                pw.Spacer(),
                pw.Divider(),
                pw.Text('Nota: Este documento constitui um rastreio de indicadores iniciais e não substitui um laudo diagnóstico formal emitido por profissional especializado.', style: pw.TextStyle(fontSize: 9, fontStyle: pw.FontStyle.italic)),
              ],
            ),
          );
        },
      ),
    );

    return pdf;
  }
}
