import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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
}
