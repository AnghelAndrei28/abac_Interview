import 'package:flutter/material.dart';
import 'package:interview/Pages/Components/Model/Components.dart';

class StorageItem extends StatelessWidget {
  const StorageItem(
      {super.key, required this.width, required this.height, required this.component});

  final double width;
  final double height;
  final Components component;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.1 * height,
      width: 0.4 * width,
      decoration: BoxDecoration(
          color: const Color(0xFF3F826D).withOpacity(0.3),
          borderRadius: const BorderRadius.all(Radius.circular(30))),
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
          SizedBox(
            width: 0.2 * width,
            child: Column(
              children: [
                Text(
                  component.name,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Durability: ${component.durability}',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: component.durability> 75
                          ? Colors.green
                          : component.durability> 40
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
