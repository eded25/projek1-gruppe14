import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barber_select/screens/client/screens/bookings/controller/client_booking_controller.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientBookingsScreen extends StatelessWidget {
  const ClientBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClientBookingController>();

    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? AppColors.darkScreenBg : AppColors.whiteColor,
      appBar: AppBar(
        title: Text('My Bookings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Refresh bookings - du kannst hier eine Refresh-Methode hinzufügen
              controller.bookingRequests.refresh();
            },
            icon: Icon(
              Icons.refresh,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      body: Obx(() {
        // Loading State (falls du einen haben willst)
        // if (controller.isLoading.value) {
        //   return Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         CircularProgressIndicator(color: AppColors.primaryColor),
        //         20.ph,
        //         Text(
        //           'Loading your bookings...',
        //           style: AppTextStyles.getPoppins(16.sp, 5.weight),
        //         ),
        //       ],
        //     ),
        //   );
        // }

        if (controller.bookingRequests.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 64,
                  color: AppColors.primaryColor.withOpacity(0.5),
                ),
                20.ph,
                Text(
                  'No bookings yet',
                  style: AppTextStyles.getPoppins(18.sp, 6.weight),
                ),
                10.ph,
                Text(
                  'Book your first appointment with a barber!',
                  style: AppTextStyles.getPoppins(14.sp, 4.weight),
                  textAlign: TextAlign.center,
                ),
                30.ph,
                ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Find Barbers',
                    style: AppTextStyles.getPoppins(
                      16.sp,
                      6.weight,
                      Get.isDarkMode.obs,
                      AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            controller.bookingRequests.refresh();
          },
          color: AppColors.primaryColor,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stats Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryColor.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              controller.bookingRequests.length.toString(),
                              style: AppTextStyles.getPoppins(
                                24.sp,
                                7.weight,
                                Get.isDarkMode.obs,
                                AppColors.primaryColor,
                              ),
                            ),
                            Text(
                              'Total',
                              style: AppTextStyles.getPoppins(12.sp, 5.weight),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              controller.bookingRequests.length.toString(),
                              style: AppTextStyles.getPoppins(
                                24.sp,
                                7.weight,
                                Get.isDarkMode.obs,
                                Colors.orange,
                              ),
                            ),
                            Text(
                              'Pending',
                              style: AppTextStyles.getPoppins(12.sp, 5.weight),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '€${_getTotalSpent(controller.bookingRequests).toStringAsFixed(0)}',
                              style: AppTextStyles.getPoppins(
                                24.sp,
                                7.weight,
                                Get.isDarkMode.obs,
                                Colors.green,
                              ),
                            ),
                            Text(
                              'Spent',
                              style: AppTextStyles.getPoppins(12.sp, 5.weight),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                20.ph,

                Text(
                  'Recent Bookings',
                  style: AppTextStyles.getPoppins(18.sp, 6.weight),
                ),

                15.ph,

                // Bookings List
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.bookingRequests.length,
                    itemBuilder: (context, index) {
                      final booking = controller.bookingRequests[index];

                      return Container(
                        margin: EdgeInsets.only(bottom: 16),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? AppColors.darkScreenBg
                              : AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Get.isDarkMode
                                ? AppColors.greyColor
                                : Colors.grey.withOpacity(0.2),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Barber Avatar/Icon
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: AppColors.primaryColor,
                                    size: 24,
                                  ),
                                ),

                                15.pw,

                                // Barber Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        booking.barberName,
                                        style: AppTextStyles.getPoppins(
                                          16.sp,
                                          6.weight,
                                          Get.isDarkMode.obs,
                                          AppColors.primaryColor,
                                        ),
                                      ),
                                      Text(
                                        booking.services.join(', '),
                                        style: AppTextStyles.getPoppins(
                                          12.sp,
                                          4.weight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Price & Rating
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '€${booking.price.toStringAsFixed(0)}',
                                      style: AppTextStyles.getPoppins(
                                        16.sp,
                                        6.weight,
                                        Get.isDarkMode.obs,
                                        Colors.green,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 14,
                                          color: Colors.amber,
                                        ),
                                        Text(
                                          booking.barberRating.toString(),
                                          style: AppTextStyles.getPoppins(
                                            12.sp,
                                            5.weight,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            15.ph,

                            // Date & Time
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: AppColors.primaryColor,
                                ),
                                8.pw,
                                Text(
                                  booking.date,
                                  style:
                                      AppTextStyles.getPoppins(14.sp, 5.weight),
                                ),
                                20.pw,
                                Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: AppColors.primaryColor,
                                ),
                                8.pw,
                                Text(
                                  booking.selectedTimes.isNotEmpty
                                      ? booking.selectedTimes.first
                                      : 'Time TBD',
                                  style:
                                      AppTextStyles.getPoppins(14.sp, 5.weight),
                                ),
                              ],
                            ),

                            12.ph,

                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Get.snackbar(
                                        'Info',
                                        'Booking details for ${booking.barberName}',
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          color: AppColors.primaryColor),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'View',
                                      style: AppTextStyles.getPoppins(
                                        14.sp,
                                        5.weight,
                                        Get.isDarkMode.obs,
                                        AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                10.pw,
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      // Cancel booking
                                      controller.bookingRequests
                                          .removeAt(index);
                                      Get.snackbar(
                                        'Success',
                                        'Booking cancelled successfully',
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'Cancel',
                                      style: AppTextStyles.getPoppins(
                                        14.sp,
                                        5.weight,
                                        Get.isDarkMode.obs,
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  double _getTotalSpent(List bookings) {
    return bookings.fold(0.0, (sum, booking) => sum + booking.price);
  }
}
