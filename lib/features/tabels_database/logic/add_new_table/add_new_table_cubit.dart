import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:software_project/core/helper/sql_lite_services.dart';

part 'add_new_table_state.dart';

class AddNewTableCubit extends Cubit<AddNewTableState> {
  AddNewTableCubit(this.sqlDb) : super(AddNewTableInitial());
  final SqlDb sqlDb;
  TextEditingController tableNameController = TextEditingController();
  List<String> columnNames = [];
  Future<void> createTable(Map<String, String> columns) async {
    emit(AddNewTableLoading());
    try {
      List<String> existingTables = await sqlDb.getAllTableNames();
      columnNames = await sqlDb.getAllTableNames();
      String tableName = tableNameController.text.trim();

      if (existingTables.contains(tableName)) {
        emit(AddNewTableFailuer('Table "$tableName" already exists.'));
        return;
      }
      await sqlDb.createTable(tableName, columns);

      emit(AddNewTableSuccess(
          'Table "${tableNameController.text}" created successfully.'));
    } on Exception catch (e) {
      emit(AddNewTableFailuer('Failed to create table: $e'));
    } catch (e) {
      emit(AddNewTableFailuer(
          'Table "${tableNameController.text}"  not created.'));
    }
  }
}
