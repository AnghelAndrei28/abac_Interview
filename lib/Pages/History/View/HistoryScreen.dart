import 'package:flutter/material.dart';
import 'package:interview/Pages/History/Model/History.dart';
import 'package:interview/Pages/History/Service/HistoryProvider.dart';
import 'package:interview/Pages/History/View/HistoryItem.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  static const String route = 'history_screen';

  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    List<History> historyList = Provider.of<HistoryProvider>(context).getList();

    return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
          centerTitle: true,
        ),
        body: historyList.isNotEmpty
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.2),
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: historyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return HistoryItem(width: width, height: height, historyItem: historyList[index],);
                  },
                ),
              )
            : const Center(
                child: Text(
                  'There are no past orders',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ));
  }
}
