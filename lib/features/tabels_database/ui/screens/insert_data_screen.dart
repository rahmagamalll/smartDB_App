import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/theming/colors.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_drop_down.dart';
import 'package:software_project/core/widgets/custom_elevation_button.dart';
import 'package:software_project/core/widgets/custom_text_form_field.dart';
import 'package:software_project/core/widgets/top_app_bar.dart';

class InsertDataIntoTableScreen extends StatefulWidget {
  const InsertDataIntoTableScreen({super.key});

  @override
  State<InsertDataIntoTableScreen> createState() =>
      _InsertDataIntoTableScreenState();
}

class _InsertDataIntoTableScreenState extends State<InsertDataIntoTableScreen> {
  // List of tables with their respective columns
  Map<String, List<Map<String, dynamic>>> tables = {
    'Table1': [
      {'name': 'Column 1', 'type': 'String'},
      {'name': 'Column 2', 'type': 'Integer'},
      {'name': 'Column 3', 'type': 'Float'},
    ],
    'Table2': [
      {'name': 'Column A', 'type': 'String'},
      {'name': 'Column B', 'type': 'Boolean'},
    ],
    'Table3': [
      {'name': 'Column X', 'type': 'Integer'},
      {'name': 'Column Y', 'type': 'Date'},
    ],
  };

  List<String> tableNames = [
    'Table1',
    'Table2',
    'Table3'
  ]; // Example table names
  String? selectedTable; // To hold the selected table
  List<Map<String, dynamic>> columns =
      []; // Will hold columns of the selected table
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Dispose controllers when not in use
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Function to update columns based on selected table
  void updateColumns(String? tableName) {
    if (tableName != null) {
      setState(() {
        selectedTable = tableName;
        columns = tables[tableName] ?? [];
        controllers =
            List.generate(columns.length, (index) => TextEditingController());
      });
    }
  }

  void insertData() {
    for (int i = 0; i < columns.length; i++) {
      print('Column: ${columns[i]['name']}, Data: ${controllers[i].text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            children: [
              const TopAppBar(title: 'Insert Data Into Table'),
              verticalSpacing(40),
              Text(
                'Enter data for your table columns.',
                style: TextStylesManager.font18BlackRegular,
              ),
              verticalSpacing(30),
              CustomDropDown(
                hint: 'Choose Table',
                itemsDrop: tableNames,
                onChanged: updateColumns,
              ),
              verticalSpacing(20),
              if (selectedTable != null && columns.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: columns.length,
                    itemBuilder: (context, index) {
                      return ColumnDataInput(
                        columnName: columns[index]['name'],
                        columnType: columns[index]['type'],
                        controller: controllers[index],
                        onDataEntered: (data) {
                          print('Data for ${columns[index]['name']}: $data');
                        },
                      );
                    },
                  ),
                ),
              if (selectedTable == null || columns.isEmpty)
                Center(
                  child: Text(
                    'Please select a table to load columns.',
                    style: TextStylesManager.font16MediumGrayRegular,
                  ),
                ),
              verticalSpacing(10),
              if (selectedTable != null && columns.isNotEmpty)
                CustomElevationButton(
                  title: 'Insert Data',
                  onPressed: insertData,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

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
