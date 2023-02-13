import 'package:flutter/material.dart';
import 'package:interview/Pages/HomePageScreen.dart';
import 'package:interview/Pages/Orders/View/OrderOverlay.dart';
import 'package:interview/Pages/Shop/View/ShopsPage.dart';

import 'CustomPopupRoute.dart';
import '../History/View/HistoryScreen.dart';

class RouterService {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePageScreen.route:
        return MaterialPageRoute(builder: (_) => const HomePageScreen());
      case OrderOverlay.route:
        return CustomPopupRoute(
          builder: (_) => const OrderOverlay(),
        );
      case ShopsPage.route:
        return MaterialPageRoute(builder: (context) => const ShopsPage(), settings: settings);
      case HistoryScreen.route:
         return MaterialPageRoute(builder: (_) => HistoryScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomePageScreen());
    }
  }
}
