import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/theming/colors.dart';
import 'package:software_project/core/theming/styles.dart';

class TableView extends StatelessWidget {
  final List<Map<String, dynamic>> querydata;
  const TableView({super.key, required this.querydata});

  @override
  Widget build(BuildContext context) {
    List<DataColumn> columnHeaders = querydata.isNotEmpty
        ? querydata[0].keys.map((key) {
            return DataColumn(label: Text(key));
          }).toList()
        : [];

    List<DataRow> rows = querydata.map((data) {
      return DataRow(
        cells: data.values.map((value) {
          return DataCell(Text(value.toString())); // Convert value to string
        }).toList(),
      );
    }).toList();

    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(
              ColorsManager.primaryColor.withOpacity(0.5),
            ),
            dataRowColor: WidgetStateProperty.all(
              ColorsManager.primaryColor.withOpacity(0.1),
            ),
            dataTextStyle: TextStylesManager.font16BlackRegular,
            headingTextStyle: TextStylesManager.font16BlackMedium,
            columns: columnHeaders,
            rows: rows,
          ),
        ),
      ),
    );
  }
}

