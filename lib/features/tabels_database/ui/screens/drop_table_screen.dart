import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/di/dependency_injection.dart';
import 'package:software_project/core/helper/extensions.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_drop_down.dart';
import 'package:software_project/core/widgets/custom_elevation_button.dart';
import 'package:software_project/core/widgets/custom_snack_bar.dart';
import 'package:software_project/core/widgets/top_app_bar.dart';
import 'package:software_project/features/tabels_database/logic/drop_table/drop_table_cubit.dart';

class DropTableScreen extends StatelessWidget {
  const DropTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DropTableCubit>()..loadTableNames(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: BlocListener<DropTableCubit, DropTableState>(
              listener: (context, state) {
                if (state is DropTableLoading) {
                  const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is DropTableSuccess) {
                  context.pop();
                  CustomSnackBar.show(context, state.message);
                } else if (state is DropTableError) {
                  CustomSnackBar.show(context, state.message, isError: true);
                }
              },
              child: BlocBuilder<DropTableCubit, DropTableState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TopAppBar(title: 'Delete Table'),
                      verticalSpacing(160),
                      Text(
                        'Choose a table to delete.',
                        style: TextStylesManager.font18BlackRegular,
                      ).animate().fade(duration: 600.ms, delay: 300.ms),
                      verticalSpacing(30),
                      CustomDropDown(
                        hint: 'Choose Table',
                        itemsDrop: context.read<DropTableCubit>().tableNames,
                        selectedOption:
                            context.read<DropTableCubit>().selectedTable,
                        onChanged: (value) {
                          context.read<DropTableCubit>().selectTable(value);
                        },
                      ),
                      const Spacer(),
                      CustomElevationButton(
                        title: 'Drop Table',
                        onPressed: () {
                          context.read<DropTableCubit>().dropTable(
                              context.read<DropTableCubit>().selectedTable!);
                        },
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<String> tableNames = [
  'Users',
  'Products',
  'Orders',
  'Categories',
  'Suppliers',
  'Customers',
  'Invoices',
  'Payments',
  'Shipping',
  'Reviews',
];
