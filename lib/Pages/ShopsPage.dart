import 'package:flutter/material.dart';

class ShopsPage extends StatefulWidget {

  static const String route = 'shops_list';

  @override
  State<ShopsPage> createState() => _ShopsPageState();
}

class _ShopsPageState extends State<ShopsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose the shop"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Text("Asta e o lista"),
          ],
        ),
      ),
    );
  }
}
