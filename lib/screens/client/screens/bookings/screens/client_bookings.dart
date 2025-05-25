import 'package:animate_do/animate_do.dart';
import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/models/booking_request_model.dart';
import 'package:barber_select/models/user_model.dart';
import 'package:barber_select/screens/client/screens/bookings/components/booking_requests_widget.dart';
import 'package:barber_select/screens/client/screens/bookings/controller/client_booking_controller.dart';
import 'package:barber_select/screens/client/screens/find_barbers/components/find_barbers_tile.dart';
import 'package:barber_select/screens/client/screens/find_barbers/controller/find_barber_controller.dart';
import 'package:barber_select/screens/client/screens/find_barbers/screens/barber_details_screen.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ClientBookingsScreen extends StatelessWidget {
  const ClientBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClientBookingController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Get.isDarkMode ? AppColors.darkBgThree : AppColors.whiteColor,
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.barberImage2),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  height: Get.height * 0.3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, AppColors.whiteColor],
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
                      SlideInRight(
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      20.ph,

                      SlideInUp(
                        duration: const Duration(milliseconds: 600),
                        child: Obx(() {
                          if (controller.bookingRequests.isEmpty) {
                            return Column(
                              children: [
                                200.ph,

                                Center(
                                  child: Text(
                                    'No Booking Request Yet!',
                                    style: AppTextStyles.getPoppins(
                                      14.sp,
                                      5.weight,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),

                            itemCount: controller.bookingRequests.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final sortedRequests = List<BookingRequest>.from(
                                controller.bookingRequests,
                              )..sort((a, b) {
                                final aDate = DateFormat(
                                  'dd/MM/yyyy',
                                ).parse(a.date);
                                final bDate = DateFormat(
                                  'dd/MM/yyyy',
                                ).parse(b.date);
                                return bDate.compareTo(aDate);
                              });
                              final barbers = sortedRequests[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 7.0,
                                ),
                                child: BookingRequestsWidget(booking: barbers),
                              );
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
