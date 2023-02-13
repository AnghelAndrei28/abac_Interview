import 'package:flutter/material.dart';

import 'Shop.dart';

class ShopWidget extends StatelessWidget {
  ShopWidget({required this.shop, required this.width, required this.height});

  final double width;
  final double height;
  Shop shop;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      color: Colors.purple,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: 0.2 * width,
                  child: Image.asset("assets/placeholder_shop.png"),
                ),
                Container(
                  width: 0.17 * width,
                  child: Column(
                    children: [
                      Text(shop.name),
                      SizedBox(height: 10,),
                      Text(shop.rating.toStringAsFixed(2) + '/5')
                    ],
                  ),
                )
              ],
            ),
          ),
          Text('Total price is ${shop.getTotalSum()}\$'),
          SizedBox(height: 5),
          Text('Distance ${shop.latitude.toStringAsFixed(2)} m'),
          SizedBox(height: 0.02 * height,)
        ],
      ),
    );
  }
}
