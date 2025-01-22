import 'package:flutter/services.dart';
import 'package:part_btcn/app/data/model/order/order_model.dart';
import 'package:part_btcn/utils/constants_assets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';

import 'format_date_time.dart';
import 'text_helper.dart';

abstract class PDFHelper {
  // get svg from load asset and convert asset to string and assign to SvgImage
  static Future<pw.SvgImage> getLogo() async {
    final data = await rootBundle.loadString(ConstantsAssets.icLogoApp);
    return pw.SvgImage(svg: data, width: 125);
  }

  static Future<void> generateInvoicePDF(OrderModel? data, String name) async {
    final img = await getLogo();

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(16),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  img,
                  pw.SizedBox(width: 12),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'PT BUMI CITRA TRAKTOR NUSANTARA',
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        'Komplek Pemuda City Walk Jalan Pemuda Blok A No 1&2',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        'RT. Tirtasiak, Payung Sekaki',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 16),
              pw.Container(
                padding: const pw.EdgeInsets.only(
                    left: 4, top: 2, right: 4, bottom: 12),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Kepada :'),
                    pw.Text(
                      name,
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 18),
              pw.Center(
                child: pw.Text(
                  'FAKTUR PENJUALAN',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline,
                    decorationColor: PdfColors.black,
                    decorationThickness: 2,
                  ),
                ),
              ),
              pw.SizedBox(height: 18),
              pw.Table(
                border: pw.TableBorder.all(),
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: const pw.IntrinsicColumnWidth(),
                  1: const pw.FlexColumnWidth(2),
                  2: const pw.FlexColumnWidth(4),
                  3: const pw.IntrinsicColumnWidth(),
                  5: const pw.FlexColumnWidth(2),
                  6: const pw.FlexColumnWidth(2),
                },
                children: [
                  pw.TableRow(
                    children: [
                      'No',
                      'Part Number',
                      'Nama Barang',
                      'Qty',
                      'Net Price',
                      'Jumlah',
                    ]
                        .map(
                          (e) => pw.Container(
                            padding: const pw.EdgeInsets.all(4),
                            child: pw.Text(
                              e,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  if (data != null && data.items != null)
                    ...data.items!.map(
                      (e) => pw.TableRow(
                        repeat: true,
                        verticalAlignment: pw.TableCellVerticalAlignment.middle,
                        children: [
                          data.items!.indexOf(e) + 1,
                          e.partId,
                          e.description,
                          e.quantity,
                          TextHelper.formatRupiah(
                            amount: e.price,
                            isCompact: false,
                            isUsingSymbol: false,
                          ),
                          TextHelper.formatRupiah(
                            amount: e.price * e.quantity,
                            isCompact: false,
                            isUsingSymbol: false,
                          ),
                        ]
                            .map(
                              (e) => pw.Container(
                                padding: const pw.EdgeInsets.all(4),
                                child: pw.Text(
                                  e.toString(),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                ],
              ),
              pw.SizedBox(height: 16),
              pw.Table(
                columnWidths: {
                  0: const pw.FlexColumnWidth(1),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text("Sub Total : ", textAlign: pw.TextAlign.right),
                      pw.Text(
                        TextHelper.formatRupiah(
                          amount: data?.price,
                          isCompact: false,
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text("Discount : ", textAlign: pw.TextAlign.right),
                      pw.Text(
                        '${data?.discount ?? 0} %',
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text("Voucher : ", textAlign: pw.TextAlign.right),
                      pw.Text(
                        TextHelper.formatRupiah(
                          amount: data?.voucher?.fee,
                          isCompact: false,
                          isMinus: true,
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text(
                        "Total : ",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
                        textAlign: pw.TextAlign.right,
                      ),
                      pw.Text(
                        TextHelper.formatRupiah(
                          amount: data?.totalPrice,
                          isCompact: false,
                        ),
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 32),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Tanda Terima,\n\n\n(.....................)"),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Table(
                      border: pw.TableBorder.all(),
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Text(
                              "Keterangan",
                              textAlign: pw.TextAlign.center,
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.Container(
                              padding: const pw.EdgeInsets.all(4),
                              child: pw.Text(
                                "Penjualan Sparepart PT.KAT Cash\n\n\n",
                                textAlign: pw.TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  pw.Text(
                    "Hormat Kami,\n\n\n(WIRANTO)\nPart Manager",
                    textAlign: pw.TextAlign.center,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    if (await Permission.manageExternalStorage.request().isGranted) {
      // simpan ke penyimpanan hp di folder download
      final directory = Directory('/storage/emulated/0/BTCN/invoice');
      final path = directory.path;

      if (!directory.existsSync()) {
        await directory.create(recursive: true);
      }

      final file = File('$path/Invoice_${FormatDateTime.dateToString(
        newPattern: 'yyyy_MM_dd_HH_mm_ss',
        value: DateTime.now().toString(),
      )}.pdf');
      await file.writeAsBytes(await pdf.save());
    }
  }
}
