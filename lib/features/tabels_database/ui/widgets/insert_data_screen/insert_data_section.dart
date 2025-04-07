import 'package:flutter/material.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_drop_down.dart';
import 'package:software_project/core/widgets/custom_elevation_button.dart';
import 'package:software_project/features/tabels_database/ui/widgets/insert_data_screen/column_data_input.dart';

class InsertDataSetion extends StatefulWidget {
  const InsertDataSetion({super.key});

  @override
  State<InsertDataSetion> createState() => _InsertDataSetionState();
}

class _InsertDataSetionState extends State<InsertDataSetion> {
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
    return Column(
      children: [
        CustomDropDown(
          hint: 'Choose Table',
          selectedOption: selectedTable,
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
    );
  }
}
