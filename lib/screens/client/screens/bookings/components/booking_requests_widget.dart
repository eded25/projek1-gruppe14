import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/models/appointment_model.dart';
import 'package:barber_select/models/booking_request_model.dart';
import 'package:barber_select/screens/auth/screens/login_screen.dart';
import 'package:barber_select/screens/client/screens/bookings/controller/client_booking_controller.dart';

import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/utils/helperfunctions.dart';
import 'package:barber_select/utils/responsive.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../barber/appointment/screens/appointment_details.dart';

class BookingRequestsWidget extends StatelessWidget {
  const BookingRequestsWidget({super.key, required this.booking});

  final BookingRequest booking;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<CustomDrawerController>();
    final controller = Get.find<ClientBookingController>();
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
      child: Column(
        children: [
          Row(
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
                    booking.barberName,
                    style: AppTextStyles.getPoppins(
                      14.sp,
                      5.weight,
                      themeController.isDarkMode,

                      AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    'Selected Time'.tr,
                    style: AppTextStyles.getPoppins(14.sp, 5.weight),
                  ),
                  Text(
                    booking.selectedTimes.join(', '),
                    style: AppTextStyles.getPoppins(13.sp, 4.weight),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date : ${booking.date}",
                    style: AppTextStyles.getPoppins(12.sp, 5.weight),
                  ),
                  RatingBar.builder(
                    initialRating: booking.barberRating,
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
                  Text(
                    '\$${booking.price.toString()}',
                    style: AppTextStyles.getPoppins(18.sp, 5.weight),
                  ),
                ],
              ),
            ],
          ),
          20.ph,
          SizedBox(
            width: 250.w,
            child: CustomButtonWidget(
              btnLabel: 'View',
              onTap: () {
                print('booking ${booking.toMap()}');

                Get.to(
                  () => AppointmentDetails(appointmentModel: AppointmentModel(id: booking.requestId, clientName: booking.barberName, phoneNumber: '123122' ,
                      startTime: getStartAndEndTime(booking.date,  booking.selectedTimes[0])['startTime']??DateTime.now(), endTime: getStartAndEndTime(booking.date,  booking.selectedTimes[0])['endTime']??DateTime.now(), date: getStartAndEndTime(booking.date,  booking.selectedTimes[0])['startTime']??DateTime.now(), haircuts: booking.services, isRepeat: false),isClientSide: true,),
                  transition: Transition.downToUp,
                );

              },
              height: 45.h,
            ),
          ),
        ],
      ),
    );
  }
}
