import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:software_project/core/helper/sql_lite_services.dart';

part 'drop_table_state.dart';

class DropTableCubit extends Cubit<DropTableState> {
  DropTableCubit(this.sqlDb) : super(DropTableInitial());
  final SqlDb sqlDb;

  Future<void> deleteTableDataOrDropIt({
    required String tableName,
    String? whereClause,
  }) async {
    emit(DropTableLoading());
    try {
        await sqlDb.deleteTableDataOrDropIt(tableName: tableName, whereClause: whereClause);
        emit(DropTableSuccess(message: 'Table "$tableName" deleted successfully.'));
    } on Exception catch (e) {
      emit(DropTableFailuer(message: 'Failed to delete table: $e'));
    } catch (e) {
      emit(DropTableFailuer(message: 'Failed to delete table: $e'));
    }
  }
}
