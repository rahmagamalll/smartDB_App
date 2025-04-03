import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/theming/colors.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_elevation_button.dart';
import 'package:software_project/core/widgets/top_app_bar.dart';

class ShowQueryScreen extends StatelessWidget {
  // البيانات المحاكية التي سيتم عرضها (تأتي من الكويري)
  final List<Map<String, String>> queryData = [
    {'column1': 'value1', 'column2': 'value2', 'column3': 'value3'},
    {'column1': 'value4', 'column2': 'value5', 'column3': 'value6'},
    {'column1': 'value7', 'column2': 'value8', 'column3': 'value9'},
  ];

  @override
  Widget build(BuildContext context) {
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
                child: ListView.builder(
                  itemCount: queryData.length,
                  itemBuilder: (context, index) {
                    var data = queryData[index];
                    return Card(
                      color: ColorsManager.white,
                      elevation: 5,
                      shadowColor: ColorsManager.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: Padding(
                        padding: EdgeInsets.all(16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var key in data.keys)
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Row(
                                  children: [
                                    Text(
                                      '$key: ',
                                      style: TextStylesManager
                                          .font14MediumGrayRegular
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        data[key] ?? 'N/A',
                                        style: TextStylesManager
                                            .font14MediumGrayRegular,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
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
