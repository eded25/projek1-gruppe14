import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/utils/responsive.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    Color? backgroundColor,
    required this.fieldLabel,
    required this.focusNode,
    this.autofocus = false,
    this.showEditIcon = false,
    this.onEditTap,
    this.onTap,
    this.textStyle,
    this.labelStyle,
    this.maxLength,
    this.obscureText = false,
    this.labelFieldSpace = 3,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.borderRadius = 50,
    this.fillColor,
    this.borderColor = AppColors.primaryColor,
    this.darkBorderColor = AppColors.darkScreenBg,
    this.filled = true,
    this.inputFormatters,
    this.validator,
    this.isViewMode = false,
    this.onChanged,
  }) : backgroundColor =
           backgroundColor ??
           (Get.isDarkMode ? AppColors.darkScreenBg : AppColors.textfieldBg);

  final Alignment? alignment;

  final double? width;

  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  final FocusNode focusNode;
  final void Function()? onEditTap;
  final double labelFieldSpace;

  final bool? autofocus;
  final void Function()? onTap;
  final TextStyle? textStyle;

  final bool? obscureText;
  final bool showEditIcon;
  final String fieldLabel;
  final double? borderRadius;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;
  final int? maxLength;
  final Color borderColor;
  final Color darkBorderColor;

  final String? hintText;

  final TextStyle? hintStyle;
  final TextStyle? labelStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;
  final Color? backgroundColor;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final bool isViewMode;
  List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final themeController = Get.find<CustomDrawerController>();
  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
          alignment: alignment ?? Alignment.center,
          child: textFormFieldWidget(context),
        )
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          fieldLabel == ''
              ? SizedBox()
              : Text(
                fieldLabel,
                style: AppTextStyles.getPoppins(
                  Responsive.isMobile(context) ? 12.sp : 14.sp,
                  4.weight,
                ),
              ),
        ],
      ),
      labelFieldSpace.ph,
      TextFormField(
        readOnly: isViewMode,
        autovalidateMode: AutovalidateMode.disabled,
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        onTap: onTap,
        style:
            textStyle ??
            AppTextStyles.getPoppins(
              Responsive.isMobile(context) ? 14.sp : 16.sp,
              4.weight,
            ),
        obscureText: obscureText!,
        obscuringCharacter: '*',
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        maxLines: maxLines ?? 1,
        cursorColor: AppColors.primaryColor,
        decoration: decoration(context),
        onChanged: onChanged,
        validator: validator,
      ),
    ],
  );

  InputDecoration decoration(context) => InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    floatingLabelAlignment: FloatingLabelAlignment.start,
    hintText: hintText ?? "",

    hintStyle:
        hintStyle ??
        AppTextStyles.getPoppins(
          Responsive.isMobile(context) ? 12.sp : 14.sp,
          4.weight,
          themeController.isDarkMode,

          Get.isDarkMode
              ? AppColors.darkModeTextColor.withOpacity(0.6)
              : AppColors.blackColor.withOpacity(0.6),
        ),
    prefixIcon: prefix,

    prefixIconConstraints: prefixConstraints,

    suffixIcon: suffix,
    suffixIconConstraints: suffixConstraints,
    isDense: true,
    errorStyle: AppTextStyles.getPoppins(
      12.sp,
      4.weight,
      themeController.isDarkMode,

      AppColors.redColor,
    ),

    contentPadding:
        contentPadding ??
        EdgeInsets.only(top: 17, right: 15, bottom: 17, left: 12),
    filled: true,
    fillColor: fillColor ?? backgroundColor,
    // filled: filled,
    // border: InputBorder.none,
    border:
        borderDecoration ??
        OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.textBlackColor.withOpacity(0.3),
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
    enabledBorder:
        borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: BorderSide(
            color: Get.isDarkMode ? darkBorderColor : borderColor,
            width: 1.0,
          ),
        ),
    focusedBorder:
        borderDecoration ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: BorderSide(
            color: Get.isDarkMode ? darkBorderColor : borderColor,
            width: 1.0,
          ),
        ),
  );
}

class CustomDropdownField extends StatelessWidget {
  CustomDropdownField({
    super.key,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    Color? backgroundColor,
    required this.fieldLabel,
    required this.focusNode,
    this.autofocus = false,
    this.showEditIcon = false,
    this.onEditTap,
    this.onTap,
    this.textStyle,
    this.labelStyle,
    this.obscureText = false,
    this.labelFieldSpace = 5,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.borderColor = AppColors.borderColor,
    this.filled = true,
    this.inputFormatters,
    this.validator,
    this.isViewMode = false,
    this.onChanged,
    required this.items,
    required this.selectedItem,
    required this.onChangedDropdown,
  }) : backgroundColor =
           backgroundColor ??
           (Get.isDarkMode ? AppColors.darkScreenBg : AppColors.textfieldBg);

  final Alignment? alignment;

  final double? width;

  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  final FocusNode focusNode;
  final void Function()? onEditTap;
  final double labelFieldSpace;

  final bool? autofocus;
  final void Function()? onTap;
  final TextStyle? textStyle;

  final bool? obscureText;
  final bool showEditIcon;
  final String fieldLabel;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;
  final Color borderColor;

  final String? hintText;

  final TextStyle? hintStyle;
  final TextStyle? labelStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;
  final Color? backgroundColor;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final bool isViewMode;
  List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;

