import 'package:flutter/material.dart';
import 'package:interview/Pages/History.dart';
import 'package:flip_card/flip_card.dart';
import 'package:interview/Pages/HistoryProvider.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {

  static const String route = 'history_screen';

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    List<History> historyList = Provider.of<HistoryProvider>(context).getList();

    return Scaffold(
        appBar: AppBar(
          title: Text('History'),
          centerTitle: true,
        ),
        body: historyList.isNotEmpty
            ? Container(
                child: ListView.builder(
                  physics: ScrollPhysics(),
                  itemCount: historyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FlipCard(
                      side: CardSide.FRONT,
                      direction: FlipDirection.HORIZONTAL,
                      front: Container(
                        padding: EdgeInsets.all(5),
                        height: 0.2 * height,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                              width: 0.2 * width,
                              child: Image.asset("assets/placeholder_shop.png"),
                            ),
                            Container(
                              width: 0.7 * width,
                              child: Column(
                                children: [
                                  Text('Order id: ${historyList[index].args.uid}')
                                ],
                              ),
                            )
                          ],
                        ),
                      ), back: Container(),
                    );
                  },
                ),
              )
            : Center(
                child: Text(
                  'There are no past orders',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ));
  }
}
