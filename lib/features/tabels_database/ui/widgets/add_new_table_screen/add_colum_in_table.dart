import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/theming/colors.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_drop_down.dart';
import 'package:software_project/core/widgets/custom_text_form_field.dart';

class AddColumInTable extends StatefulWidget {
  final Function(String) onColumnNameChanged;
  final Function(String) onDataTypeChanged;

  const AddColumInTable({
    super.key,
    required this.onColumnNameChanged,
    required this.onDataTypeChanged,
  });

  @override
  State<AddColumInTable> createState() => AddColumInTableState();
}

class AddColumInTableState extends State<AddColumInTable> {
  String? selectedDataType;
  String? columnName;
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                child: SizedBox(
                  width: 160.w,
                  child: CustomTextFormField(
                    hintStyle: TextStylesManager.font14MediumGrayRegular,
                    contentPadding: EdgeInsets.all(15.h),
                    borderRadius: BorderRadius.circular(10.r),
                    hintText: 'Column name',
                    onChanged: (value) {
                      columnName = value;
                      widget.onColumnNameChanged(value);
                    },
                  ),
                ),
              ),
              CustomDropDown(
                width: 150.w,
                hint: 'Data Type',
                itemsDrop: dataType,
                selectedOption: selectedDataType,
                onChanged: (value) {
                  setState(() {
                    selectedDataType = value;
                  });
                  widget.onDataTypeChanged(value);
                },
              ),
            ],
          ),
          if (hasError)
            Padding(
              padding: EdgeInsets.only(top: 5.h, left: 8.w),
              child: Text(
                'Please fill both fields',
                style: TextStyle(
                    color: const Color.fromARGB(255, 222, 74, 64),
                    fontSize: 12.sp),
              ),
            ),
        ],
      ),
    );
  }

  bool validate() {
    setState(() {
      hasError = (columnName == null ||
          columnName!.isEmpty ||
          selectedDataType == null ||
          selectedDataType!.isEmpty);
    });
    return !hasError;
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