  final RxList<String> items;
  final RxnString selectedItem;
  final void Function(String?) onChangedDropdown;
  final themeController = Get.find<CustomDrawerController>();
  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
          alignment: alignment ?? Alignment.center,
          child: dropdownWidget(context),
        )
        : dropdownWidget(context);
  }

  Widget dropdownWidget(context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(top: 0), // Space for label
        padding: EdgeInsets.symmetric(vertical: 0),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.textfieldBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                Get.isDarkMode ? AppColors.darkScreenBg : AppColors.whiteColor,
            width: 0.5,
          ),
        ),
        child: Obx(
          () => DropdownButton2<String>(
            value: selectedItem.value,
            hint: Text(
              hintText ?? '',
              style: AppTextStyles.getPoppins(
                Responsive.isMobile(context) ? 12.sp : 14.sp,
                4.weight,
                themeController.isDarkMode,

                Get.isDarkMode
                    ? AppColors.darkModeTextColor.withOpacity(0.6)
                    : AppColors.blackColor.withOpacity(0.6),
              ),
            ),
            iconStyleData: IconStyleData(
              icon: Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 30,
                color:
                    Get.isDarkMode
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
              ),
            ),
            underline: SizedBox(),
            items:
                items
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: AppTextStyles.getPoppins(
                            Responsive.isMobile(context) ? 14.sp : 16.sp,
                            4.weight,
                          ),
                        ),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              onChangedDropdown(value); // Update via GetX controller
            },
            isExpanded: true,
          ),
        ),
      ),
    ],
  );
}

class CustomCheckBoxDropdownField extends StatelessWidget {
  CustomCheckBoxDropdownField({
    super.key,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    Color? backgroundColor,

    required this.fieldLabel,
    required this.focusNode,
    this.autofocus = false,
    this.showEditIcon = false,
    this.onEditTap,
    this.onTap,
    this.textStyle,
    this.labelStyle,
    this.obscureText = false,
    this.labelFieldSpace = 5,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.borderColor = AppColors.borderColor,
    this.filled = true,
    this.inputFormatters,
    this.validator,
    this.isViewMode = false,
    this.onChanged,
    required this.items,
    required this.selectedItems,
    required this.onChangedDropdown,
  }) : backgroundColor =
           backgroundColor ??
           (Get.isDarkMode ? AppColors.darkScreenBg : AppColors.textfieldBg);

  final Alignment? alignment;

  final double? width;

  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  final FocusNode focusNode;
  final void Function()? onEditTap;
  final double labelFieldSpace;

  final bool? autofocus;
  final void Function()? onTap;
  final TextStyle? textStyle;

  final bool? obscureText;
  final bool showEditIcon;
  final String fieldLabel;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;
  final Color borderColor;

  final String? hintText;

  final TextStyle? hintStyle;
  final TextStyle? labelStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;
  final Color? backgroundColor;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final bool isViewMode;
  List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;

  final RxList<String> items;
  final RxList<String> selectedItems;
  final void Function(List<String>) onChangedDropdown;
  final themeController = Get.find<CustomDrawerController>();
  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
          alignment: alignment ?? Alignment.center,
          child: dropdownWidget(context),
        )
        : dropdownWidget(context);
  }

  Widget dropdownWidget(context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(top: 0), // Space for label
        padding: EdgeInsets.symmetric(vertical: 0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                Get.isDarkMode ? AppColors.darkScreenBg : AppColors.whiteColor,
            width: 0.5,
          ),
        ),
        child: Obx(
          () => DropdownButton2<String>(
            underline: SizedBox(),
            customButton: Container(
              width: Get.width,
              padding: const EdgeInsets.only(
                left: 12,
                right: 4,
                top: 10,
                bottom: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedItems.isEmpty
                          ? 'Type of Hair cuts'
                          : selectedItems.join(', '),
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.getPoppins(
                        12.sp,
                        4.weight,
                        themeController.isDarkMode,

                        Get.isDarkMode
                            ? AppColors.darkModeTextColor.withOpacity(0.6)
                            : selectedItems.isEmpty
                            ? AppColors.blackColor.withOpacity(0.6)
                            : AppColors.blackColor,
                      ),
                    ),
                  ),
                  20.pw,
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color:
                        Get.isDarkMode
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                    size: 30,
                  ),
                ],
              ),
            ),
            isExpanded: true,
            isDense: true,
            iconStyleData: IconStyleData(
              icon: Icon(Icons.keyboard_arrow_down_sharp),
            ),
            items:
                items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    enabled: false,
                    child: Obx(
                      () => CheckboxListTile(
                        title: Text(
                          item,
                          style: AppTextStyles.getPoppins(12.sp, 4.weight),
                        ),

                        value: selectedItems.contains(item),
                        onChanged: (checked) {
                          if (checked == true) {
                            selectedItems.add(item);
                          } else {
                            selectedItems.remove(item);
                          }
                          onChangedDropdown(selectedItems);
                        },
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => BorderSide(
                            width: 1.0,
                            color: AppColors.blackColor,
                          ),
                        ),
                        activeColor: Colors.white,
                        checkColor: AppColors.blackColor,
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  );
                }).toList(),
            onChanged: (_) {}, // Needed but not used since we use checkboxes
          ),
        ),
      ),
    ],
  );
}
