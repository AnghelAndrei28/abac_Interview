import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:interview/Pages/Components/Model/Components.dart';
import 'package:interview/Pages/Components/View/EquippedItem.dart';
import 'package:interview/Pages/Components/View/StorageItem.dart';
import 'package:interview/Pages/History/View/HistoryScreen.dart';
import 'package:interview/Pages/Orders/View/OrderOverlay.dart';

class HomePageScreen extends StatefulWidget {
  static const String route = 'home_screen';

  const HomePageScreen({super.key});

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
        title: const Text("HomePage"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(HistoryScreen.route);
              },
              icon: const Icon(Icons.history))
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 0.05 * height),
          const Text(
            "Your ship",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 0.05 * height,
          ),
          SizedBox(
            height: 0.37 * height,
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                width: 0.6 * width,
                child: Image.asset("assets/nava.png"),
              ),
              const SizedBox(height: 5),
              const Text(
                "Equiped",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              EquippedItem(
                width: width,
                height: height,
                component: Components.fromTypeName("Shields"),
              ),
              EquippedItem(
                width: width,
                height: height,
                component: Components.fromTypeName("Generators"),
              ),
              EquippedItem(
                width: width,
                height: height,
                component: Components.fromTypeName("Guns"),
              )
                ],
              ),
            ]),
          ),
          SizedBox(
            height: 0.05 * height,
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "Storage",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 0.3 * height,
                  child: GroupedListView<Components, String>(
                      elements: _componentsList,
                      groupBy: (element) => element.category,
                      order: GroupedListOrder.DESC,
                      useStickyGroupSeparators: true,
                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                      groupSeparatorBuilder: (String value) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              value,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                      itemBuilder: (c, element) {
                        return StorageItem(
                            width: width, height: height, component: element);
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, OrderOverlay.route),
        child: const Icon(Icons.shopping_cart_outlined),
      ),
    );
  }
}
