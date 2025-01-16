import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';

import '../../../core/service/cache/cache.dart';
import '../../../data/model/invoice.dart';
import '../../../data/repositories/pizzas.dart';

part 'excel_state.dart';

class ExcelCubit extends Cubit<ExcelState> {
  ExcelCubit() : super(ExcelInitial());

  Future<void> saveInvoicesToExcel() async {
    List<InvoiceModel>? invoices = await PizzasRepository.instance
        .getInvoices(CacheData.getData(key: 'currentUser'));
    if (invoices?.isEmpty ?? true) {
      emit(SavedToExcelFailure(message: 'No invoices found'));
      return;
    }
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];
    sheet.setColumnWidth(0, 5); // .NO
    sheet.setColumnWidth(1, 20); // Customer Name
    sheet.setColumnWidth(2, 15); // Date
    sheet.setColumnWidth(3, 15); // Time
    sheet.setColumnWidth(4, 13); // Total Amount
    sheet.setColumnWidth(5, 13); // Discount
    sheet.setColumnWidth(6, 100); // Items
    sheet.setColumnWidth(7, 20); // Username
    final header = [
      TextCellValue('.NO'),
      TextCellValue('Customer Name'),
      TextCellValue('Date'),
      TextCellValue('Time'),
      TextCellValue('Total Amount'),
      TextCellValue('Discount'),
      TextCellValue('Items'),
      TextCellValue('Username'),
    ];

    sheet.appendRow(header);

    for (var invoice in invoices ?? []) {
      sheet.appendRow([
        IntCellValue(invoice.invoiceNumber),
        TextCellValue(invoice.customerName),
        TextCellValue(invoice.date),
        TextCellValue(invoice.time),
        DoubleCellValue(invoice.totalAmount),
        DoubleCellValue(invoice.discount.toDouble()),
        TextCellValue(invoice.items),
        TextCellValue(invoice.username),
      ]);
    }

    final result = await FilePicker.platform.getDirectoryPath();
    if (result != null) {
      final path = '$result/invoices.xlsx';
      final file = File(path);

      try {
        final bytes = excel.save();
        await file.writeAsBytes(bytes!);
        emit(SavedToExcelSuccess(message: 'File saved successfully'));
      } catch (e) {
        emit(SavedToExcelFailure(message: 'Error saving file'));
      }
    } else {
      emit(SavedToExcelFailure(message: 'No directory selected'));
    }
  }
}
