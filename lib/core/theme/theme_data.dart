import 'package:flutter/material.dart';
import 'package:it_bookstore/core/theme/theme_service.dart';


import 'colors/app_colors.dart';
import 'colors/dark_colors.dart';
import 'colors/light_colors.dart';



AppColors colors(context) => Theme.of(context).extension<AppColors>()!;

ThemeData getAppTheme(ThemeType themeType) {
  AppColors colors;
  switch (themeType) {
    case ThemeType.LIGHT:
      colors = LightColors.lightTheme() ;
      break;
    case ThemeType.DARK:
      colors = DarkColors.darkTheme();
      break;
    case ThemeType.RED:
      colors = LightColors.lightTheme() ;
      break;
    default: 
      colors = LightColors.lightTheme() ;
  }

  return ThemeData(
    useMaterial3: true,
    extensions: <ThemeExtension<AppColors>>[
      colors
    ],
    scaffoldBackgroundColor:colors.whiteColor,
    primaryColor: colors.primaryColor,
  );
}


