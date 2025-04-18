
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/theming/colors.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_text_form_field.dart';
import 'package:software_project/features/tabels_database/logic/add_new_table/add_new_table_cubit.dart';

class AddNewTableTopSection extends StatelessWidget {
  const AddNewTableTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Create a new table in your database.',
          style: TextStylesManager.font18BlackRegular,
        ).animate().fade(duration: 600.ms, delay: 300.ms),
        verticalSpacing(30),
        Container(
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: ColorsManager.primaryColor.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(4, 4),
              ),
            ],
          ),
          child: CustomTextFormField(
            controller: context.read<AddNewTableCubit>().tableNameController,
            hintStyle: TextStylesManager.font14MediumGrayRegular,
            contentPadding: EdgeInsets.all(16.h),
            borderRadius: BorderRadius.circular(10.r),
            hintText: 'Enter your table name',
          ),
        ),
      ],
    );
  }
}
