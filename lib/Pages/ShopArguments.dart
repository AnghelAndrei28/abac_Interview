import 'package:interview/Pages/Shop/Model/ShopComponent.dart';

class ShopArguments {
  List<ShopComponent> items;
  String date;
  String hour;
  String uid;

  ShopArguments({required this.items, required this.date, required this.hour, required this.uid});
}