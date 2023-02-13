import 'package:flutter/material.dart';

import '../../Components/Model/Components.dart';

class OrderItem extends StatelessWidget {
  const OrderItem(
      {super.key, required this.width, required this.height, required this.component});

  final double width;
  final double height;
  final Components component;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.12 * width,
      height: 0.07 * height,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Stack(children: [
        Image.asset("assets/${component.image}"),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(component.name),
            Text("${component.price} \$")
          ]
        )
      ]),
    );
  }
}
