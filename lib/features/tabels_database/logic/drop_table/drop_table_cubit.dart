import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:software_project/core/helper/sql_lite_services.dart';
import 'package:sqflite/sqflite.dart';

part 'drop_table_state.dart';

class DropTableCubit extends Cubit<DropTableState> {
  DropTableCubit(this.sqlDb) : super(DropTableInitial());
  final SqlDb sqlDb;

  List<String> tableNames = [];
  String? selectedTable;
   List<String> columnNames = [];
  List<TextEditingController> controllers = [];

  //load names of tables from DB
  Future<void> loadTableNames() async {
    try {
      tableNames = await sqlDb.getAllTableNames();
      emit(DropTablesLoaded(tableNames));
    } catch (e) {
      emit(DropTableError(message: 'Failed to load table names: $e'));
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
      emit(DropTablesLoaded(columnNames));
    } catch (e) {
      emit(DropTableError(message: 'Failed to load columns: $e'));
    }
  }

// drop table
  Future<void> dropTable(String tableName) async {
    emit(DropTableLoading());
    try {
      Database? mydb = await sqlDb.getdb;
      String sql = 'DROP TABLE IF EXISTS "$tableName"';
      await mydb!.execute(sql);
      emit(DropTableSuccess(message: 'table have been deleted'));
      print('Table "$tableName" dropped.');
    } on Exception {
      emit(DropTableError(message: 'table doesnot deleted'));
    }
  }
}
