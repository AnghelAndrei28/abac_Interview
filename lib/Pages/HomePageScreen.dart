import 'dart:async';

import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:interview/Pages/Components/Model/Components.dart';
import 'package:interview/Pages/Components/Model/FactoryComponents.dart';
import 'package:interview/Pages/Components/View/EquipedItem.dart';
import 'package:interview/Pages/Components/View/StorageItem.dart';
import 'package:interview/Pages/HistoryScreen.dart';
import 'package:interview/Pages/Shop/OverlayTest.dart';

class HomePageScreen extends StatefulWidget {

  static const String route = 'home_screen';

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final List<Components> _componentsList = [
    Components.fromTypeName("Guns"),
    Components.fromTypeName("Shields"),
    Components.fromTypeName("Generators"),
    Components.fromTypeName("Shields"),
    Components.fromTypeName("Guns"),
    Components.fromTypeName("Generators"),
    Components.fromTypeName("Shields"),
    Components.fromTypeName("Guns"),
    Components.fromTypeName("Shields"),
    Components.fromTypeName("Shields"),
    Components.fromTypeName("Generators"),
    Components.fromTypeName("Guns"),
    Components.fromTypeName("Shields"),
  ];

  bool isCompoentSelected = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("HomePage"),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(HistoryScreen.route);
          }, icon: Icon(Icons.history))
        ],
      ),
      body: Container(
        height: 0.8 * height,
        child: Column(
          children: [
            SizedBox(height: 0.05 * height),
            Text(
              "Your ship",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 0.1 * height,
            ),
            Row(children: [
              Container(
                height: 0.3 * height,
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 0.45 * width,
                    child: Image.asset("assets/nava.png"),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Equiped",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 2),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      EquipedItem(
                        width: width,
                        height: height,
                        component: Components.fromTypeName("Shields"),
                      ),
                      EquipedItem(
                        width: width,
                        height: height,
                        component: Components.fromTypeName("Generators"),
                      ),
                      EquipedItem(
                        width: width,
                        height: height,
                        component: Components.fromTypeName("Guns"),
                      )
                    ],
                  )),
                ]),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Storage",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 0.3 * height,
                      child: GroupedListView<Components, String>(
                          elements: _componentsList,
                          groupBy: (element) => element.category,
                          order: GroupedListOrder.DESC,
                          useStickyGroupSeparators: true,
                          scrollDirection: Axis.vertical,
                          groupSeparatorBuilder: (String value) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  value,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                          itemBuilder: (c, element) {
                            return StorageItem(
                                width: width,
                                height: height,
                                component: element);
                          }),
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, OverlayTest.route),
        child: Icon(Icons.shopping_cart_outlined),
      ),
    );
  }
}
