import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:software_project/core/helper/sql_lite_services.dart';

part 'add_query_state.dart';

class AddQueryCubit extends Cubit<AddQueryState> {
  AddQueryCubit(this.sqlDb) : super(AddQueryInitial());
  final SqlDb sqlDb;
  Future<void> addQuery({
    required String tableName,
    required String whereClause,
  }) async {
    emit(AddQueryLoading());
    try {
      List<Map<String, dynamic>> responce = await sqlDb.getTableData(
          tableName: tableName, whereClause: whereClause);
      if (responce.isNotEmpty) {
        emit(AddQuerySuccess(responce));
      } else {
        emit(AddQueryFailuer('No data found.'));
      }
    } on Exception catch (e) {
      emit(AddQueryFailuer('Error executing query: $e'));
    } catch (e) {
      emit(AddQueryFailuer('Failed to add query: $e'));
    }
  }
}
