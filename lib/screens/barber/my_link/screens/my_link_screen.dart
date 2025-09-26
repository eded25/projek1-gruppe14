import 'package:barber_select/screens/barber/my_link/controller/my_link_controller.dart';
import 'package:barber_select/screens/report_bug/controller/report_bug_controller.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:barber_select/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyLinkScreen extends StatelessWidget {
  const MyLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyLinkController());
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
                30.ph,
                Text(
                  "Share".tr,
                  style: AppTextStyles.getPoppins(12.sp, 4.weight),
                ),
                Text(
                  "Link Share".tr,
                  style: AppTextStyles.getPoppins(30.sp, 5.weight),
                ),
                20.ph,

                Container(
                  padding: EdgeInsets.all(12),
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
                      Text(
                        'Share your schedule with your clients.'.tr,
                        style: AppTextStyles.getPoppins(14.sp, 5.weight),
                        textAlign: TextAlign.center,
                      ),
                      5.ph,
                      Text(
                        'Share your link with your clients so that they can schedule services.'
                            .tr,
                        style: AppTextStyles.getPoppins(12.sp, 4.weight),
                      ),
                      5.ph,

                      CustomTextFormField(
                        fieldLabel: '',
                        focusNode: controller.fnMyLink,
                        controller: controller.tecMyLink,
                        borderColor: AppColors.whiteColor,
                        borderRadius: 6,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 15,
                        ),
                        suffixConstraints: BoxConstraints(),
                        suffix: SizedBox(
                          width: 130,

                          child: CustomButtonWidget(
                            borderRadius: 6,
                            height: 40,
                            btnLabel: 'Copy Link'.tr,
                            bgColor: AppColors.primaryColor,
                          ),
                        ),
                        hintText: 'https://chat.fillap.me/?i...',
                      ).paddingSymmetric(vertical: 12),
                      5.ph,
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            VerticalDivider(
                              color: AppColors.textBlackColor.withOpacity(0.5),
                            ),
                            Column(
                              children: [
                                FaIcon(FontAwesomeIcons.whatsapp),
                                Text(
                                  'Whatsapp',
                                  style: AppTextStyles.getPoppins(
                                    12.sp,
                                    5.weight,
                                  ),
                                ),
                              ],
                            ),
                            VerticalDivider(
                              color: AppColors.textBlackColor.withOpacity(0.5),
                            ),
                            Column(
                              children: [
                                FaIcon(FontAwesomeIcons.qrcode),
                                Text(
                                  'QR code',
                                  style: AppTextStyles.getPoppins(
                                    12.sp,
                                    5.weight,
                                  ),
                                ),
                              ],
                            ),
                            VerticalDivider(
                              color: AppColors.textBlackColor.withOpacity(0.5),
                            ),
                            Column(
                              children: [
                                FaIcon(FontAwesomeIcons.facebook),
                                Text(
                                  'Facebook',
                                  style: AppTextStyles.getPoppins(
                                    12.sp,
                                    5.weight,
                                  ),
                                ),
                              ],
                            ),
                            VerticalDivider(
                              color: AppColors.textBlackColor.withOpacity(0.5),
                            ),
                            Column(
                              children: [
                                Icon(Icons.more),
                                Text(
                                  'More'.tr,
                                  style: AppTextStyles.getPoppins(
                                    12.sp,
                                    5.weight,
                                  ),
                                ),
                              ],
                            ),
                            VerticalDivider(
                              color: AppColors.textBlackColor.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),

                      10.ph,
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
