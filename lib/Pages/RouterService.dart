import 'package:flutter/material.dart';
import 'package:interview/Pages/HomePageScreen.dart';
import 'package:interview/Pages/Shop/OverlayTest.dart';
import 'package:interview/Pages/ShopsPage.dart';

import 'CustomPopupRoute.dart';

class RouterService {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePageScreen.route:
        return MaterialPageRoute(builder: (_) => HomePageScreen());
      case OverlayTest.route:
        return CustomPopupRoute(
          builder: (_) => OverlayTest(),
        );
      case ShopsPage.route:
        return MaterialPageRoute(builder: (_) => ShopsPage());
      default:
        return MaterialPageRoute(builder: (_) => HomePageScreen());
    }
  }
}
