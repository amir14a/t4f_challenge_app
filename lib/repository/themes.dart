import 'package:flutter/material.dart';
import 'package:t4f_challenge_app/repository/colors.dart';

final appLightTheme = ThemeData(
  fontFamily: 'Ubuntu',
  brightness: Brightness.light,
  primaryColor: AppColors.primaryColor,
  colorScheme: const ColorScheme.light(primary: AppColors.primaryColor),
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.primaryColor,foregroundColor: AppColors.lightTextColor),
);
final appDarkTheme = ThemeData(
  fontFamily: 'Ubuntu',
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryColor,
  colorScheme: const ColorScheme.dark(primary: AppColors.primaryColor),
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.primaryDarkColor,foregroundColor: AppColors.darkTextColor),
);
