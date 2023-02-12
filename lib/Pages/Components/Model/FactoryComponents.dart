import 'package:interview/Pages/Components/Model/Components.dart';

class Shield extends Components {
  Shield({required super.price,required super.durability, required super.category, required super.name, required super.image}) {
    price = (super.price * durability / 100);
  }

  double price = 0;
}

class Generator extends Components {
  Generator({required super.price,required super.durability, required super.category, required super.name, required super.image}) {
    price = (super.price * durability / 100);
  }

  double price = 0;
}

class Gun extends Components {
  Gun({required super.price,required super.durability, required super.category, required super.name, required super.image}) {
    price = (super.price * durability / 100);
  }

  double price = 0;
}