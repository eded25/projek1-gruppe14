import 'package:get/get.dart';
import 'package:barber_select/models/booking_model.dart';
import 'package:barber_select/services/api_service.dart';

class BookingsController extends GetxController {
  RxList<BookingModel> bookings = <BookingModel>[].obs;
  RxBool isLoadingBookings = false.obs;
  RxString currentClientId = '1'.obs; // Setze deine echte Client ID hier

  @override
  void onInit() {
    super.onInit();
    loadClientBookings();
  }

  // Client ID setzen (z.B. nach Login)
  void setClientId(String clientId) {
    currentClientId.value = clientId;
    loadClientBookings();
  }

  Future<void> loadClientBookings() async {
    isLoadingBookings.value = true;
    print('📱 Lade Buchungen für Client: ${currentClientId.value}');

    try {
      // Verwende deine bestehende API-Methode
      final bookingsData =
          await ApiService.getClientBookings(currentClientId.value);
      print('📱 Erhaltene Buchungen: ${bookingsData.length}');

      if (bookingsData.isNotEmpty) {
        final loadedBookings = bookingsData.map<BookingModel>((booking) {
          print('📱 Verarbeite Buchung: $booking');
          return BookingModel.fromJson(booking);
        }).toList();

        bookings.assignAll(loadedBookings);
        print('✅ ${bookings.length} Buchungen geladen');
      } else {
        print('📱 Keine Buchungen gefunden');
        bookings.clear();
      }
    } catch (e) {
      print('❌ Fehler beim Laden der Buchungen: $e');
      bookings.clear();
    } finally {
      isLoadingBookings.value = false;
    }
  }

  // Aktualisierung der Buchungen
  Future<void> refreshBookings() async {
    await loadClientBookings();
  }

  // Buchung stornieren mit deiner API
  Future<bool> cancelBooking(String bookingId) async {
    try {
      final result = await ApiService.cancelReservation(int.parse(bookingId));
      if (result['status'] == 'success') {
        await refreshBookings();
        return true;
      }
      return false;
    } catch (e) {
      print('Fehler beim Stornieren: $e');
      return false;
    }
  }

  // Statistiken
  int get totalBookings => bookings.length;
  int get pendingBookings =>
      bookings.where((b) => b.status.toLowerCase() == 'pending').length;
  int get confirmedBookings =>
      bookings.where((b) => b.status.toLowerCase() == 'approved').length;
  double get totalSpent =>
      bookings.fold(0.0, (sum, booking) => sum + booking.price);
}
