import 'package:barber_select/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  final lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
    useMaterial3: false,

    iconTheme: IconThemeData(color: Colors.black),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    primaryColor: AppColors.primaryColor,
  );

  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: AppColors.primaryColor,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
    scaffoldBackgroundColor: AppColors.darkScreenBg,
  );
}
