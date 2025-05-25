import 'package:barber_select/models/service_model.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfessionalsContainer extends StatelessWidget {
  const ProfessionalsContainer({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 140.w,

          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: AppColors.blackColor.withOpacity(0.3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.getPoppins(12.sp, 5.weight)),
            ],
          ),
        ),
      ],
    );
  }
}
