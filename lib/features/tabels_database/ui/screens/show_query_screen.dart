import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/theming/colors.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_elevation_button.dart';
import 'package:software_project/core/widgets/top_app_bar.dart';

class ShowQueryScreen extends StatelessWidget {
  final List<Map<String, String>> queryData = [
    {'column1': 'value1', 'column2': 'value2', 'column3': 'value3'},
    {'column1': 'value4', 'column2': 'value5', 'column3': 'value6'},
    {'column1': 'value7', 'column2': 'value8', 'column3': 'value9'},
  ];

  @override
  Widget build(BuildContext context) {
    List<DataColumn> columnHeaders = queryData.isNotEmpty
        ? queryData[0].keys.map((key) {
            return DataColumn(label: Text(key));
          }).toList()
        : [];

    List<DataRow> rows = queryData.map((data) {
      return DataRow(
        cells: data.values.map((value) {
          return DataCell(Text(value ?? 'N/A'));
        }).toList(),
      );
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopAppBar(title: 'Query Results'),
              verticalSpacing(20),
              Text(
                'Data from your query:',
                style: TextStylesManager.font18BlackRegular,
              ),
              verticalSpacing(30),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
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
              ),
              CustomElevationButton(
                title: 'Execute Another Query',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> tableNames = [
  'Users',
  'Products',
  'Orders',
  'Categories',
  'Suppliers',
  'Customers',
  'Invoices',
  'Payments',
  'Shipping',
  'Reviews',
];
