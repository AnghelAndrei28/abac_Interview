import 'package:interview/Pages/Components/Model/Components.dart';

class ShopComponent {
  ShopComponent({required this.component, required this.noProducts}) {
    totalPrice = (noProducts * component.getPrice()).toStringAsFixed(2);
  }

  late String totalPrice;
  int noProducts;
  Components component;

}