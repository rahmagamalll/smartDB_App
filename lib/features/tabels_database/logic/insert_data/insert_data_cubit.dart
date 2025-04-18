import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:software_project/core/helper/sql_lite_services.dart';

part 'insert_data_state.dart';

class InsertDataCubit extends Cubit<InsertDataState> {
  InsertDataCubit(this.sqlDb) : super(InsertDataInitial());

  final SqlDb sqlDb;

  Future<void> insertData(
      {required String table, required Map<String, dynamic> data}) async {
    emit(InsertDataLoading());
    try {
      await sqlDb.insertIntoTable(table, data);
      emit(InsertDataSuccess('Data inserted successfully.'));
    } catch (e) {
      emit(InsertDataFailuer('Insert failed: $e'));
    }
  }
}
