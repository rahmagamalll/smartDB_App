import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/theming/colors.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_drop_down.dart';
import 'package:software_project/core/widgets/custom_text_form_field.dart';

class CreateQuerySection extends StatelessWidget {
  const CreateQuerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropDown(
          hint: 'Choose Table',
          itemsDrop: tableNames,
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
            hintStyle: TextStylesManager.font14MediumGrayRegular,
            contentPadding: EdgeInsets.all(16.h),
            borderRadius: BorderRadius.circular(10.r),
            hintText: 'Enter your query',
          ),
        ),
      ],
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
