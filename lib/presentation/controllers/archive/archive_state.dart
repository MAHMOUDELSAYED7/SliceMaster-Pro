part of 'archive_cubit.dart';

@immutable
abstract class ArchiveState {}

class ArchiveInitial extends ArchiveState {}

class ArchiveLoading extends ArchiveState {}

class ArchiveLoaded extends ArchiveState {
  final List<InvoiceModel> list;
  ArchiveLoaded({required this.list});
}


class ArchiveError extends ArchiveState {
  final String message;
  ArchiveError({required this.message});
}
