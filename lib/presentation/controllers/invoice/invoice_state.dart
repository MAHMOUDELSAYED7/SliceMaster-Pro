part of 'invoice_cubit.dart';

@immutable
abstract class InvoiceState {}

class InvoiceInitial extends InvoiceState {}

class Incremet extends InvoiceState {}

class Decrement extends InvoiceState {}

class InvoiceGenerated extends InvoiceState {}

class InvoiceError extends InvoiceState {
  final String errMessage;

  InvoiceError({required this.errMessage});
}
