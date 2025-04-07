import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/theming/colors.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_drop_down.dart';
import 'package:software_project/core/widgets/custom_text_form_field.dart';

class AddColumInTable extends StatelessWidget {
  final Function(String) onColumnNameChanged;
  final Function(String) onDataTypeChanged;

  const AddColumInTable({
    super.key,
    required this.onColumnNameChanged,
    required this.onDataTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
            child: SizedBox(
              width: 160.w,
              child: CustomTextFormField(
                hintStyle: TextStylesManager.font14MediumGrayRegular,
                contentPadding: EdgeInsets.all(15.h),
                borderRadius: BorderRadius.circular(10.r),
                hintText: 'Column name',
                onChanged: onColumnNameChanged,
              ),
            ),
          ),
          CustomDropDown(
            width: 150.w,
            hint: 'Data Type',
            itemsDrop: dataType,
            onChanged: onDataTypeChanged,
          ),
        ],
      ),
    );
  }
}

List<String> dataType = [
  'Integer',
  'String',
  'Float',
  'Boolean',
  'Date',
  'Time',
  'Timestamp',
];
