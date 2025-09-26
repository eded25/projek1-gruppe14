import 'package:animate_do/animate_do.dart';
import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/models/booking_request_model.dart';
import 'package:barber_select/screens/client/screens/bookings/components/booking_requests_widget.dart';
import 'package:barber_select/screens/client/screens/bookings/controller/client_booking_controller.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:barber_select/services/api_service.dart';

class ClientBookingsScreen extends StatelessWidget {
  const ClientBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClientBookingController>();

    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Get.isDarkMode ? AppColors.darkScreenBg : AppColors.whiteColor,
        body: Column(
          children: [
            // Header mit Hintergrundbild
            Stack(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.barberImage2),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  height: Get.height * 0.25,
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
                      Row(
                        children: [
                          SlideInRight(
                            child: InkWell(
                              onTap: () => Get.back(),
                              child: Icon(
                                Icons.arrow_back,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          Spacer(),
                          SlideInLeft(
                            child: InkWell(
                              onTap: () => controller
                                  .refreshBookings(), // Verwende Controller-Methode
                              child: Icon(
                                Icons.refresh,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      30.ph,
                      SlideInUp(
                        child: Text(
                          'Meine Buchungen',
                          style: AppTextStyles.getPoppins(
                            24.sp,
                            7.weight,
                            Get.isDarkMode.obs,
                            AppColors.primaryColor,
                          ),
                        ),
                      ),
                      5.ph,
                      SlideInUp(
                        delay: Duration(milliseconds: 200),
                        child: Text(
                          'Alle deine Termine im Überblick',
                          style: AppTextStyles.getPoppins(
                            14.sp,
                            4.weight,
                            Get.isDarkMode.obs,
                            AppColors.textBlackColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Stats Card
            SlideInUp(
              delay: Duration(milliseconds: 400),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primaryColor.withOpacity(0.2),
                  ),
                ),
                child: Obx(() => Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                controller.bookingRequests.length.toString(),
                                style: AppTextStyles.getPoppins(
                                  20.sp,
                                  7.weight,
                                  Get.isDarkMode.obs,
                                  AppColors.primaryColor,
                                ),
                              ),
                              Text(
                                'Gesamt',
                                style:
                                    AppTextStyles.getPoppins(12.sp, 5.weight),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                _getPendingCount(controller.bookingRequests)
                                    .toString(),
                                style: AppTextStyles.getPoppins(
                                  20.sp,
                                  7.weight,
                                  Get.isDarkMode.obs,
                                  Colors.orange,
                                ),
                              ),
                              Text(
                                'Ausstehend',
                                style:
                                    AppTextStyles.getPoppins(12.sp, 5.weight),
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
                                  20.sp,
                                  7.weight,
                                  Get.isDarkMode.obs,
                                  Colors.green,
                                ),
                              ),
                              Text(
                                'Ausgegeben',
                                style:
                                    AppTextStyles.getPoppins(12.sp, 5.weight),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),

            // Buchungen Liste
            Expanded(
              child: SlideInUp(
                delay: Duration(milliseconds: 600),
                child: Obx(() {
                  if (controller.bookingRequests.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 64,
                          color: AppColors.primaryColor.withOpacity(0.5),
                        ),
                        20.ph,
                        Text(
                          'Noch keine Buchungen',
                          style: AppTextStyles.getPoppins(18.sp, 6.weight),
                        ),
                        10.ph,
                        Text(
                          'Buche deinen ersten Termin bei einem Barbier!',
                          style: AppTextStyles.getPoppins(14.sp, 4.weight),
                          textAlign: TextAlign.center,
                        ),
                        30.ph,
                        ElevatedButton(
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Barbier finden',
                            style: AppTextStyles.getPoppins(
                              16.sp,
                              6.weight,
                              false.obs,
                              AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  // Sortiere Buchungen nach Datum (neueste zuerst)
                  final sortedRequests = List<BookingRequest>.from(
                    controller.bookingRequests,
                  )..sort((a, b) {
                      try {
                        final aDate = DateFormat('dd/MM/yyyy').parse(a.date);
                        final bDate = DateFormat('dd/MM/yyyy').parse(b.date);
                        return bDate.compareTo(aDate);
                      } catch (e) {
                        return 0;
                      }
                    });

                  return RefreshIndicator(
                    onRefresh: () => _loadBookingsFromDatabase(controller),
                    color: AppColors.primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Aktuelle Buchungen',
                            style: AppTextStyles.getPoppins(16.sp, 6.weight),
                          ),
                          10.ph,
                          Expanded(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: sortedRequests.length,
                              itemBuilder: (context, index) {
                                final booking = sortedRequests[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7.0),
                                  child:
                                      BookingRequestsWidget(booking: booking),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Lade Buchungen aus der Datenbank und synchronisiere mit lokalem Controller
  Future<void> _loadBookingsFromDatabase(
      ClientBookingController controller) async {
    try {
      // TODO: Hier deine echte User-ID verwenden
      const userId = '1'; // Ersetze mit der echten eingeloggten User-ID

      final reservations = await ApiService.listReservationsForUser(
        userId: int.parse(userId),
      );

      print('📱 Geladene Reservierungen: ${reservations.length}');

      // Konvertiere API-Daten in BookingRequest Format
      final bookingRequests = <BookingRequest>[];

      for (var reservation in reservations) {
        try {
          // Konvertiere API-Reservation in dein BookingRequest Format
          final booking = BookingRequest(
            requestId: reservation['id']?.toString() ?? '',
            barberName: reservation['barber_name'] ?? 'Unbekannt',
            selectedTimes: [reservation['appointment_time'] ?? '10:00'],
            services: [reservation['services'] ?? 'Cut'],
            barberRating: 4.5, // Default rating
            price: double.tryParse(
                    reservation['total_price']?.toString() ?? '0') ??
                0.0,
            date: _formatDate(reservation['appointment_date'] ?? ''),
          );

          bookingRequests.add(booking);
        } catch (e) {
          print('Fehler beim Konvertieren der Reservation: $e');
        }
      }

      // Aktualisiere den Controller
      controller.bookingRequests.assignAll(bookingRequests);

      Get.snackbar(
        'Aktualisiert',
        '${bookingRequests.length} Buchungen geladen',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Fehler beim Laden der Buchungen: $e');
      Get.snackbar(
        'Fehler',
        'Buchungen konnten nicht geladen werden',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Hilfsfunktionen
  String _formatDate(String dbDate) {
    try {
      // Konvertiere '2025-09-30' zu '30/09/2025'
      final date = DateTime.parse(dbDate);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dbDate;
    }
  }

  int _getPendingCount(List<BookingRequest> bookings) {
    // In deinem System könntest du einen Status hinzufügen
    return bookings.length; // Vorerst alle als pending behandeln
  }

  double _getTotalSpent(List<BookingRequest> bookings) {
    return bookings.fold(0.0, (sum, booking) => sum + booking.price);
  }
}
