import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:software_project/core/widgets/custom_elevation_button.dart';
import 'package:software_project/core/widgets/top_app_bar.dart';
import 'package:software_project/features/tabels_database/ui/widgets/show_query_screen/table_view.dart';

class ShowQueryScreen extends StatelessWidget {
  const ShowQueryScreen({super.key});

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
              TableView(),
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
