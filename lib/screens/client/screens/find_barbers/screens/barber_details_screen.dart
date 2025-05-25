import 'package:barber_select/models/user_model.dart';
import 'package:barber_select/screens/client/screens/find_barbers/components/registration_tab.dart';
import 'package:barber_select/screens/client/screens/find_barbers/controller/find_barber_controller.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/utils/responsive.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../generated/assets.dart';

class BarberDetailsScreen extends StatelessWidget {
  const BarberDetailsScreen({super.key, required this.barber});
  final UserModel barber;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FindBarberController());
    final themeController = Get.find<CustomDrawerController>();
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                width: Get.width,
                height: Get.height * 0.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.barberImage2),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: Get.width,
                height: Get.height * 0.2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppColors.primaryColor.withOpacity(0.4),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.ph,
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    25.ph,
                    Text(
                      barber.name,
                      style: AppTextStyles.getPoppins(
                        18.sp,
                        6.weight,
                        themeController.isDarkMode,

                        AppColors.primaryColor,
                      ),
                    ),
                    Text(
                      "Barber".tr,
                      style: AppTextStyles.getPoppins(
                        16.sp,
                        6.weight,
                        themeController.isDarkMode,

                        AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                top:
                    Responsive.isMobile(context)
                        ? 130.h
                        : Responsive.isDesktop(context)
                        ? 155.h
                        : 140.h,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),

                  decoration: BoxDecoration(
                    color:
                        Get.isDarkMode
                            ? AppColors.darkBgThree
                            : AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    children: [
                      10.ph,
                      TabBar(
                        padding: EdgeInsets.zero,
                        isScrollable: false,
                        labelPadding: EdgeInsets.zero,
                        labelColor:
                            Get.isDarkMode
                                ? AppColors.whiteColor
                                : AppColors.textBlackColor.withOpacity(0.7),
                        unselectedLabelColor:
                            Get.isDarkMode
                                ? AppColors.whiteColor
                                : AppColors.textBlackColor.withOpacity(0.7),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: AppColors.primaryColor,
                        labelStyle: AppTextStyles.getPoppins(16.sp, 5.weight),
                        tabs: [
                          Tab(text: "Registration".tr),
                          Tab(text: "Portfolio".tr),
                          Tab(text: "Review".tr),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            // Registration Tab
                            RegistrationTab(user: barber),

                            // Services Tab
                            GridView.count(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              physics:
                                  BouncingScrollPhysics(), // or ScrollPhysics()
                              padding: EdgeInsets.symmetric(vertical: 15),
                              children: List.generate(
                                controller.imageList.length,
                                (index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          controller.imageList[index],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            // Reviews Tab
                            ListView.builder(
                              itemCount: controller.reviews.length,
                              shrinkWrap: true,

                              // physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final review = controller.reviews[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 2,
                                  ),
                                  child: Container(
                                    width: Get.width,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color:
                                          Get.isDarkMode
                                              ? AppColors.darkBgThree
                                              : AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color:
                                            Get.isDarkMode
                                                ? AppColors.darkScreenBg
                                                : Colors.transparent,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,

                                          color: AppColors.blackColor
                                              .withOpacity(0.1),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              review.name,
                                              style: AppTextStyles.getPoppins(
                                                14.sp,
                                                4.weight,
                                                themeController.isDarkMode,

                                                AppColors.primaryColor,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              review.time,
                                              style: AppTextStyles.getPoppins(
                                                10.sp,
                                                4.weight,
                                              ),
                                            ),
                                          ],
                                        ),
                                        RatingBar.builder(
                                          initialRating: review.rating,
                                          minRating: 1,
                                          ignoreGestures: true,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemSize: 12,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                            horizontal: 1.0,
                                          ),
                                          itemBuilder:
                                              (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        5.ph,
                                        Text(
                                          review.desc,
                                          style: AppTextStyles.getPoppins(
                                            10.sp,
                                            5.weight,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ).paddingSymmetric(horizontal: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
