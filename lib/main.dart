import 'package:barber_select/screens/client/screens/bookings/controller/client_booking_controller.dart';
import 'package:barber_select/screens/splash/screens/splash_screen.dart';
import 'package:barber_select/services/prefs.dart';
import 'package:barber_select/translation.dart';

import 'package:barber_select/utils/app_themes.dart';
import 'package:barber_select/utils/responsive.dart';
import 'package:barber_select/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String savedLanguage = await Prefs().loadSavedLanguage();
  Get.put(ClientBookingController());
  runApp(MyApp(savedLanguage: savedLanguage));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.savedLanguage});
  final String savedLanguage;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale defaultLocale;

  @override
  void initState() {
    defaultLocale = Locale(
      widget.savedLanguage,
      widget.savedLanguage == "en" ? 'US' : 'ES',
    );
    print(defaultLocale);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
        Responsive.isMobile(context)
            ? 375
            : Responsive.isTablet(context)
            ? 1024
            : 1440,
        Responsive.isMobile(context)
            ? 852
            : Responsive.isTablet(context)
            ? 1024
            : 1024,
      ),
      minTextAdapt: true,
      builder: (_, child) {
        final CustomDrawerController drawerController = Get.put(
          CustomDrawerController(),
        );
        return Obx(
          () => ScrollConfiguration(
            behavior: MyBehavior(),
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              translations: Translation(),
              themeMode:
                  drawerController.isDarkMode.value
                      ? ThemeMode.dark
                      : ThemeMode.light,
              locale: defaultLocale,
              title: 'thmCUT',
              theme: AppThemes().lightTheme,
              darkTheme: AppThemes().darkTheme,
              // theme: ThemeData(
              //   colorScheme: ColorScheme.fromSeed(
              //     seedColor: AppColors.primaryColor,
              //   ),
              //   bottomSheetTheme: BottomSheetThemeData(
              //     backgroundColor: Colors.transparent,
              //   ),
              //   useMaterial3: false,

              //   iconTheme: IconThemeData(color: Colors.black),
              //   scaffoldBackgroundColor: Colors.white,
              //   appBarTheme: AppBarTheme(
              //     iconTheme: IconThemeData(color: Colors.black),
              //     backgroundColor: Colors.white,
              //     elevation: 0,
              //   ),
              // ),
              home: SplashScreen(),
            ),
          ),
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
