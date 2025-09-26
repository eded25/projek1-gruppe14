import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MonthContainer extends StatelessWidget {
  const MonthContainer({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.primaryColor,
      ),
      child: Center(
        child: Text(text, style: AppTextStyles.getPoppins(15.sp, 6.weight)),
      ),
    );
  }
}
