part of 'insert_data_cubit.dart';

@immutable
sealed class InsertDataState {}

final class InsertDataInitial extends InsertDataState {}

final class InsertDataLoading extends InsertDataState {}

final class InsertDataSuccess extends InsertDataState {
  final String message;
  InsertDataSuccess(this.message);
}

final class InsertDataFailuer extends InsertDataState {
  final String message;
  InsertDataFailuer(this.message);
}

