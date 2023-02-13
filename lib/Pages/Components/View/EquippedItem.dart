import 'package:flutter/material.dart';

import '../Model/Components.dart';

class EquippedItem extends StatelessWidget {

  const EquippedItem(
      {super.key, required this.width, required this.height, required this.component});

  final double width;
  final double height;
  final Components component;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.2 * width,
      height: 0.1 * height,
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: component.durability> 75
            ? Colors.green.withOpacity(0.2)
            : component.durability> 40
            ? Colors.yellow.withOpacity(0.2)
            : Colors.red.withOpacity(0.2)

      ),
      child: Image.asset("assets/${component.image}"),
    );
  }
}
