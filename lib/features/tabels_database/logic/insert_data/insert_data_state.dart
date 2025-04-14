part of 'insert_data_cubit.dart';

@immutable
sealed class InsertDataState {}

final class InsertDataInitial extends InsertDataState {}
final class InsertDataLoading extends InsertDataState{}

final class InsertDataSuccess extends InsertDataState {
  final String message;
  InsertDataSuccess(this.message);
}
final class InsertDataError extends InsertDataState {
  final String message;
  InsertDataError(this.message);
}

class InsertDataTablesLoaded extends InsertDataState {
  final List<String> tables;
  InsertDataTablesLoaded(this.tables);
}

class InsertDataColumnsLoaded extends InsertDataState {
  final List<String> columns;
  InsertDataColumnsLoaded(this.columns);
}
 class InsertDataFormCleared extends InsertDataState {}