part of 'add_new_table_cubit.dart';

@immutable
sealed class AddNewTableState {}

final class AddNewTableInitial extends AddNewTableState {}

final class AddNewTableLoading extends AddNewTableState {}

final class AddNewTableSuccess extends AddNewTableState {
  final String message;
  AddNewTableSuccess(this.message);
}

final class AddNewTableFailuer extends AddNewTableState {
  final String errMessage;
  AddNewTableFailuer(this.errMessage);
}
