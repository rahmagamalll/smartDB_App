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

class AddNewTableScreen extends StatefulWidget {
  const AddNewTableScreen({super.key});

  @override
  State<AddNewTableScreen> createState() => _AddNewTableScreenState();
}

class _AddNewTableScreenState extends State<AddNewTableScreen> {
  List<Map<String, String>> columns = [];

  void addColumn() {
    setState(() {
      columns.add({'name': '', 'type': ''});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            children: [
              const TopAppBar(title: 'Create New Table'),
              verticalSpacing(40),
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
                  hintText: 'Enter your table name',
                ),
              ),
              verticalSpacing(20),
              Expanded(
                child: ListView.builder(
                  itemCount: columns.length + 1,
                  itemBuilder: (context, index) {
                    if (index == columns.length) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: CustomElevationButton(
                            widthOfButton: 120.w,
                            heightOfButton: 50,
                            borderRadiusGeometry: BorderRadius.circular(10.r),
                            title: 'Add Column',
                            onPressed: addColumn,
                          ),
                        ),
                      );
                    }
                    return AddColumInTable(
                      onColumnNameChanged: (value) {
                        columns[index]['name'] = value;
                      },
                      onDataTypeChanged: (value) {
                        columns[index]['type'] = value;
                      },
                    );
                  },
                ),
              ),
              verticalSpacing(10),
              CustomElevationButton(
                title: 'Create Table',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
