part of 'add_query_cubit.dart';

@immutable
sealed class AddQueryState {}

final class AddQueryInitial extends AddQueryState {}

final class AddQueryLoading extends AddQueryState {}

final class AddQuerySuccess extends AddQueryState {
 final List<Map<String, dynamic>> data;
  AddQuerySuccess(this.data);
}

final class AddQueryFailuer extends AddQueryState {
  final String errMessage;
  AddQueryFailuer(this.errMessage);
}

// final class AddQueryTablesLoaded extends AddQueryState {
//   final List<String> tables;
//   AddQueryTablesLoaded(this.tables);
// }

// final class AddQueryColumnsLoaded extends AddQueryState {
//   final List<String> columns;
//   AddQueryColumnsLoaded(this.columns);
// }

// final class AddQueryDataLoaded extends AddQueryState {
//   final List<Map<String, dynamic>> data;
//   AddQueryDataLoaded(this.data);
// }
