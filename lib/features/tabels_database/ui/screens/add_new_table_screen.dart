import 'package:flutter/material.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/widgets/custom_elevation_button.dart';
import 'package:software_project/core/widgets/top_app_bar.dart';
import 'package:software_project/features/tabels_database/ui/widgets/add_new_table_screen/add_new_table_top_section.dart';
import 'package:software_project/features/tabels_database/ui/widgets/add_new_table_screen/colums_list.dart';

class AddNewTableScreen extends StatefulWidget {
  const AddNewTableScreen({super.key});

  @override
  State<AddNewTableScreen> createState() => _AddNewTableScreenState();
}

class _AddNewTableScreenState extends State<AddNewTableScreen> {
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
              const AddNewTableTopSection(),
              verticalSpacing(20),
              ColumnsList(),
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
