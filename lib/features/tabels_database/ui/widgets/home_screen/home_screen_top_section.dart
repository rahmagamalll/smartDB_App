
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/theming/styles.dart';

class HomeScreenTopSection extends StatelessWidget {
  const HomeScreenTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome to SmartDB',
          style: TextStylesManager.font18BlackBold.copyWith(
            fontSize: 24.sp,
          ),
        ).animate().fade(duration: 1000.ms).slideY(begin: -0.2),
        verticalSpacing(50),
        Text(
          'Select a table to view or create .',
          style: TextStylesManager.font18BlackRegular,
        ).animate().fade(duration: 800.ms, delay: 300.ms),
      ],
    );
  }
}
