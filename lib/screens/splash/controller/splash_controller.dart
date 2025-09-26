import 'package:barber_select/screens/welcome/screens/welcome_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  checkStatus() async {
    await Future.delayed(Duration(seconds: 2));
    Get.to(() => WelcomeScreen());
  }

  @override
  void onInit() {
    super.onInit();
    checkStatus();
  }
}
