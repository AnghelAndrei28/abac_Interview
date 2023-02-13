import 'package:interview/Pages/Orders/Model/OrderComponent.dart';

class ShopArguments {
  List<OrderComponent> items;
  String date;
  String hour;
  String uid;

  ShopArguments({required this.items, required this.date, required this.hour, required this.uid});
}