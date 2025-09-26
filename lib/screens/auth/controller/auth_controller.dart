import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class AuthController extends GetxController {
  final tecEmail = TextEditingController();
  final fnEmail = FocusNode();
  final tecPassword = TextEditingController();
  final fnPassword = FocusNode();

  final tecEmailS = TextEditingController();
  final fnEmailS = FocusNode();
  final tecPasswordS = TextEditingController();
  final fnPasswordS = FocusNode();
  final tecPhone = TextEditingController();
  final fnPhone = FocusNode();

  RxBool togglePasswordL = true.obs;
  RxBool togglePasswordS = true.obs;

  final loginForm = GlobalKey<FormState>();
  final signUpForm = GlobalKey<FormState>();

//  Aktueller User
  final RxnInt currentUserId = RxnInt(); // null bis eingeloggt
  final RxString currentUserEmail = ''.obs;
  final RxString currentUserRole = ''.obs;
  final RxString currentUserName = ''.obs;

  Future<void> load() async {
    final sp = await SharedPreferences.getInstance();
    final id = sp.getInt('user_id');
    final email = sp.getString('user_email') ?? '';
    final role = sp.getString('user_role') ?? '';
    final name = sp.getString('user_name') ?? '';
    if (id != null && id > 0) currentUserId.value = id;
    currentUserEmail.value = email;
    currentUserRole.value = role;
    currentUserName.value = name;
  }

  Future<void> setUser({
    required int id,
    required String email,
    String role = '',
    String name = '',
  }) async {
    currentUserId.value = id;
    currentUserEmail.value = email;
    currentUserRole.value = role;
    currentUserName.value = name;

    final sp = await SharedPreferences.getInstance();
    await sp.setInt('user_id', id);
    await sp.setString('user_email', email);
    await sp.setString('user_role', role);
    await sp.setString('user_name', name);
  }

  Future<void> logout() async {
    currentUserId.value = null;
    currentUserEmail.value = '';
    currentUserRole.value = ''; // HINZUFÜGEN
    currentUserName.value = ''; // HINZUFÜGEN

    final sp = await SharedPreferences.getInstance();
    await sp.remove('user_id');
    await sp.remove('user_email');
    await sp.remove('user_role'); // HINZUFÜGEN
    await sp.remove('user_name'); // HINZUFÜGEN
  }
}
