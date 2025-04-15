import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_elevation_button.dart';
import 'package:software_project/core/widgets/top_app_bar.dart';
import 'package:software_project/features/tabels_database/ui/widgets/show_query_screen/table_view.dart';

class ShowQueryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const ShowQueryScreen({super.key, required this.data});

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
                child: data.isEmpty
                    ? const Center(child: Text('No data found.'))
                    : TableView(querydata: data),
              ),
              CustomElevationButton(
                title: 'Execute Another Query',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
