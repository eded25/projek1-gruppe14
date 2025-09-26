import 'package:barber_select/screens/barber/revenue/components/completed_services.dart';
import 'package:barber_select/screens/barber/revenue/components/month_container.dart';
import 'package:barber_select/screens/barber/revenue/controller/revenue_controller.dart';
import 'package:barber_select/screens/barber/revenue/screens/payment_details.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/utils/responsive.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RevenueScreen extends StatelessWidget {
  const RevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RevenueController());
    final themeController = Get.find<CustomDrawerController>();
    final barData = [
      0,
      2,
      8,
      5,
      6,
      4,
      4,
      4,
      4,
      0.5,
      2,
      4,
      4,
      4,
      4,
      4,
      4,
      4,
      0.5,
      2,
      4,
      4,
      4,
      4,
      4,
      4,
      4,
      6,
      7,
      2,
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Get.isDarkMode ? AppColors.darkScreenBg : AppColors.whiteColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.ph,
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back, color: AppColors.primaryColor),
                ),
                40.ph,
                Text(
                  "Analyze".tr,
                  style: AppTextStyles.getPoppins(14.sp, 5.weight),
                ),
                Text(
                  "Billing".tr,
                  style: AppTextStyles.getPoppins(28.sp, 6.weight),
                ),
                40.ph,
                Row(
                  children: [
                    MonthContainer(text: 'JAN'),
                    10.pw,
                    MonthContainer(text: 'FEB'),
                  ],
                ),
                20.ph,
                Text(
                  'Services Balance'.tr,
                  style: AppTextStyles.getPoppins(14.sp, 4.weight),
                ),
                10.ph,
                Text(
                  '\$ 25.00',
                  style: AppTextStyles.getPoppins(24.sp, 5.weight),
                ),
                5.ph,
                Row(
                  children: [
                    Text(
                      "(commission) 50% gross salary:".tr,
                      style: AppTextStyles.getPoppins(14.sp, 4.weight),
                    ),
                    Text(
                      " \$ 50,00",
                      style: AppTextStyles.getPoppins(14.sp, 4.weight),
                    ),
                  ],
                ),
                3.ph,
                Text(
                  "1 Service".tr,
                  style: AppTextStyles.getPoppins(14.sp, 4.weight),
                ),

                //Chart bar
                20.ph,

                SizedBox(
                  height: 200.h,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width:
                          barData.length *
                          70.w, // 32 pixels per bar (adjust as needed)
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY:
                              8, // Make sure this accommodates your max value (7+)
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final index = value.toInt();
                                  if (index >= 0 && index < barData.length) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        (index + 1).toString().padLeft(2, '0'),
                                        style: AppTextStyles.getPoppins(
                                          13.sp,
                                          6.weight,
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                                reservedSize: 32,
                              ),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          barGroups: List.generate(barData.length, (index) {
                            final value = barData[index];
                            final isZero = value == 0;

                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY:
                                      (isZero)
                                          ? 9
                                          : double.parse(
                                            value.toString(),
                                          ), // Minimal visible height for black line
                                  width: isZero ? 1.w : 25.w,
                                  borderRadius: BorderRadius.circular(6),
                                  color:
                                      isZero
                                          ? Get.isDarkMode
                                              ? AppColors.whiteColor
                                              : Colors.black
                                          : null,
                                  gradient:
                                      isZero
                                          ? null
                                          : const LinearGradient(
                                            colors: [
                                              Color(0xFFDAA520),
                                              Color(0xFFFFE082),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
                20.ph,
                Row(
                  children: [
                    Icon(
                      Icons.arrow_right_alt_sharp,
                      color:
                          Get.isDarkMode
                              ? AppColors.darkModeTextColor
                              : AppColors.blackColor,
                      size: 30,
                    ),
                    Spacer(),
                    Text(
                      'Swipe to see more'.tr,
                      style: AppTextStyles.getPoppins(12.sp, 4.weight),
                    ),
                  ],
                ),
                20.ph,
                Text(
                  'Completed Service'.tr,
                  style: AppTextStyles.getPoppins(14.sp, 4.weight),
                ),
                10.ph,
                SizedBox(
                  height: 118.h,
                  child: ListView.builder(
                    itemCount: 5,
                    physics: BouncingScrollPhysics(),

                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final service = controller.services[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 15.0),

                        child: CompletedServices(service: service),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_right_alt_sharp,
                      color:
                          Get.isDarkMode
                              ? AppColors.darkModeTextColor
                              : AppColors.blackColor,
                      size: 30,
                    ),
                    Spacer(),
                    Text(
                      'Swipe to see more'.tr,
                      style: AppTextStyles.getPoppins(12.sp, 4.weight),
                    ),
                  ],
                ),
                20.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        width: Responsive.isMobile(context) ? Get.width : 300.w,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color:
                              Get.isDarkMode
                                  ? AppColors.darkPrimaryColor
                                  : AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blackColor.withOpacity(0.2),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$ 25',
                              style: AppTextStyles.getPoppins(34.sp, 6.weight),
                            ),
                            10.ph,
                            Text(
                              "Average Ticket".tr,
                              style: AppTextStyles.getPoppins(12.sp, 4.weight),
                            ),
                          ],
                        ),
                      ),
                    ),
                    30.pw,
                    Flexible(
                      child: Container(
                        width: Responsive.isMobile(context) ? Get.width : 300.w,

                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color:
                              Get.isDarkMode
                                  ? AppColors.darkPrimaryColor
                                  : AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blackColor.withOpacity(0.2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '2 %',
                              style: AppTextStyles.getPoppins(34.sp, 6.weight),
                            ),
                            10.ph,
                            Text(
                              "Occupancy Rate".tr,
                              style: AppTextStyles.getPoppins(12.sp, 4.weight),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                10.ph,
                Text(
                  "Payments".tr,
                  style: AppTextStyles.getPoppins(14.sp, 4.weight),
                ),
                10.ph,
                ListView.builder(
                  itemCount: 4,

                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 2,
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => PaymentDetails());
                        },
                        child: Container(
                          width: Get.width,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:
                                Get.isDarkMode
                                    ? AppColors.darkBgThree
                                    : AppColors.screenBg,
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
                              Text(
                                'Debit'.tr,
                                style: AppTextStyles.getPoppins(
                                  14.sp,
                                  4.weight,
                                  themeController.isDarkMode,
                                  AppColors.primaryColor,
                                ),
                              ),
                              15.ph,
                              Row(
                                children: [
                                  Text(
                                    "\$ 100",
                                    style: AppTextStyles.getPoppins(
                                      30.sp,
                                      6.weight,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "See more".tr,
                                    style: AppTextStyles.getPoppins(
                                      16.sp,
                                      5.weight,
                                      themeController.isDarkMode,

                                      AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                10.ph,
                Text(
                  "More Dados".tr,
                  style: AppTextStyles.getPoppins(14.sp, 4.weight),
                ),
                5.ph,
                RowInfo(title: 'AVAILABLE HOURS', value: '20 hrs'),
                RowInfo(title: 'WORKED HOURS', value: '2 hrs'),
                RowInfo(title: 'IDLE TIME', value: '40 hrs'),
                RowInfo(title: 'FULLY BOOKED', value: '0 hrs'),
                20.ph,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RowInfo extends StatelessWidget {
  const RowInfo({super.key, required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(title.tr, style: AppTextStyles.getPoppins(15.sp, 4.weight)),
            Spacer(),
            Text(value, style: AppTextStyles.getPoppins(14.sp, 4.weight)),
          ],
        ),
        2.ph,
        Divider(
          color:
              Get.isDarkMode
                  ? AppColors.whiteColor.withOpacity(0.5)
                  : AppColors.blackColor.withOpacity(0.5),
          thickness: 0.4,
        ),
      ],
    );
  }
}
