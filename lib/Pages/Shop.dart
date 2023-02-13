import 'dart:math';

import 'Shop/Model/ShopComponent.dart';

class Shop {
  final String name;
  late double rating;
  double _totalSum = 0;
  late Map<String, double> priceList;
  late double latitude;
  late double longitude;
  late String imageUrl;

  Shop({required this.name}) {
    final random = Random();
    rating = random.nextDouble() * 5;
    priceList = {
      'Shield': random.nextDouble() * 2000,
      'Generator': random.nextDouble() * 3000,
      'Gun': random.nextDouble() * 2000
    };
    latitude = random.nextDouble() * 180 - 90;
    longitude = random.nextDouble() * 180 - 90;
  }

  void calculateSum(List<ShopComponent> elements) {
    _totalSum = 0;
    for(ShopComponent component in elements) {
      _totalSum += priceList[component.component.name]! * component.noProducts;
    }
  }

  String getTotalSum() {
    return _totalSum.toStringAsFixed(2);
  }

  double getDistance() {
    return 0;
  }
}