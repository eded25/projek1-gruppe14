import 'package:barber_select/models/booking_request_model.dart';
import 'package:barber_select/services/prefs.dart';
import 'package:get/get.dart';

class ClientBookingController extends GetxController {
  RxList<BookingRequest> bookingRequests = <BookingRequest>[].obs;
  Future<void> saveBooking(BookingRequest bookingRequest) async {
    try {
      bookingRequests.add(bookingRequest);
      await Prefs.saveClientBookings(bookingRequests);
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeBooking(String id) async {
    bookingRequests.removeWhere((element) => element.requestId == id);
    await Prefs.saveClientBookings(bookingRequests);
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    List<BookingRequest> loaded = await Prefs.loadClientBookings();

    bookingRequests.assignAll(loaded);
  }
}
