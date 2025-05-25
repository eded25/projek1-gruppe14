
import 'package:barber_select/screens/client/screens/find_barbers/controller/find_barber_controller.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ServiceRegistrationTile extends StatelessWidget {
  const ServiceRegistrationTile({
    super.key,
    required this.title,
    this.onTap,
    required this.isOn,
  });

  final String title;
  final void Function()? onTap;
  final RxBool isOn;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FindBarberController>();

    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(title, style: AppTextStyles.getPoppins(14.sp, 5.weight)),
          Spacer(),
          SwitchWidget(controller: controller, onTap: onTap, isOn: isOn),
        ],
      ),
    );
  }
}

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({
    super.key,
    required this.controller,
    required this.onTap,
    required this.isOn,
  });

  final void Function()? onTap;
  final GetxController controller;
  final RxBool isOn;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: 50,
          height: 30,
          padding: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isOn.value ? AppColors.primaryColor : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(20),
          ),
          child: AnimatedAlign(
            duration: Duration(milliseconds: 300),
            alignment:
                isOn.value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color:
                    isOn.value
                        ? AppColors.whiteColor
                        : AppColors.textBlackColor.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}