import 'package:barber_select/screens/welcome/components/welcome_widget.dart';
import 'package:barber_select/screens/welcome/controller/welcome_controller.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WelcomeController());
    final PageController pageController = PageController();
    return SafeArea(child: Scaffold(body: WelcomeWidget()));
  }
}
