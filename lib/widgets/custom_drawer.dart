import 'package:barber_select/dialog/logout_dialog.dart';
import 'package:barber_select/generated/assets.dart';
import 'package:barber_select/screens/auth/screens/login_screen.dart';
import 'package:barber_select/screens/barber/home/screens/barber_home_screen.dart';
import 'package:barber_select/screens/barber/my_clients/screens/my_clients_screen.dart';
import 'package:barber_select/screens/barber/my_link/screens/my_link_screen.dart';
import 'package:barber_select/screens/barber/revenue/screens/revenue_screen.dart';
import 'package:barber_select/screens/barber/settings/screens/setting_screen.dart';
import 'package:barber_select/screens/client/screens/bookings/screens/client_bookings.dart';
import 'package:barber_select/screens/client/screens/find_barbers/screens/find_barbers_screen.dart';
import 'package:barber_select/screens/client/screens/home/screens/client_home_screen.dart';
import 'package:barber_select/screens/rate_app/screens/rate_app_screen.dart';
import 'package:barber_select/screens/report_bug/screens/report_bug_screen.dart';
import 'package:barber_select/utils/app_colors.dart';
import 'package:barber_select/utils/app_text_styles.dart';
import 'package:barber_select/utils/gaps.dart';
import 'package:barber_select/utils/responsive.dart';
import 'package:barber_select/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key, required this.isBarber});
  final bool isBarber;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomDrawerController>();
    return Drawer(
      backgroundColor:
          Get.isDarkMode
              ? AppColors.darkScreenBg.withOpacity(0.9)
              : AppColors.whiteColor.withOpacity(0.9),
      child: Column(
        children: [
          70.ph,
          Row(
            children: [
              Spacer(),
              Image.asset(
                Assets.appLogo,
                width: 100.w,
                color:
                    Get.isDarkMode
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
              ),
              Spacer(),

              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color:
                        Get.isDarkMode
                            ? AppColors.blackColor
                            : AppColors.iconContainerColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 2,
                        color: AppColors.blackColor.withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(Icons.close, color: AppColors.primaryColor),
                  ),
                ),
              ),
            ],
          ),
          40.ph,
          Column(
            children: [
              if (widget.isBarber)
                DrawerTile(
                  icon: Icons.add_link_outlined,
                  title: 'My Link'.tr,
                  onTap: () {
                    Get.to(() => MyLinkScreen());
                  },
                ),
              if (widget.isBarber) 15.ph,
              if (widget.isBarber)
                DrawerTile(
                  icon: Icons.monitor,
                  title: 'Client',
                  onTap: () {
                    Get.to(() => MyClientsScreen());
                  },
                ),
              if (widget.isBarber) 15.ph,
              if (widget.isBarber)
                DrawerTile(
                  icon: Icons.auto_graph_sharp,
                  title: 'Revenue',
                  onTap: () {
                    Get.to(() => RevenueScreen());
                  },
                ),
              if (widget.isBarber) 15.ph,
              if (!widget.isBarber)
                DrawerTile(
                  icon: Icons.search,
                  title: 'Find Barber',
                  onTap: () {
                    Get.to(() => FindBarbersScreen());
                  },
                ),
              if (!widget.isBarber) 15.ph,
              if (!widget.isBarber)
                DrawerTile(
                  icon: Icons.book,
                  title: 'Bookings',
                  onTap: () {
                    Get.to(() => ClientBookingsScreen());
                  },
                ),
              if (!widget.isBarber) 15.ph,
              DrawerTile(
                icon: Icons.bug_report,
                title: 'Report a Bug',
                onTap: () {
                  Get.to(() => ReportBugScreen());
                },
              ),
              15.ph,

              DrawerTile(
                icon: Icons.star_border,
                title: 'Rate App',
                onTap: () {
                  Get.to(() => RateAppScreen());
                },
              ),
              15.ph,
              if (widget.isBarber)
                DrawerTile(
                  icon: Icons.app_settings_alt,
                  title: 'Settings',
                  onTap: () {
                    Get.to(() => BarberSettingsScreen());
                  },
                ),
              if (!widget.isBarber)
                DrawerTile(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return LogoutDialog();
                      },
                    );
                  },
                ),
              50.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Flexible(
                    child: SizedBox(
                      width:
                          Responsive.isLargeDesktop(context)
                              ? 200
                              : Responsive.isDesktop(context)
                              ? 150
                              : Responsive.isTablet(context)
                              ? 150
                              : null,
                      child: CustomButtonWidget(
                        btnLabel: 'BARBER'.tr,
                        bgColor: AppColors.darkBrownColor,
                        onTap: () {
                          Get.offAll(() => BarberHomeScreen());
                        },
                      ),
                    ),
                  ),
                  10.pw,

                  Flexible(
                    child: SizedBox(
                      width:
                          Responsive.isLargeDesktop(context)
                              ? 200
                              : Responsive.isDesktop(context)
                              ? 150
                              : Responsive.isTablet(context)
                              ? 150
                              : null,
                      child: CustomButtonWidget(
                        btnLabel: 'CLIENT'.tr,
                        bgColor: AppColors.primaryColor2,
                        onTap: () {
                          Get.offAll(() => ClientHomeScreen());
                        },
                      ),
                    ),
                  ),
                ],
              ).paddingOnly(right: 20),
            ],
          ).paddingSymmetric(horizontal: 20),
          Spacer(),
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 2,
                      color: AppColors.blackColor.withOpacity(0.1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(6),
                  color:
                      Get.isDarkMode
                          ? AppColors.blackColor.withOpacity(0.7)
                          : AppColors.iconContainerColor,
                ),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      controller.toggleTheme();
                      Get.back();
                    },
                    child: Obx(
                      () => Icon(
                        controller.isDarkMode.value
                            ? Icons.sunny
                            : Icons.dark_mode_outlined,
                        size: 30,
                        color:
                            controller.isDarkMode.value
                                ? AppColors.whiteColor
                                : AppColors.blackColor,
                      ),
                    ),
                  ),
                ),
              ),
              5.pw,
              // InkWell(
              //   onTap: () {
              //     controller.selectLanguage('English');
              //   },
              //   child: Image.asset(
              //     Assets.usaFlag,
              //     width: 50.w,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              // 10.pw,
              // InkWell(
              //   onTap: () {
              //     controller.selectLanguage('Spanish');
              //   },
              //   child: Image.asset(
              //     Assets.spainFlag,
              //     width: 37.w,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              // 15.pw,
              // InkWell(
              //   onTap: () {
              //     controller.selectLanguage('Brazil');
              //   },
              //   child: Image.asset(
              //     Assets.brazilFlag,
              //     width: 37.w,
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ],
          ).paddingSymmetric(horizontal: 20),
          20.ph,
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onTap;
  const DrawerTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<CustomDrawerController>();
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Icon(
              icon,
              color:
                  Get.isDarkMode
                      ? AppColors.darkModeTextColor
                      : AppColors.textBlackColor,
            ),
          ),
          5.pw,
          Obx(
            () => Text(
              title.tr,
              style: AppTextStyles.getPoppins(
                16.sp,
                5.weight,
                themeController.isDarkMode,

                themeController.isDarkMode.value
                    ? AppColors.darkModeTextColor
                    : AppColors.textBlackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDrawerController extends GetxController {
  var language = 'English'.obs;

  final Map<String, String> languageCodes = {
    "English": 'en',
    "Spanish": 'es',
    "Brazil": 'pt',
  };
  Future<void> selectLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String localeCode = languageCodes[language] ?? 'en';

    await prefs.setString('savedLanguage', localeCode);
    Get.updateLocale(Locale(localeCode));
  }

  Future<void> loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLocale = prefs.getString('savedLanguage') ?? 'en';

    language.value = _getLanguageFromLocale(savedLocale);
    Get.updateLocale(Locale(savedLocale));
  }

  String _getLanguageFromLocale(String locale) {
    return languageCodes.entries
        .firstWhere(
          (entry) => entry.value == locale,
          orElse: () => MapEntry('Spanish', 'es'),
        )
        .key;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('savedLanguage');
    if (savedLanguage != null) {
      language.value = savedLanguage == "en" ? "English" : "Spanish";
    } else {
      language.value = "Spanish";
    }
    loadLanguage();
  }

  var isDarkMode = false.obs;
  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
    Get.changeThemeMode(theme);
  }
}
