import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/theming/colors.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_text_form_field.dart';

class ColumnDataInput extends StatefulWidget {
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
  State<ColumnDataInput> createState() => _ColumnDataInputState();
}

class _ColumnDataInputState extends State<ColumnDataInput> {
  String? errorText;

  bool isValidInput(String input, String type) {
    switch (type.toUpperCase()) {
      case 'INTEGER':
        return int.tryParse(input) != null;
      case 'REAL':
      case 'DOUBLE':
      case 'FLOAT':
        return double.tryParse(input) != null;
      case 'BOOLEAN':
        return input.toLowerCase() == 'true' || input.toLowerCase() == 'false';
      case 'TEXT':
      case 'VARCHAR':
        return true;
      default:
        return true;
    }
  }

  void handleInput(String value) {
    final isValid = isValidInput(value, widget.columnType);
    setState(() {
      errorText = isValid ? null : 'Expected ${widget.columnType}';
    });
    if (isValid) {
      widget.onDataEntered(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.columnName}        :',
                style: TextStylesManager.font16BlackMedium,
              ),
              horizontalSpacing(10),
              SizedBox(
                width: 150.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      child: CustomTextFormField(
                        controller: widget.controller,
                        hintStyle: TextStylesManager.font14MediumGrayRegular,
                        contentPadding: EdgeInsets.all(15.h),
                        borderRadius: BorderRadius.circular(10.r),
                        hintText: 'Enter data',
                        onChanged: handleInput,
                      ),
                    ),
                    if (errorText != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          errorText!,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
