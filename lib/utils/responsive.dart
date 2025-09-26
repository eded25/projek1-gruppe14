import 'package:barber_select/utils/constants.dart';
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < Constants.tablet;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width <= Constants.desktop &&
      MediaQuery.of(context).size.width >= Constants.tablet;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width <= Constants.largeDesktop &&
      MediaQuery.of(context).size.width >= Constants.desktop;
  static bool isLargeDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > Constants.largeDesktop;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    if (_size.width >= Constants.desktop) {
      return desktop;
    } else if (_size.width >= Constants.tablet && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
