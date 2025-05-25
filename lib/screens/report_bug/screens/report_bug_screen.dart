import 'package:barber_select/screens/report_bug/controller/report_bug_controller.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:barber_select/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReportBugScreen extends StatelessWidget {
  const ReportBugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportBugController());
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
                  "App Failure".tr,
                  style: AppTextStyles.getPoppins(30.sp, 5.weight),
                ),
                20.ph,

                Container(
                  padding: EdgeInsets.all(10),
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
                        'Please inform our team about any langauge or technical issue you encounter in this app:'
                            .tr,
                        style: AppTextStyles.getPoppins(14.sp, 5.weight),
                      ),
                      10.ph,
                      CustomTextFormField(
                        fieldLabel: '',
                        focusNode: controller.fnReportBug,
                        controller: controller.tecReportBug,
                        borderColor: AppColors.whiteColor,
                        borderRadius: 6,
                        hintText: 'Technical description...'.tr,
                        maxLines: 8,
                        maxLength: 500,
                      ),
                      10.ph,
                      Text(
                        'OBS: Your email, name, and establishment information will be automatically sent to thmCUT.'
                            .tr,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.getPoppins(12.sp, 4.weight),
                      ),
                      10.ph,
                      SizedBox(
                        width: 300.w,
                        child: CustomButtonWidget(
                          btnLabel: "SEND".tr,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  alignment: Alignment.bottomCenter,
                                  insetPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    width: Get.width,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color:
                                          Get.isDarkMode
                                              ? AppColors.darkBgThree
                                              : AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: AppColors.primaryColor,
                                        ),
                                        Text(
                                          "Message Sent".tr,
                                          style: AppTextStyles.getPoppins(
                                            16.sp,
                                            6.weight,
                                          ),
                                        ),
                                        Text(
                                          "Your report on the issue has been successfully submitted. Thank you!"
                                              .tr,
                                          textAlign: TextAlign.center,
                                          style: AppTextStyles.getPoppins(
                                            14.sp,
                                            4.weight,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
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
