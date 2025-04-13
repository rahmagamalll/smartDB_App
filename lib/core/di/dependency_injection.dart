

import 'package:get_it/get_it.dart';
import 'package:software_project/features/tabels_database/logic/add_new_table/add_new_table_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {

  getIt.registerSingleton<AddNewTableCubit>(AddNewTableCubit());



}
