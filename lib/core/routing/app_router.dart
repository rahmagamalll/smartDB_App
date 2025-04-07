import 'package:flutter/material.dart';
import 'package:software_project/core/routing/routes.dart';
import 'package:software_project/features/tabels_database/ui/screens/add_new_table_screen.dart';
import 'package:software_project/features/tabels_database/ui/screens/add_query_screen.dart';
import 'package:software_project/features/tabels_database/ui/screens/home_screen.dart';
import 'package:software_project/features/tabels_database/ui/screens/insert_data_screen.dart';
import 'package:software_project/features/tabels_database/ui/screens/show_query_screen.dart';
import 'package:software_project/features/tabels_database/ui/screens/view_table_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeScreen:
        return _createPageTransition(
          child: const HomeScreen(),
          transitionType: PageTransitionType.fade,
        );
      case Routes.addNewTableScreen:
        return _createPageTransition(
          child: const AddNewTableScreen(),
          transitionType: PageTransitionType.slide,
        );
      case Routes.addQueryScreen:
        return _createPageTransition(
          child: const AddQueryScreen(),
          transitionType: PageTransitionType.scale,
        );
      case Routes.showQueryScreen:
        return _createPageTransition(
          child:  ShowQueryScreen(),
          transitionType: PageTransitionType.scale,
        );
      case Routes.insertDataIntoTableScreen:
        return _createPageTransition(
          child:  const InsertDataIntoTableScreen(),
          transitionType: PageTransitionType.scale,
        );
      case Routes.viewTableScreen:
        return _createPageTransition(
          child:  const ViewTableScreen(),
          transitionType: PageTransitionType.scale,
        );

      default:
        return null;
    }
  }

  static PageRouteBuilder _createPageTransition({
    required Widget child,
    PageTransitionType transitionType = PageTransitionType.slide,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;

        if (transitionType == PageTransitionType.slide) {
          final slideTween =
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(
            CurveTween(curve: curve),
          );
          final slideAnimation = animation.drive(slideTween);
          return SlideTransition(position: slideAnimation, child: child);
        }

        if (transitionType == PageTransitionType.fade) {
          return FadeTransition(opacity: animation, child: child);
        }

        if (transitionType == PageTransitionType.scale) {
          return ScaleTransition(scale: animation, child: child);
        }

        return child;
      },
    );
  }
}

/// Transition Types for Reusability
enum PageTransitionType {
  slide,
  fade,
  scale,
}
