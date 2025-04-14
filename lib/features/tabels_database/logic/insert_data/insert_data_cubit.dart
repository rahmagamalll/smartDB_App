import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:software_project/core/helper/sql_lite_services.dart';

part 'insert_data_state.dart';

class InsertDataCubit extends Cubit<InsertDataState> {
  InsertDataCubit(this.sqlDb) : super(InsertDataInitial());

  final SqlDb sqlDb;

  List<String> tableNames = [];
  String? selectedTable;
  List<String> columnNames = [];
  List<TextEditingController> controllers = [];

  //load names of tables from DB
  Future<void> loadTableNames() async {
    try {
      tableNames = await sqlDb.getAllTableNames();
      emit(InsertDataTablesLoaded(tableNames));
    } catch (e) {
      emit(InsertDataError('Failed to load table names: $e'));
    }
  }

  //select table and load it's columns
  Future<void> selectTable(String table) async {
    try {
      selectedTable = table;
      columnNames = await sqlDb.getTableColumns(table);
      controllers = List.generate(
        columnNames.length,
        (_) => TextEditingController(),
      );
      emit(InsertDataColumnsLoaded(columnNames));
    } catch (e) {
      emit(InsertDataError('Failed to load columns: $e'));
    }
  }

//insert data
  Future<void> insertData() async {
    emit(InsertDataLoading());
    try {
      final db = await sqlDb.getdb;

      Map<String, dynamic> data = {};
      for (int i = 0; i < columnNames.length; i++) {
        data[columnNames[i]] = controllers[i].text;
      }

      String columnsString = data.keys.map((col) => '"$col"').join(', ');
      String placeholders = data.keys.map((_) => '?').join(', ');
      List<dynamic> values = data.values.toList();

      await db!.rawInsert(
        'INSERT INTO "$selectedTable" ($columnsString) VALUES ($placeholders)',
        values,
      );

      emit(InsertDataSuccess('Data inserted successfully.'));
    } catch (e) {
      emit(InsertDataError('Insert failed: $e'));
    }
  }

  // clean controller
  void clearForm() {
    for (final controller in controllers) {
      controller.clear();
    }
    emit(InsertDataFormCleared());
  }
}
