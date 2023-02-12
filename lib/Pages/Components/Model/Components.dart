import 'FactoryComponents.dart';
import 'dart:math';

class Components {
  Components({required this.price, required this.durability, this.image, required this.category, required this.name});

  int durability;
  final String category;
  final String name;
  final String? image;
  double price = 0;

  factory Components.fromTypeName(String type) {
    //Stiu ca nu e foarte etic =)))
    final _random = new Random();
    bool random = _random.nextBool();
    if(type == 'Shields') return Shield(category: type, name: "Shield", durability: _random.nextInt(100), image: random ? "shield2.png" : "shield1.png", price: 1000);
    if(type == 'Generators') return Generator(category: type, name: "Generator", durability: _random.nextInt(100), image: random ? "generator1.png" : "generator2.png", price: 2000);
    if(type == 'Guns') return Gun(category: type, name: "Gun", durability: _random.nextInt(100), image: random ? "gun1.png" : "gun2.png", price : 1500);
    throw "$type component not recognized.";
  }

  double getPrice() {
    return price;
  }
}