import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:software_project/core/helper/sql_lite_services.dart';
import 'package:sqflite/sqflite.dart';

part 'add_new_table_state.dart';

class AddNewTableCubit extends Cubit<AddNewTableState> {
  AddNewTableCubit() : super(AddNewTableInitial());
  final sqlDb = SqlDb();
  TextEditingController tableNameController = TextEditingController();
  List<String> columnNames = [];
  Future<void> createTable(Map<String, String> columns) async {
    emit(AddNewTableLoading());

    try {
      Database? mydb = await sqlDb.getdb;

      List<String> existingTables = await sqlDb.getAllTableNames();
      String tableName = tableNameController.text.trim();

      if (existingTables.contains(tableName)) {
        emit(AddNewTableError('Table "$tableName" already exists.'));
        return;
      }

      String columnDefs = columns.entries.map((entry) {
        return '"${entry.key}" ${entry.value}';
      }).join(', ');

      String sql =
          'CREATE TABLE IF NOT EXISTS "${tableNameController.text}" ($columnDefs)';
      await mydb!.execute(sql);
      print(
          '********************************************************************');
      columnNames = await sqlDb.getAllTableNames();
      print(columnNames);
      print(
          '********************************************************************');
      emit(AddNewTableSuccess(
          'Table "${tableNameController.text}" created successfully.'));
    } on Exception catch (e) {
      emit(AddNewTableError('Failed to create table: $e'));
    } catch (e) {
      emit(AddNewTableError('An unexpected error occurred: $e'));
    }
    print('Table "${tableNameController.text}" created.');
  }
}
