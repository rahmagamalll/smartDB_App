import 'package:flutter/material.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/features/tabels_database/ui/widgets/home_screen/buttons_list.dart';
import 'package:software_project/features/tabels_database/ui/widgets/home_screen/home_screen_top_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                verticalSpacing(80),
                const HomeScreenTopSection(),
                verticalSpacing(50),
                const ButtonsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
