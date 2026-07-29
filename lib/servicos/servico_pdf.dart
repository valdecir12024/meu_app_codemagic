import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ServicoPdf {
  static Future<void> gerarECompartilharLaudo({
    required String iniciaisPaciente,
    required String nomeDoTeste,
    required double pontuacao,
    required String recomendacao,
  }) async {
    final pdf = pw.Document();

    // Desenha a estrutura visual do documento PDF
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(32),
            child: pw.Column(
              cross pw.CrossAxisAlignment.start,
              children: [
                // Cabeçalho Timbrado do Aplicativo
                pw.Center(
                  child: pw.Text('NEUROAPP - RELATÓRIO DE TRIAGEM', 
                      style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold, color: PdfColors.deepPurple)),
                ),
                pw.SizedBox(height: 8),
                pw.Center(
                  child: pw.Text('Documento de Rastreio Clínico e Educacional Inicial', 
                      style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey)),
                ),
                pw.Divider(thickness: 2, color: PdfColors.deepPurple),
                pw.SizedBox(height: 32),

                // Dados do Paciente em Conformidade com a LGPD
                pw.Text('Dados da Avaliação:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 12),
                pw.Text('Iniciais do Paciente: $iniciaisPaciente', style: const pw.TextStyle(fontSize: 14)),
                pw.Text('Escala Aplicada: $nomeDoTeste', style: const pw.TextStyle(fontSize: 14)),
                pw.Text('Pontuação Total Obtida: $pontuacao pontos', style: const pw.TextStyle(fontSize: 14)),
                pw.SizedBox(height: 32),

                // Seção das Diretrizes e Recomendações
                pw.Text('Diretriz Clínica e Recomendações:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 12),
                pw.Container(
                  padding: const pw.EdgeInsets.all(16),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey300),
                    borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                  ),
                  child: pw.Text(recomendacao, style: const pw.TextStyle(fontSize: 13, lineSpacing: 1.5)),
                ),
                
                pw.Spacer(),
                pw.Divider(color: PdfColors.grey300),
                pw.Center(
                  child: pw.Text('Este relatório é um instrumento de triagem preventiva e não substitui o diagnóstico médico formal.', 
                      style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey)),
                ),
              ],
            ),
          );
        },
      ),
    );

    // Dispara a janelinha nativa do Android/iOS para Imprimir ou Compartilhar o PDF gerado
    await Printing.sharePdf(bytes: await pdf.save(), filename: 'laudo_${iniciaisPaciente.replaceAll('.', '')}.pdf');
  }
}
