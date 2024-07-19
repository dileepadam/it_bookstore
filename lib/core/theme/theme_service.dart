// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: constant_identifier_names

import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:it_bookstore/core/theme/theme_data.dart';

class AppTheme {
  ThemeData themeData;
  ThemeType themeType;
  AppTheme({
    required this.themeData,
    required this.themeType,
  });
}

enum ThemeType { LIGHT, DARK, RED }


final List<AppTheme> themes = [
  AppTheme(themeData: getAppTheme(ThemeType.LIGHT), themeType: ThemeType.LIGHT),
  AppTheme(themeData: getAppTheme(ThemeType.DARK), themeType: ThemeType.DARK),
  AppTheme(themeData: getAppTheme(ThemeType.RED), themeType: ThemeType.RED)
];

final themeProvider = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<AppTheme> {

  ThemeNotifier() : super(themes.first) {
    _loadThemePreference();
  }


  Future<void> _loadThemePreference() async {
    final defaultTheme = PlatformDispatcher.instance.platformBrightness == Brightness.light ? ThemeType.LIGHT.toString() : ThemeType.DARK.toString();
    log(defaultTheme);
    final themeType = ThemeType.values.firstWhere((e) => e.toString() == ThemeType.LIGHT,);
    state = themes.firstWhere((theme) => theme.themeType == themeType,orElse: () => AppTheme(themeData: getAppTheme(ThemeType.LIGHT), themeType: ThemeType.LIGHT),);
  }
}