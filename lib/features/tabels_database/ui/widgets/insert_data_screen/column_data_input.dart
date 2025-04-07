
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/theming/colors.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_text_form_field.dart';

class ColumnDataInput extends StatelessWidget {
  final String columnName;
  final String columnType;
  final TextEditingController controller;
  final Function(String) onDataEntered;

  const ColumnDataInput({
    super.key,
    required this.columnName,
    required this.columnType,
    required this.controller,
    required this.onDataEntered,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$columnName        :',
            style: TextStylesManager.font16BlackMedium,
          ),
          horizontalSpacing(10),
          SizedBox(
            width: 150.w,
            child: Container(
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
                controller: controller,
                hintStyle: TextStylesManager.font14MediumGrayRegular,
                contentPadding: EdgeInsets.all(15.h),
                borderRadius: BorderRadius.circular(10.r),
                hintText: 'Enter data',
                onChanged: onDataEntered,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
