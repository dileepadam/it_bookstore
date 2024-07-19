import 'dart:io';

import 'package:flutter/material.dart';
import 'package:it_bookstore/features/presentation/views/home/home_page.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static const String kHomeView = "kHomeView";

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final isIOS = Platform.isIOS ? true : false;
    final disableIOS = false;
    switch (settings.name) {
      case Routes.kHomeView:
        return PageTransition(
          isIos: isIOS,
          child: HomePage(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kHomeView),
        );
      default:
        return PageTransition(
          isIos: isIOS,
          type: PageTransitionType.fade,
          child: const Scaffold(
            body: Center(
              child: Text("Invalid Route"),
            ),
          ),
        );
    }
  }
}
