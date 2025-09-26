import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/utils/responsive.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  String btnLabel = "";

  final double borderRadius;
  final double height;
  final TextStyle? btnLabelStyle;
  final bool isGradientBg;
  final bool isWhiteBg;
  final Color bgColor;
  final Color? borderColor;
  final bool isBtnDisabled;
  final bool isIcon;
  final String? icon;
  CustomButtonWidget({
    required this.btnLabel,
    this.onTap,
    this.isIcon = false,
    this.borderRadius = 50.0,
    this.icon,
    this.height = 50.0,
    this.isWhiteBg = false,
    Color? bgColor,
    this.isBtnDisabled = false,
    this.btnLabelStyle,
    this.isGradientBg = false,
    this.borderColor = AppColors.primaryColor,
    super.key,
  }) : bgColor =
           bgColor ??
           (Get.isDarkMode
               ? AppColors.darkPrimaryColor
               : AppColors.primaryColor);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<CustomDrawerController>();
    return Container(
      width: Get.width,
      height: height.h,
      margin: EdgeInsets.only(left: 0, right: 0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color:
            isWhiteBg
                ? AppColors.whiteColor
                : isGradientBg
                ? null
                : isBtnDisabled
                ? AppColors.primaryColor.withOpacity(0.6)
                : bgColor,
        // gradient: isGradientBg ? AppTheme.gradientColor : null,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: AppColors.blackColor.withOpacity(0.1),
          ),
        ],
        border: Border.all(
          color: isWhiteBg ? borderColor! : Colors.transparent,
        ),
      ),
      child: ElevatedButton(
        style: const ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.zero),
          elevation: WidgetStatePropertyAll(0),
          backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        ),
        onPressed: onTap,
        child:
            isIcon!
                ? SvgPicture.asset(icon!, color: AppColors.whiteColor)
                : Text(
                  btnLabel.tr,
                  style:
                      btnLabelStyle ??
                      AppTextStyles.getPoppins(
                        Responsive.isMobile(context) ? 14.sp : 20.sp,
                        7.weight,
                        themeController.isDarkMode,

                        AppColors.whiteColor,
                      ),
                ),
      ),
    );
  }
}
