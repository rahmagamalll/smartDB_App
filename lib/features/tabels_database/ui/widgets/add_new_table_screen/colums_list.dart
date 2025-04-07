
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/widgets/custom_elevation_button.dart';
import 'package:software_project/features/tabels_database/ui/widgets/add_new_table_screen/add_colum_in_table.dart';

class ColumnsList extends StatefulWidget {
  ColumnsList({super.key});

  @override
  State<ColumnsList> createState() => _ColumnsListState();
}

class _ColumnsListState extends State<ColumnsList> {
  List<Map<String, String>> columns = [];

  void addColumn() {
    setState(() {
      columns.add({'name': '', 'type': ''});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
