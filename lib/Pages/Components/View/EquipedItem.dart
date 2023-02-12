import 'package:flutter/material.dart';

import '../Model/Components.dart';

class EquipedItem extends StatelessWidget {

  EquipedItem(
      {required this.width, required this.height, required this.component});

  final double width;
  final double height;
  final Components component;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.12 * width,
      height: 0.07 * height,
      child: Image.asset("assets/${component.image}"),
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: component.durability! > 75
            ? Colors.green.withOpacity(0.2)
            : component.durability! > 40
            ? Colors.yellow.withOpacity(0.2)
            : Colors.red.withOpacity(0.2)

      ),
    );
  }
}
