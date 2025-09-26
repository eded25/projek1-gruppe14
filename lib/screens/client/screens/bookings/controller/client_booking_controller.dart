import 'package:barber_select/models/booking_request_model.dart';
import 'package:barber_select/services/prefs.dart';
import 'package:barber_select/services/api_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
    super.onInit();
    await loadAllBookings();
  }

  Future<void> loadAllBookings() async {
    try {
      // 1. Lade lokale gespeicherte Buchungen
      List<BookingRequest> localBookings = await Prefs.loadClientBookings();

      // 2. Lade auch Buchungen aus der Datenbank
      try {
        final dbBookings = await _loadFromDatabase();

        // 3. Kombiniere lokale und Datenbank-Buchungen (ohne Duplikate)
        final allBookings = <BookingRequest>[];
        allBookings.addAll(localBookings);

        for (var dbBooking in dbBookings) {
          // Füge nur hinzu wenn nicht bereits in lokalen Buchungen
          if (!allBookings
              .any((local) => local.requestId == dbBooking.requestId)) {
            allBookings.add(dbBooking);
          }
        }

        localBookings = allBookings;
      } catch (e) {
        print('Datenbank-Buchungen konnten nicht geladen werden: $e');
      }

      // 4. Filtere nur aktuelle/zukünftige Termine
      List<BookingRequest> currentBookings = localBookings.where((booking) {
        try {
          DateTime bookingDate = DateFormat('dd/MM/yyyy').parse(booking.date);
          return bookingDate
              .isAfter(DateTime.now().subtract(Duration(days: 1)));
        } catch (e) {
          return true; // Bei Parsing-Fehler behalten
        }
      }).toList();

      // 5. Aktualisiere die Liste
      bookingRequests.assignAll(currentBookings);

      // 6. Speichere die kombinierte und gefilterte Liste
      await Prefs.saveClientBookings(currentBookings);
    } catch (e) {
      print('Fehler beim Laden der Buchungen: $e');
    }
  }

  Future<List<BookingRequest>> _loadFromDatabase() async {
    const userId = '1'; // TODO: Echte User-ID verwenden

    final reservations = await ApiService.listReservationsForUser(
      userId: int.parse(userId),
    );

    final bookingRequests = <BookingRequest>[];

    for (var reservation in reservations) {
      try {
        final booking = BookingRequest(
          requestId: reservation['id']?.toString() ?? '',
          barberName: reservation['barber_name'] ?? 'Unbekannt',
          selectedTimes: [reservation['appointment_time'] ?? '10:00'],
          services: [reservation['services'] ?? 'Cut'],
          barberRating: 4.5,
          price:
              double.tryParse(reservation['total_price']?.toString() ?? '0') ??
                  0.0,
          date: _formatDate(reservation['appointment_date'] ?? ''),
        );
        bookingRequests.add(booking);
      } catch (e) {
        print('Fehler beim Konvertieren der Reservation: $e');
      }
    }

    return bookingRequests;
  }

  String _formatDate(String dbDate) {
    try {
      final date = DateTime.parse(dbDate);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dbDate;
    }
  }

  Future<void> refreshBookings() async {
    await loadAllBookings();
  }
}
