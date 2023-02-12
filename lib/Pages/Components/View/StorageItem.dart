import 'package:flutter/material.dart';
import 'package:interview/Pages/Components/Model/Components.dart';

class StorageItem extends StatelessWidget {
  StorageItem(
      {required this.width, required this.height, required this.component});

  final double width;
  final double height;
  final Components component;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.1 * height,
      width: 0.4 * width,
      decoration: BoxDecoration(
          color: Color(0xFF3F826D).withOpacity(0.3),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Row(
        children: [
          Container(
            width: 0.2 * width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/${component.image}'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 0.2 * width,
            child: Column(
              children: [
                Text(
                  component.name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Durability: ' + component.durability.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: component.durability! > 75
                          ? Colors.green
                          : component.durability! > 40
                              ? Colors.yellow
                              : Colors.red),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
