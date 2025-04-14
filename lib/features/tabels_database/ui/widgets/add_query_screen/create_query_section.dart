import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/helper/extensions.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/routing/routes.dart';
import 'package:software_project/core/theming/colors.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_drop_down.dart';
import 'package:software_project/core/widgets/custom_elevation_button.dart';
import 'package:software_project/core/widgets/custom_snack_bar.dart';
import 'package:software_project/core/widgets/custom_text_form_field.dart';
import 'package:software_project/features/tabels_database/logic/add_query/add_query_cubit.dart';
import 'package:software_project/features/tabels_database/ui/screens/show_query_screen.dart';

class CreateQuerySection extends StatefulWidget {
  const CreateQuerySection({super.key});

  @override
  State<CreateQuerySection> createState() => _CreateQuerySectionState();
}

class _CreateQuerySectionState extends State<CreateQuerySection> {
  final TextEditingController whereClauseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddQueryCubit, AddQueryState>(
      builder: (context, state) {
        final cubit = context.read<AddQueryCubit>();
        return Column(
          children: [
            CustomDropDown(
              hint: 'Choose Table',
              itemsDrop: cubit.tableNames,
              selectedOption: cubit.selectedTable,
              onChanged: (value) {
                cubit.selectedTable = value;
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
                hintText: 'Enter your query',
              ),
            ),
            verticalSpacing(20),
            CustomElevationButton(
              title: 'Show Query',
              onPressed: () {
                // if (cubit.selectedTable != null) {
                //   cubit.getTableData(
                //     tableName: cubit.selectedTable!,
                //     whereClause: whereClauseController.text,
                //   );
                //   context.pushNamed(Routes.showQueryScreen);
                // } else {
                //   CustomSnackBar.show(context, 'Please select a table');
                //   // ScaffoldMessenger.of(context).showSnackBar(
                //   //   SnackBar(content: Text('Please select a table')),
                //   // );
                // }
                if (cubit.selectedTable != null) {
                  // جلب البيانات من الـ Cubit
                  cubit.getTableData(
                    tableName: cubit.selectedTable!,
                    whereClause: whereClauseController.text,
                  );

                  // انتظار حتى تكتمل الدالة
                  cubit.stream.listen((state) {
                    if (state is AddQueryDataLoaded) {
                      // تمرير البيانات إلى ShowQueryScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: cubit,
                            child: ShowQueryScreen(data: state.data),
                          ),
                        ),
                      );
                    } else if (state is AddQueryError) {
                      CustomSnackBar.show(context, 'Error: ${state.message}');
                    }
                  });
                } else {
                  CustomSnackBar.show(context, 'Please select a table');
                }
              },
            ),
          ],
        );
      },
    );
  }
}
