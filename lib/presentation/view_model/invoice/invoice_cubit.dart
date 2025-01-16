import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart' show PdfColor;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../core/service/cache/cache.dart';
import '../../../core/utils/constants/images.dart';
import '../../../data/model/pizza.dart';
import '../../../data/repositories/pizzas.dart';
import '../../../data/source/database/hive_service.dart';
import '../calc/calc_cubit.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(InvoiceInitial());
  final HiveDb _hiveDb = HiveDb();

  Future<void> generateInvoice({
    required Map<PizzaModel, Map<PizzaSize, int>> pizzaCounts,
    required String customerName,
    num? discount,
  }) async {
    if (pizzaCounts.isEmpty) {
      emit(InvoiceError(errMessage: 'No pizza counts provided.'));
      return;
    }
    final pdf = pw.Document();
    final textColor = PdfColor.fromHex('#000000');

    final Uint8List logoBytes = await rootBundle
        .load(ImageManager.logoPNG)
        .then((value) => value.buffer.asUint8List());

    final List<List<String>> data = [];
    num tax = 0;
    const double taxRate = 0.0;

    num totalAmountBeforeDiscount = 0;

    pizzaCounts.forEach((pizza, sizeCounts) {
      sizeCounts.forEach((size, count) {
        if (count > 0) {
          String pizzaSize;
          num price;
          switch (size) {
            case PizzaSize.s:
              pizzaSize = 'Small';
              price = pizza.smallPrice;
              break;
            case PizzaSize.m:
              pizzaSize = 'Medium';
              price = pizza.mediumPrice;
              break;
            case PizzaSize.l:
              pizzaSize = 'Large';
              price = pizza.largePrice;
              break;
            default:
              throw Exception('Unknown pizza size');
          }

          final total = price * count;
          totalAmountBeforeDiscount += total;
          tax += total * taxRate;

          data.add([
            '${pizza.name} ($pizzaSize)',
            price.toStringAsFixed(2),
            (taxRate * 100).toStringAsFixed(1),
            discount?.toStringAsFixed(1) ?? '0.0',
            total.toStringAsFixed(2),
            count.toString(),
          ]);
        }
      });
    });

    num discountAmount = 0;
    if (discount != null && discount > 0) {
      discountAmount = totalAmountBeforeDiscount * (discount / 100);
    }

    final totalAmountAfterDiscount = totalAmountBeforeDiscount - discountAmount;
    final grandTotal = totalAmountAfterDiscount + tax;

    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);
    final formattedTime = DateFormat('HH:mm:ss').format(now);

    int? invoiceNumber = await _hiveDb
        .getNextInvoiceNumber(CacheData.getData(key: 'currentUser'));

    if (invoiceNumber == null) {
      emit(InvoiceError(errMessage: 'Failed to retrieve invoice number.'));
      return;
    }

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Image(
                pw.MemoryImage(logoBytes),
                width: 200,
                height: 200,
              ),
              pw.SizedBox(height: 20),
              pw.Text('City Road - empty',
                  style: pw.TextStyle(fontSize: 14, color: textColor)),
              pw.Text('Phone: 01061172139',
                  style: pw.TextStyle(fontSize: 14, color: textColor)),
              pw.Text('Tax Number: 000002',
                  style: pw.TextStyle(fontSize: 14, color: textColor)),
              pw.SizedBox(height: 5),
              pw.BarcodeWidget(
                color: textColor,
                barcode: pw.Barcode.code128(),
                data: '000000000000002',
                width: 300,
                height: 60,
              ),
              pw.Text('Invoice Number: $invoiceNumber',
                  style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: textColor)),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text('Date: $formattedDate',
                      style: pw.TextStyle(fontSize: 14, color: textColor)),
                  pw.SizedBox(width: 5),
                  pw.Text('Time: $formattedTime',
                      style: pw.TextStyle(fontSize: 14, color: textColor)),
                ],
              ),
              pw.SizedBox(height: 5),
              pw.Text('Customer Name: $customerName',
                  style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                      color: textColor)),
              pw.SizedBox(height: 5),
              // ignore: deprecated_member_use
              pw.Table.fromTextArray(
                context: context,
                border: pw.TableBorder.all(color: textColor),
                headers: <String>[
                  'Item',
                  'Price',
                  'Tax (%)',
                  'Discount (%)',
                  'Total (EGP)',
                  'Quantity'
                ],
                cellStyle: pw.TextStyle(
                  color: textColor,
                  fontSize: 14,
                ),
                headerStyle: pw.TextStyle(
                  color: textColor,
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
                data: data,
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                          'Total Amount: ${totalAmountBeforeDiscount.toStringAsFixed(2)} EGP',
                          style: pw.TextStyle(fontSize: 14, color: textColor)),
                      pw.Text(
                          'Discount: ${discountAmount.toStringAsFixed(2)} EGP',
                          style: pw.TextStyle(fontSize: 14, color: textColor)),
                      pw.Text('Tax: ${tax.toStringAsFixed(2)} EGP',
                          style: pw.TextStyle(fontSize: 14, color: textColor)),
                      pw.Text(
                          'Grand Total: ${grandTotal.toStringAsFixed(2)} EGP',
                          style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                              color: textColor)),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    await PizzasRepository.instance.saveInvoice(
      discount: discount ?? 10,
      invoiceNumber: invoiceNumber,
      customerName: customerName,
      formattedDate: formattedDate,
      formattedTime: formattedTime,
      items: pizzaCounts.entries
          .expand((entry) => entry.value.entries
                  .where((sizeEntry) => sizeEntry.value > 0)
                  .map((sizeEntry) {
                return '${entry.key.name} (${sizeEntry.key == PizzaSize.s ? 'Small' : sizeEntry.key == PizzaSize.m ? 'Medium' : sizeEntry.key == PizzaSize.l ? 'Large' : ''}) x${sizeEntry.value}';
              }))
          .join(', '),
      totalAmount: totalAmountAfterDiscount.toDouble(),
      userName: CacheData.getData(key: 'currentUser'),
    );

    await Printing.sharePdf(bytes: await pdf.save(), filename: 'invoice.pdf');
    debugPrint('Invoice generated.');
    emit(InvoiceGenerated());
  }
}

    // await Printing.layoutPdf(
    //   onLayout: (PdfPageFormat format) async => pdf.save(),
    // );