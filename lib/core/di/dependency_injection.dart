import 'package:get_it/get_it.dart';
import 'package:software_project/core/helper/sql_lite_services.dart';
import 'package:software_project/features/tabels_database/logic/add_new_table/add_new_table_cubit.dart';
import 'package:software_project/features/tabels_database/logic/add_query/add_query_cubit.dart';
import 'package:software_project/features/tabels_database/logic/drop_table/drop_table_cubit.dart';
import 'package:software_project/features/tabels_database/logic/insert_data/insert_data_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<SqlDb>(() => SqlDb());
 
  getIt.registerSingleton<AddNewTableCubit>(AddNewTableCubit());
  getIt.registerFactory<InsertDataCubit>(() => InsertDataCubit(getIt()));
  getIt.registerFactory<AddQueryCubit>(() => AddQueryCubit(getIt()));
  getIt.registerFactory<DropTableCubit>(() => DropTableCubit(getIt()));
}
