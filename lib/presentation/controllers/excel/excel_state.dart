part of 'excel_cubit.dart';

@immutable
abstract class ExcelState {}

class ExcelInitial extends ExcelState {}

class SavedToExcelSuccess extends ExcelState {
   final String message;

  SavedToExcelSuccess({required this.message});
}

class SavedToExcelFailure extends ExcelState {
  final String message;

  SavedToExcelFailure({required this.message});
}
