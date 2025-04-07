import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_drop_down.dart';
import 'package:software_project/core/widgets/custom_elevation_button.dart';
import 'package:software_project/core/widgets/top_app_bar.dart';

class ViewTableScreen extends StatelessWidget {
  const ViewTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopAppBar(title: 'View Table'),
              verticalSpacing(160),
              Text(
                'Choose a table to display.',
                style: TextStylesManager.font18BlackRegular,
              ).animate().fade(duration: 600.ms, delay: 300.ms),
              verticalSpacing(30),
              CustomDropDown(
                hint: 'Choose Table',
                itemsDrop: tableNames,
              ),
              const Spacer(),
              CustomElevationButton(
                title: 'View Table',
                onPressed: () {},
              )
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
