import 'package:flutter/material.dart';

import '../Model/Shop.dart';

class ShopItem extends StatelessWidget {
  const ShopItem({super.key, required this.shop, required this.width, required this.height});

  final double width;
  final double height;
  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              width: 0.2 * width,
              child: Image.asset("assets/placeholder_shop.png"),
            ),
            SizedBox(
              width: 0.17 * width,
              child: Column(
                children: [
                  Text(shop.name),
                  const SizedBox(height: 10,),
                  Text('${shop.rating.toStringAsFixed(2)}/5')
                ],
              ),
            )
          ],
        ),
        Text('Total price is ${shop.getTotalSum()}\$'),
        const SizedBox(height: 5),
        Text('Distance ${shop.getDistance().toStringAsFixed(2)} m'),
        SizedBox(height: 0.02 * height,)
      ],
    );
  }
}
