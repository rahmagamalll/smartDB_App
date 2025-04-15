import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:software_project/core/helper/extensions.dart';
import 'package:software_project/core/routing/routes.dart';
import 'package:software_project/features/tabels_database/ui/widgets/home_screen/custom_button.dart';

List<String> buttonNames = [
  'Drop Table',
  'Create Table',
  'Insert Data',
  'Create Query',
];

class ButtonsList extends StatelessWidget {
  const ButtonsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                context.pushNamed(Routes.addQueryScreen);
              }
            },
          ).animate().scale(duration: 800.ms, delay: (index * 200).ms);
        },
      ),
    );
  }
}
