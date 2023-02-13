import 'package:interview/Pages/Components/Model/Components.dart';

class OrderComponent {
  OrderComponent({required this.component, required this.noProducts}) {
    totalPrice = (noProducts * component.getPrice()).toStringAsFixed(2);
  }

  late String totalPrice;
  int noProducts;
  Components component;

  void setPrice(double price) {
    component.price = price;
    totalPrice = (noProducts * component.getPrice()).toStringAsFixed(2);
  }

}