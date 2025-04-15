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

  //delete specific table data or drop table
  Future<void> deleteTableDataOrDropIt({
    required String tableName,
    String? whereClause, 
  }) async {
    emit(DropTableLoading());
    try {
      Database? mydb = await sqlDb.getdb;

      if (whereClause != null && whereClause.trim().isNotEmpty) {
        String sql = 'DELETE FROM $tableName WHERE $whereClause';
        await mydb!.execute(sql);
        emit(DropTableSuccess(message: 'record have been deleted'));
      } else if (whereClause == null) {
       String sql = 'DROP TABLE IF EXISTS "$tableName"';
       await mydb!.execute(sql);
       emit(DropTableSuccess(message: 'table have been deleted'));
      }
    } on Exception catch (e) {
      emit(DropTableError(message: 'table doesnot deleted $e'));
    }
  }
}
