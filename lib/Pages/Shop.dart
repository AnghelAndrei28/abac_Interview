import 'dart:math';

import 'Shop/Model/ShopComponent.dart';

class Shop {
  final String name;
  late double rating;
  double _totalSum = 0;
  late Map<String, double> priceList;
  late String imageUrl;
  late double _distance;

  Shop({required this.name}) {
    final random = Random();
    rating = random.nextDouble() * 5;
    priceList = {
      'Shield': random.nextDouble() * 2000,
      'Generator': random.nextDouble() * 3000,
      'Gun': random.nextDouble() * 2000
    };
    _distance = random.nextDouble() * 1900 + 100;
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
    return _distance;
  }
}