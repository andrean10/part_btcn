import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

abstract class PDFHelper {
  static Future<void> generateInvoice() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'PT BUMI CITRA TRAKTOR NUSANTARA',
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                'KOMPLEK PEMUDA CITY WALK JALAN PEMUDA BLOK. A NO 1&2\nRT. TIRTASIAK, PAYUNG SEKAKI',
              ),
              pw.SizedBox(height: 20),
              pw.Text('Kepada:'),
              pw.Text(
                'PT. KENCANA AMAL TANI\nJL.OK.M JAMIL, 01, SIMPANG TIGA, BUKIT RAYA, KOTA PEKANBARU, RIAU, 28284',
              ),
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Text(
                  'FAKTUR PENJUALAN',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FixedColumnWidth(30),
                  1: const pw.FlexColumnWidth(),
                  2: const pw.FixedColumnWidth(30),
                  3: const pw.FixedColumnWidth(70),
                  4: const pw.FixedColumnWidth(70),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text('No'),
                      pw.Text('Nama Barang'),
                      pw.Text('Qty'),
                      pw.Text('Net Price'),
                      pw.Text('Jumlah'),
                    ],
                  ),
                  ...[
                    [
                      '1',
                      '40C4063 ENGINE OIL FILTER ELEMENT; ASSY',
                      '1',
                      '134,300.00',
                      '134,300.00'
                    ],
                    [
                      '2',
                      '40C8393 SECONDARY FILTER ELEMENT; ASSY',
                      '1',
                      '800,700.00',
                      '800,700.00'
                    ],
                    [
                      '3',
                      '40C8940 PRIMARY FILTER ELEMENT; ASSY',
                      '1',
                      '1,868,200.00',
                      '1,868,200.00'
                    ],
                    [
                      '4',
                      '53C0650 FUEL FILTER ELEMENT;ASSY',
                      '1',
                      '252,800.00',
                      '252,800.00'
                    ],
                    [
                      '5',
                      '53C0051 PRIMARY FUEL FILTER ELEMENT; ASSY',
                      '1',
                      '174,200.00',
                      '174,200.00'
                    ],
                    [
                      '6',
                      '53C0052 SECONDARY FUEL FILTER ELEMENT; ASSY',
                      '1',
                      '125,600.00',
                      '125,600.00'
                    ],
                    [
                      '7',
                      'BC20400T ELEMENT FUEL RACOR',
                      '1',
                      '201,094.00',
                      '201,094.00'
                    ],
                  ].map(
                    (row) => pw.TableRow(
                      children: row.map((cell) => pw.Text(cell)).toList(),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                      'Terbilang: TIGA JUTA LIMA RATUS LIMA PULUH TIGA RIBU TIGA RATUS TIGA PULUH TIGA RUPIAH'),
                  pw.Text('Total: 3,201,205'),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Tanda Terima,\n(..................)'),
                  pw.Text('Hormat Kami,\n(WIRANTO)\nPart Manager'),
                ],
              ),
            ],
          );
        },
      ),
    );

    final output = await getExternalStorageDirectory();
    final file = File("${output!.path}/invoice.pdf");
    await file.writeAsBytes(await pdf.save());

    print('Invoice berhasil disimpan di ${file.path}');
  }
}
