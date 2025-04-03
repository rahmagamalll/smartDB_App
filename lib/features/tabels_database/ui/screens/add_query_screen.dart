 import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/theming/colors.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_drop_down.dart';
import 'package:software_project/core/widgets/custom_elevation_button.dart';
import 'package:software_project/core/widgets/custom_text_form_field.dart';
import 'package:software_project/core/widgets/top_app_bar.dart';
import 'package:software_project/features/tabels_database/ui/screens/show_query_screen.dart';

class AddQueryScreen extends StatelessWidget {
  const AddQueryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              const TopAppBar(title: 'Show Query'),
              verticalSpacing(40),
              Text(
                'Choose a table and create your query.',
                style: TextStylesManager.font18BlackRegular,
              ).animate().fade(duration: 600.ms, delay: 300.ms),
              verticalSpacing(30),
              CustomDropDown(
                hint: 'Choose Table',
                itemsDrop: tableNames,
              ),
              verticalSpacing(30),
              Container(
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
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
                  hintStyle: TextStylesManager.font14MediumGrayRegular,
                  contentPadding: EdgeInsets.all(16.h),
                  borderRadius: BorderRadius.circular(10.r),
                  hintText: 'Enter your query',
                ),
              ),
              const Spacer(),
              CustomElevationButton(
                title: 'Show Query',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}