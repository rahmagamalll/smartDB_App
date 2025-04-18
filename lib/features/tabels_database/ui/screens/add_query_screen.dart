import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/di/dependency_injection.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/top_app_bar.dart';
import 'package:software_project/features/tabels_database/logic/add_query/add_query_cubit.dart';
import 'package:software_project/features/tabels_database/ui/widgets/add_query_screen/create_query_section.dart';

class AddQueryScreen extends StatelessWidget {
  const AddQueryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddQueryCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              children: [
                const TopAppBar(title: 'Create Query'),
                verticalSpacing(40),
                Text(
                  'Choose a table and create your query.',
                  style: TextStylesManager.font18BlackRegular,
                ).animate().fade(duration: 600.ms, delay: 300.ms),
                verticalSpacing(30),
                const CreateQuerySection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
