part of 'drop_table_cubit.dart';

@immutable
sealed class DropTableState {}

final class DropTableInitial extends DropTableState {}

final class DropTableLoading extends DropTableState {}

final class DropTableSuccess extends DropTableState {
  final String message;

  DropTableSuccess({required this.message});
}

final class DropTableError extends DropTableState {
  final String message;

  DropTableError({required this.message});
}

class DropTablesLoaded extends DropTableState {
  final List<String> tables;
  DropTablesLoaded(this.tables);
}