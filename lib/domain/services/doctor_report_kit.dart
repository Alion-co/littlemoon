import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// رنگ‌ها و ابزارهای چیدمان مشترک گزارش PDF پزشک.
class ReportKit {
  final pw.Font regular;
  final pw.Font bold;

  const ReportKit({required this.regular, required this.bold});

  static const accent = PdfColor.fromInt(0xFFD84D88);
  static const soft = PdfColor.fromInt(0xFFFCEEF4);
  static const line = PdfColor.fromInt(0xFFE6D5E2);
  static const muted = PdfColor.fromInt(0xFF7A6573);
  static const ink = PdfColor.fromInt(0xFF2E2230);

  pw.Widget text(
    String value, {
    double size = 10,
    bool isBold = false,
    PdfColor color = ink,
    pw.TextAlign? align,
  }) {
    return pw.Text(
      value,
      textAlign: align,
      style: pw.TextStyle(
        font: isBold ? bold : regular,
        fontSize: size,
        color: color,
        lineSpacing: 2,
      ),
    );
  }

  pw.Widget section(String title, List<pw.Widget> children) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(top: 18),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          text(title, size: 12.5, isBold: true, color: accent),
          pw.SizedBox(height: 6),
          ...children,
        ],
      ),
    );
  }

  /// یک ردیف «عنوان ..... مقدار»
  pw.Widget keyValue(String key, String value) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: line, width: 0.6)),
      ),
      child: pw.Row(
        children: [
          pw.Expanded(child: text(key, color: muted)),
          text(value, isBold: true),
        ],
      ),
    );
  }

  /// جدول ساده با ستون‌های هم‌عرض.
  pw.Widget table(List<String> header, List<List<String>> rows) {
    pw.Widget cell(String value, {bool head = false}) => pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 6),
      child: text(
        value,
        isBold: head,
        color: head ? accent : ink,
        align: pw.TextAlign.center,
      ),
    );

    pw.Widget row(List<String> cells, {bool head = false}) => pw.Container(
      decoration: pw.BoxDecoration(
        color: head ? soft : null,
        border: const pw.Border(bottom: pw.BorderSide(color: line, width: 0.6)),
      ),
      child: pw.Row(
        children: [
          for (final value in cells)
            pw.Expanded(child: cell(value, head: head)),
        ],
      ),
    );

    return pw.Column(
      children: [row(header, head: true), for (final cells in rows) row(cells)],
    );
  }
}
