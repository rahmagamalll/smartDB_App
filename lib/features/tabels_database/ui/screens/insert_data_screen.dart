import 'package:flutter/material.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/top_app_bar.dart';
import 'package:software_project/features/tabels_database/ui/widgets/insert_data_screen/insert_data_section.dart';

class InsertDataIntoTableScreen extends StatefulWidget {
  const InsertDataIntoTableScreen({super.key});

  @override
  State<InsertDataIntoTableScreen> createState() =>
      _InsertDataIntoTableScreenState();
}

class _InsertDataIntoTableScreenState extends State<InsertDataIntoTableScreen> {
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
              const Expanded(child: InsertDataSetion())
            ],
          ),
        ),
      ),
    );
  }
}
