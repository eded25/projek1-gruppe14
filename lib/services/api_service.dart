import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // ---- BASE ---------------------------------------------------------------
  static String getBaseUrl() {
    return "http://localhost:8888/Backend";
    // if (Platform.isAndroid) return "http://10.0.2.2:8888/Backend";
    // if (Platform.isIOS)     return "http://localhost:8888/Backend";
    // return "http://192.168.2.198:8888/Backend";
  }

  static void debugPrint(String message) => print("[ApiService] $message");

  static Future<Map<String, dynamic>> _postRequest(
    String endpoint,
    Map<String, String> data,
  ) async {
    try {
      debugPrint("POST ${getBaseUrl()}/$endpoint  data=$data");
      final r = await http
          .post(
            Uri.parse("${getBaseUrl()}/$endpoint"),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: data,
          )
          .timeout(const Duration(seconds: 10));
      debugPrint("STATUS ${r.statusCode}  BODY ${r.body}");
      if (r.statusCode == 200) return jsonDecode(r.body);
      return {'status': 'error', 'message': 'Server-Fehler: ${r.statusCode}'};
    } catch (e) {
      return {'status': 'error', 'message': 'Verbindungsfehler: $e'};
    }
  }

  // ---- AUTH ---------------------------------------------------------------
  static Future<Map<String, dynamic>> registerUser({
    required String email,
    required String password,
    required String phone,
    String name = '',
  }) async =>
      _postRequest('register.php', {
        'email': email,
        'password': password,
        'phone': phone,
        'name': name,
      });

  static Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async =>
      _postRequest('login.php', {
        'email': email,
        'password': password,
      });

  static Future<Map<String, dynamic>> updateProfile({
    required String name,
    required String phone,
    String? email,
  }) async =>
      _postRequest('update_profile.php', {
        'name': name,
        'phone': phone,
        if (email != null) 'email': email,
      });

  static Future<bool> testConnection() async {
    try {
      final r = await http
          .get(Uri.parse("${getBaseUrl()}/register.php"))
          .timeout(const Duration(seconds: 5));
      return r.statusCode == 200 || r.statusCode == 405;
    } catch (_) {
      return false;
    }
  }

  // ---- USER PROFILE -------------------------------------------------------
  static Future<Map<String, dynamic>> getUserProfile({
    required int userId,
  }) async {
    try {
      debugPrint("GET User Profile for ID: $userId");

      final r = await http
          .get(
            Uri.parse("${getBaseUrl()}/get_user.php?user_id=$userId"),
          )
          .timeout(const Duration(seconds: 10));

      debugPrint("User Profile STATUS: ${r.statusCode}");
      debugPrint("User Profile BODY: ${r.body}");

      if (r.statusCode == 200) {
        return jsonDecode(r.body);
      }
      return {'status': 'error', 'message': 'Server-Fehler: ${r.statusCode}'};
    } catch (e) {
      debugPrint("User Profile Error: $e");
      return {'status': 'error', 'message': 'Verbindungsfehler: $e'};
    }
  }

  // ---- RESERVATIONS (passt zu deinen PHP-Dateien) -------------------------

  /// A) Reservation anlegen (Backend erwartet `user_id`, `slot_id`, optional `payment_method`)
  static Future<Map<String, dynamic>> createReservation({
    required int userId,
    required int slotId,
    String paymentMethod = '',
  }) async =>
      _postRequest('create_reservation.php', {
        'user_id': '$userId',
        'slot_id': '$slotId',
        'payment_method': paymentMethod,
      });

  /// B) Liste für einen Nutzer (Client)
  static Future<List<dynamic>> listReservationsForUser({
    required int userId,
    String?
        status, // 'pending' | 'approved' | 'rejected' | 'cancelled' | 'completed'
  }) async {
    final qs =
        ['user_id=$userId', if (status != null) 'status=$status'].join('&');
    final url = Uri.parse("${getBaseUrl()}/list_reservation.php?$qs");
    final r = await http.get(url);
    if (r.statusCode == 200) {
      final data = jsonDecode(r.body) as Map<String, dynamic>;
      return (data['items'] as List<dynamic>);
    }
    return [];
  }

  /// C) Erweiterte Liste (Barber/Admin/Filter)
  static Future<List<dynamic>> listReservationsAdvanced({
    int? userId,
    int? barberId,
    String? status,
    String? from, // 'YYYY-MM-DD'
    String? to, // 'YYYY-MM-DD'
  }) async {
    final p = <String>[];
    if (userId != null) p.add('user_id=$userId');
    if (barberId != null) p.add('barber_id=$barberId');
    if (status != null) p.add('status=$status');
    if (from != null) p.add('from=$from');
    if (to != null) p.add('to=$to');
    final q = p.isEmpty ? '' : '?${p.join('&')}';

    final r =
        await http.get(Uri.parse("${getBaseUrl()}/list_reservation.php$q"));
    if (r.statusCode == 200) {
      final data = jsonDecode(r.body) as Map<String, dynamic>;
      return (data['items'] as List<dynamic>);
    }
    return [];
  }

  /// D) Stornieren (Client)
  static Future<Map<String, dynamic>> cancelReservation(int id) async =>
      _postRequest('cancel_reservation.php', {'id': '$id'});

  /// E) Bestätigen/Ablehnen (Admin/Barber)
  static Future<Map<String, dynamic>> approveReservation({
    required int id,
    required String action, // 'approve' | 'reject'
    String approvedBy = '',
  }) async =>
      _postRequest('approve_reservation.php', {
        'id': '$id',
        'action': action,
        'approved_by': approvedBy,
      });

  /// F) Dashboard-Zahlen
  static Future<Map<String, dynamic>> getStats({int? barberId}) async {
    final q = barberId != null ? '?barber_id=$barberId' : '';
    final r = await http.get(Uri.parse("${getBaseUrl()}/stats.php$q"));
    if (r.statusCode == 200) return jsonDecode(r.body);
    return {'status': 'error', 'message': 'Server-Fehler: ${r.statusCode}'};
  }

  static Future<Map<String, dynamic>> ensureSlot({
    required int barberId,
    required String dateTimeIso, // 'YYYY-MM-DD HH:mm:ss'
    int durationMin = 30,
  }) async {
    return await _postRequest('ensure_slot.php', {
      'barber_id': '$barberId',
      'date_time': dateTimeIso,
      'duration_min': '$durationMin',
    });
  }

  static Future<List<dynamic>> listBarbers() async {
    final r = await http.get(Uri.parse("${getBaseUrl()}/list_barber.php"));
    if (r.statusCode == 200) {
      final data = jsonDecode(r.body);
      return data['barbers'] ?? [];
    }
    return [];
  }

  static Future<List<dynamic>> getClientBookings(String clientId) async {
    try {
      debugPrint("GET Client Bookings for ID: $clientId");

      final r = await http
          .get(
            Uri.parse("${getBaseUrl()}/list_reservation.php?user_id=$clientId"),
          )
          .timeout(const Duration(seconds: 10));

      debugPrint("Client Bookings STATUS: ${r.statusCode}");
      debugPrint("Client Bookings BODY: ${r.body}");

      if (r.statusCode == 200) {
        final data = jsonDecode(r.body) as Map<String, dynamic>;
        return (data['items'] as List<dynamic>? ?? []);
      }
      return [];
    } catch (e) {
      debugPrint("Client Bookings Error: $e");
      return [];
    }
  }
}
