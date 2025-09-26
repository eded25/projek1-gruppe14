import 'package:barber_select/screens/rate_app/controller/rate_app_controller.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:barber_select/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RateAppScreen extends StatelessWidget {
  const RateAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RateAppController());
    final themeController = Get.find<CustomDrawerController>();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                40.ph,
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back, color: AppColors.primaryColor),
                ),
                20.ph,

                Text(
                  "Evaluate how your experience has been:".tr,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.getPoppins(26.sp, 5.weight),
                ),
                5.ph,

                Center(
                  child: Obx(
                    () => RatingBar.builder(
                      initialRating: controller.appRating.value,
                      minRating: 0,

                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemSize: 30,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder:
                          (context, _) => Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) {
                        controller.appRating.value = rating;
                        print(rating);
                      },
                    ),
                  ),
                ),
                20.ph,
                Obx(
                  () => Text(
                    controller.appRating.value > 3
                        ? "Select the stars based on what you would like to rate us."
                            .tr
                        : "What a pity, we're sorry, what could we improve?".tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.getPoppins(14.sp, 4.weight),
                  ),
                ),
                20.ph,

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: Get.width,
                  decoration: BoxDecoration(
                    color:
                        Get.isDarkMode
                            ? AppColors.darkBgThree
                            : Color(0xffF6F6FD),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blackColor.withOpacity(0.3),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      20.ph,

                      CustomTextFormField(
                        labelFieldSpace: 0,
                        fieldLabel: '',
                        focusNode: controller.fnRateApp,
                        controller: controller.tecRateApp,
                        borderColor: AppColors.whiteColor,
                        borderRadius: 6,
                        hintText: 'Wrtite here...'.tr,
                        maxLines: 8,
                        maxLength: 500,
                      ),

                      10.ph,
                      SizedBox(
                        width: 300.w,
                        child: CustomButtonWidget(
                          btnLabel: "RATE THE APP".tr,
                          onTap: () {
                            Get.close(2);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Message sent, Thank you!'.tr,
                                  style: AppTextStyles.getPoppins(
                                    12.sp,
                                    4.weight,
                                    themeController.isDarkMode,
                                    AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      10.ph,
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Text(
                          'Not now'.tr,
                          style: AppTextStyles.getPoppins(
                            16.sp,
                            6.weight,
                          ).copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor:
                                Get.isDarkMode
                                    ? AppColors.whiteColor
                                    : AppColors.blackColor,
                          ),
                        ),
                      ),
                      20.ph,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
