import 'dart:io';

import 'package:flutter/material.dart';
import 'package:it_bookstore/features/presentation/views/book_details/book_deatils_page.dart';
import 'package:it_bookstore/features/presentation/views/favorite_books/favorite_books_page.dart';
import 'package:it_bookstore/features/presentation/views/home/home_page.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static const String kHomeView = "kHomeView";
  static const String kBookDetail = "kBookDetail";
  static const String kFavouriteBook = "kFavouriteBook";

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final isIOS = Platform.isIOS ? true : false;
    switch (settings.name) {
      case Routes.kHomeView:
        return PageTransition(
          isIos: isIOS,
          child: HomePage(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kHomeView),
        );
      case Routes.kBookDetail:
        return PageTransition(
          isIos: isIOS,
          child: BookDetailsPage(
            isbn13: settings.arguments as String,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kBookDetail),
        );
      case Routes.kFavouriteBook:
        return PageTransition(
          isIos: isIOS,
          child: FavoriteBookPage(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kFavouriteBook),
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
