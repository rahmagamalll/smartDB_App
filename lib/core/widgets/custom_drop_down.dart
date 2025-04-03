// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/theming/colors.dart';
import 'package:software_project/core/theming/styles.dart';

// ignore: must_be_immutable
class CustomDropDown extends StatefulWidget {
  CustomDropDown(
      {super.key,
      this.selectedOption,
      this.itemsDrop,
      required this.onChanged});
  String? selectedOption;
  List<String>? itemsDrop;
  final Function(String) onChanged;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.h,
      width: 90.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: const Color(0xffCDCDCD)),
        ),
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(8.r),
          dropdownColor: ColorsManager.white,
          underline: const SizedBox(),
          style: TextStylesManager.font16BlackRegular.copyWith(
            fontSize: 12.sp,
          ),
          value: widget.selectedOption,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              color: ColorsManager.mediumGrey),
          onChanged: (String? newValue) {
            setState(() {
              widget.selectedOption = newValue;
              widget.onChanged(newValue!);
            });
          },
          items:
              widget.itemsDrop!.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
