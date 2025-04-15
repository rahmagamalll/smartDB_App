import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/helper/extensions.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/theming/colors.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_drop_down.dart';
import 'package:software_project/core/widgets/custom_elevation_button.dart';
import 'package:software_project/core/widgets/custom_snack_bar.dart';
import 'package:software_project/core/widgets/custom_text_form_field.dart';
import 'package:software_project/core/widgets/top_app_bar.dart';
import 'package:software_project/features/tabels_database/logic/drop_table/drop_table_cubit.dart';

class DeleteDataSection extends StatelessWidget {
  final TextEditingController whereClauseController = TextEditingController();
  DeleteDataSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DropTableCubit, DropTableState>(
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
              verticalSpacing(40),
              Text(
                'Choose a table to delete.',
                style: TextStylesManager.font18BlackRegular,
              ).animate().fade(duration: 600.ms, delay: 300.ms),
              verticalSpacing(30),
              CustomDropDown(
                hint: 'Choose Table',
                itemsDrop: context.read<DropTableCubit>().tableNames,
                selectedOption: context.read<DropTableCubit>().selectedTable,
                onChanged: (value) {
                  context.read<DropTableCubit>().selectTable(value);
                },
              ),
              verticalSpacing(30),
              Container(
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.primaryColor.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: CustomTextFormField(
                  controller: whereClauseController,
                  hintStyle: TextStylesManager.font14MediumGrayRegular,
                  contentPadding: EdgeInsets.all(16.h),
                  borderRadius: BorderRadius.circular(10.r),
                  hintText: 'Enter your condition',
                ),
              ),
              verticalSpacing(10),
              if (context.read<DropTableCubit>().selectedTable != null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: CustomElevationButton(
                      backgroundColor: Colors.red,
                      widthOfButton: 120.w,
                      heightOfButton: 50,
                      borderRadiusGeometry: BorderRadius.circular(10.r),
                      title: 'Drop Table',
                      onPressed: () {
                        context.read<DropTableCubit>().deleteTableDataOrDropIt(
                            tableName:
                                context.read<DropTableCubit>().selectedTable!);
                      },
                    ),
                  ),
                ),
              const Spacer(),
              if (context.read<DropTableCubit>().selectedTable != null &&
                  context.read<DropTableCubit>().columnNames.isNotEmpty)
                CustomElevationButton(
                  title: 'Delete Record',
                  onPressed: () {
                    if (whereClauseController.text.isEmpty) {
                      CustomSnackBar.show(context, 'must enter the condition ',
                          isError: true);
                    } else {
                      context.read<DropTableCubit>().deleteTableDataOrDropIt(
                            tableName:
                                context.read<DropTableCubit>().selectedTable!,
                            whereClause: whereClauseController.text,
                          );
                    }
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
