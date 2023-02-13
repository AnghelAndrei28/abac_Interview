import 'package:flutter/material.dart';
import 'package:interview/Pages/History/Model/History.dart';
import 'package:interview/Pages/History/Service/HistoryProvider.dart';
import 'package:interview/Pages/Shop/Model/ShopArguments.dart';
import 'package:interview/Pages/Shop/View/ShopItem.dart';
import 'package:provider/provider.dart';

import '../Model/Shop.dart';

enum SortType { price, rating, distance }

class ShopsPage extends StatefulWidget {
  static const String route = 'shops_list';

  const ShopsPage({super.key});

  @override
  State<ShopsPage> createState() => _ShopsPageState();
}

class _ShopsPageState extends State<ShopsPage> {
  List<Shop> shopNames = [
    Shop(name: 'Carrefour'),
    Shop(name: 'Kaufland'),
    Shop(name: 'Penny'),
    Shop(name: 'Profi'),
    Shop(name: 'Mega Image'),
    Shop(name: 'Auchan'),
  ];

  late List<Shop> displayedShops;

  final TextEditingController _searchController = TextEditingController();

  int shopSelected = -1;

  @override
  void initState() {
    displayedShops = shopNames;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ShopArguments;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose the shop"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                placeOrder(context, History(shop: displayedShops.elementAt(shopSelected), args: args));
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_forward))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                top: 0.05 * height, left: 0.1 * width, right: 0.1 * width),
            height: 0.1 * height,
            child: Column(
              children: [
                Text(
                  'Order no: ${args.uid}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${args.date} ${args.hour}',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const Text(
            'Shops available',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 0.05 * height,
          ),
          Stack(children: [
            TextField(
              controller: _searchController,
              onChanged: searchShop,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search Shop',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.only(top: 6, right: 10),
                    child:
                        // IconButton(
                        //     onPressed: () {}, icon: Icon(Icons.filter_list)),
                        PopupMenuButton<SortType>(
                      icon: const Icon(Icons.filter_list),
                      onSelected: (sortType) {
                        switch (sortType) {
                          case SortType.rating:
                            sortByRating();
                            break;
                          case SortType.price:
                            sortByPrice();
                            break;
                          case SortType.distance:
                            sortByDistance();
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: SortType.price,
                          child: Text('Price filter'),
                        ),
                        const PopupMenuItem(
                          value: SortType.distance,
                          child: Text('Distance filter'),
                        ),
                        const PopupMenuItem(
                          value: SortType.rating,
                          child: Text('Rating filter'),
                        ),
                      ],
                    )),
              ],
            )
          ]),
          SizedBox(
            height: 0.05 * height,
          ),
          Expanded(
              child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: GridView.builder(
                physics: const ScrollPhysics(),
                itemCount: displayedShops.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  displayedShops[index].calculateSum(args.items);
                  return GestureDetector(
                    onTap: () {
                      checkOption(index);
                    },
                    child: Card(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      color: shopSelected != index ? Colors.teal.withOpacity(0.5) : Colors.red,
                      child: ShopItem(
                          shop: displayedShops[index],
                          width: width,
                          height: height),
                    ),
                  );
                }),
          ))
        ],
      ),
    );
  }

  void searchShop(String query) {
    final suggestions = shopNames.where((shop) {
      final shopName = shop.name.toLowerCase();
      final input = query.toLowerCase();
      return shopName.contains(input);
    }).toList();

    setState(() {
      displayedShops = suggestions;
    });
  }

  void sortByRating() {
    setState(() {
      displayedShops.sort((prev, next) => next.rating.compareTo(prev.rating));
    });
  }

  void sortByPrice() {
    setState(() {
      displayedShops.sort(
          (prev, next) => prev.getTotalSum().compareTo(next.getTotalSum()));
    });
  }

  void sortByDistance() {
    setState(() {
      displayedShops.sort(
          (prev, next) => prev.getDistance().compareTo(next.getDistance()));
    });
  }

  void placeOrder(BuildContext context, History element) {
    Provider.of<HistoryProvider>(context, listen: false).addElement(element);
  }

  void checkOption(int index) {
    setState(() {
      shopSelected = index;
    });
  }
}
