import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/theming/colors.dart';
import 'package:software_project/core/theming/styles.dart';

// ignore: must_be_immutable
class CustomDropDown extends StatefulWidget {
  CustomDropDown({
    super.key,
    this.selectedOption,
    this.itemsDrop,
    this.onChanged,
    required this.hint,
    this.height,
    this.width,
  });
  double? height;
  double? width;
  String? selectedOption;
  String hint;
  List<String>? itemsDrop;
  Function(String)? onChanged;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    if (widget.itemsDrop == null || widget.itemsDrop!.isEmpty) {
      return Container();
    }

    String? displayValue = widget.selectedOption ?? widget.hint;

    return SizedBox(
      height: widget.height ?? 50.h,
      width: widget.width ?? double.infinity,
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
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
        child: DropdownButton<String>(
          hint: Text(
            widget.hint,
            style: TextStylesManager.font14MediumGrayRegular,
          ),
          borderRadius: BorderRadius.circular(8.r),
          dropdownColor: ColorsManager.white,
          underline: const SizedBox(),
          style: TextStylesManager.font16BlackRegular.copyWith(
            fontSize: 14.sp,
          ),
          value: displayValue != widget.hint ? widget.selectedOption : null,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              color: ColorsManager.mediumGrey),
          onChanged: (String? newValue) {
            setState(() {
              widget.selectedOption = newValue;
            });
            if (widget.onChanged != null && newValue != null) {
              widget.onChanged!(newValue);
            }
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
