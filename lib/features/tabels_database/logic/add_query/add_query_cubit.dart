import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:software_project/core/helper/sql_lite_services.dart';
import 'package:sqflite/sqflite.dart';

part 'add_query_state.dart';

class AddQueryCubit extends Cubit<AddQueryState> {
  AddQueryCubit(this.sqlDb) : super(AddQueryInitial());
  final SqlDb sqlDb;

  List<String> tableNames = [];
  String? selectedTable;
  List<String> columnNames = [];
  List<TextEditingController> controllers = [];

  //load names of tables from DB
  Future<void> loadTableNames() async {
    try {
      tableNames = await sqlDb.getAllTableNames();
      emit(AddQueryTablesLoaded(tableNames));
    } catch (e) {
      emit(AddQueryError('Failed to load table names: $e'));
    }
  }

  //add query
  Future<void> getTableData({
    required String tableName,
    String? whereClause,
  }) async {
    emit(AddQueryLoading());

    try {
      Database? mydb = await sqlDb.getdb;

      String sql = 'SELECT * FROM "$tableName"';
      if (whereClause != null && whereClause.trim().isNotEmpty) {
        sql += ' WHERE $whereClause';
      }

      List<Map<String, dynamic>> response = await mydb!.rawQuery(sql);

      if (response.isNotEmpty) {
        emit(AddQueryDataLoaded(response));
      } else {
        emit(AddQueryError('No data found.'));
      }
    } on Exception catch (e) {
      emit(AddQueryError('Error fetching data: $e'));
    }
  }
}
