import 'package:barber_select/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static List<int> fontSizes = List.generate(25, (index) => index + 8);

  static Map<int, TextStyle Function(FontWeight, Color)> lato = {
    for (var size in fontSizes)
      size:
          (weight, color) => GoogleFonts.lato(
            fontSize: size.toDouble(),
            fontWeight: weight,
            color: color,
          ),
  };

  static Map<int, TextStyle Function(FontWeight, Color)> poppins = {
    for (var size in fontSizes)
      size:
          (weight, color) => GoogleFonts.poppins(
            fontSize: size.toDouble(),
            fontWeight: weight,
            color: color,
          ),
  };

  static TextStyle getLato(
    double size,
    FontWeight weight, [
    Color color = AppColors.textBlackColor,
  ]) {
    if (lato.containsKey(size)) {
      return lato[size]!(weight, color);
    } else {
      return GoogleFonts.lato(fontSize: size, fontWeight: weight, color: color);
    }
  }
static TextStyle getPoppins(
  double size,
  FontWeight weight, [
  RxBool? isDarkMode,
  Color? color,
]) {
  final bool darkMode = isDarkMode?.value ?? Get.isDarkMode;
  final isDefaultColor = color == null || color == AppColors.textBlackColor;

  final effectiveColor =
      darkMode && isDefaultColor
          ? AppColors.whiteColor
          : color ?? AppColors.textBlackColor;

  if (poppins.containsKey(size)) {
    return poppins[size]!(weight, effectiveColor);
  } else {
    return GoogleFonts.poppins(
      fontSize: size,
      fontWeight: weight,
      color: effectiveColor,
    );
  }
}
}
