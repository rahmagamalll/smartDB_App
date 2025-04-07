import 'package:flutter/material.dart';
import 'package:software_project/core/helper/extensions.dart';
import 'package:software_project/core/helper/spacing.dart';
import 'package:software_project/core/routing/routes.dart';
import 'package:software_project/core/theming/colors.dart';
import 'package:software_project/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
                verticalSpacing(50),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return CustomButton(
                        name: buttonNames[index],
                        onTap: () {
                          if (index == 0) {
                            context.pushNamed(Routes.viewTableScreen);
                          } else if (index == 1) {
                            context.pushNamed(Routes.addNewTableScreen);
                          } else if (index == 2) {
                            context.pushNamed(Routes.insertDataIntoTableScreen);
                          } else if (index == 3) {
                            context.pushNamed(Routes.showQueryScreen);
                          }
                        },
                      )
                          .animate()
                          .scale(duration: 800.ms, delay: (index * 200).ms);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<String> buttonNames = [
  'View Table',
  'Create Table',
  'Insert Data',
  'Show Query',
];

class CustomButton extends StatefulWidget {
  const CustomButton({super.key, required this.name, required this.onTap});
  final String name;
  final VoidCallback onTap;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.all(8.0),
        height: _isPressed ? 90 : 100,
        width: _isPressed ? 90 : 100,
        decoration: BoxDecoration(
          color: ColorsManager.primaryColor,
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
        child: Center(
          child: Text(
            widget.name,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
