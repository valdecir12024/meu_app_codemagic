import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class GeradorPdf {
  // Função que desenha a estrutura do relatório clínico/educacional
  static pw.Document criarDocumento(String nomeTeste, double pontuacao, String classificacao) {
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
                pw.Text('RELATÓRIO DE TRIAGEM INICIAL - NEUROAPP', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 8),
                pw.Text('Documento gerado automaticamente via aplicativo móvel.', style: pw.TextStyle(fontSize: 10, color: PdfColors.grey)),
                pw.Divider(thickness: 2),
                pw.SizedBox(height: 24),
                
                pw.Text('Instrumento de Avaliação:', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.Text(nomeTeste, style: pw.TextStyle(fontSize: 16)),
                pw.SizedBox(height: 16),
                
                pw.Text('Desempenho Obtido:', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.Text('$pontuacao pontos.', style: pw.TextStyle(fontSize: 16)),
                pw.SizedBox(height: 16),
                
                pw.Text('Classificação / Análise de Rastreio:', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.Text(classificacao.isEmpty ? 'Pontuação registrada para fins de acompanhamento.' : classificacao, style: pw.TextStyle(fontSize: 16, color: PdfColors.deepPurple)),
                
                pw.Spacer(),
                pw.Divider(),
                pw.Text('Nota: Este documento constitui um rastreio de indicadores iniciais e não substitui um laudo diagnóstico formal emitido por profissional especializado.', style: pw.TextStyle(fontSize: 10, fontStyle: pw.FontStyle.italic)),
              ],
            ),
          );
        },
      ),
    );

    return pdf;
  }
}
