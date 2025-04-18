import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/di/dependency_injection.dart';
import 'package:software_project/features/tabels_database/logic/drop_table/drop_table_cubit.dart';
import 'package:software_project/features/tabels_database/ui/widgets/delete_screen/delete_data_section.dart';

class DeleteScreen extends StatelessWidget {
  const DeleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DropTableCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: const DeleteDataSection(),
          ),
        ),
      ),
    );
  }
}
