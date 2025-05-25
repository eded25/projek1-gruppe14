import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/models/user_model.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FindBarbersTile extends StatelessWidget {
  const FindBarbersTile({super.key, required this.barbers});

  final UserModel barbers;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<CustomDrawerController>();
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? AppColors.darkBgThree : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.3),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(Assets.barberImage1),
          ),
          8.pw,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                barbers.name,
                style: AppTextStyles.getPoppins(
                  14.sp,
                  5.weight,
                  themeController.isDarkMode,

                  AppColors.primaryColor,
                ),
              ),
              Text(
                'Available Time'.tr,
                style: AppTextStyles.getPoppins(14.sp, 5.weight),
              ),
              Text(
                barbers.availableTimes.join(', '),
                style: AppTextStyles.getPoppins(13.sp, 4.weight),
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              Text(
                barbers.rating.toString(),
                style: AppTextStyles.getPoppins(22.sp, 5.weight),
              ),
              RatingBar.builder(
                initialRating: barbers.rating,
                minRating: 1,
                ignoreGestures: true,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemSize: 20,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder:
                    (context, _) => Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
