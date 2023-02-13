import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:interview/Pages/History/Model/History.dart';

class HistoryItem extends StatefulWidget {
  const HistoryItem({Key? key, required this.width, required this.height, required this.historyItem}) : super(key: key);

  final double width;
  final double height;
  final History historyItem;

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  @override
  Widget build(BuildContext context) {
    return FlipCard(
        fill: Fill.fillBack,
        side: CardSide.FRONT,
        direction: FlipDirection.HORIZONTAL,
        front: Container(
          decoration: BoxDecoration(
              color: Colors.orangeAccent.withOpacity(0.7),
              border: Border.all(),
              borderRadius:
              const BorderRadius.all(Radius.circular(10))),
          padding: const EdgeInsets.all(5),
          height: 0.25 * widget.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(10))),
                width: 0.4 * widget.width,
                child:
                Image.asset("assets/placeholder_shop.png"),
              ),
              SizedBox(
                width: 0.35 * widget.width,
                child: Column(
                  children: [
                    Text(
                      'Order id: ${widget.historyItem.args.uid}',
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Total payment: ${widget.historyItem.shop.getTotalSum()}'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Appointment date: ${widget.historyItem.args.date} ${widget.historyItem.args.hour}')
                  ],
                ),
              )
            ],
          ),
        ),
        back: Container(
          decoration: BoxDecoration(
              color: Colors.orangeAccent.withOpacity(0.7),
              border: Border.all(),
              borderRadius:
              const BorderRadius.all(Radius.circular(10))),
          padding: const EdgeInsets.all(5),
          height: 0.3 * widget.height,
          child: Column(
            children: [
              const Text('Products ordered:'),
              for (int i = 0;
              i < widget.historyItem.args.items.length;
              i++)
                Text(
                    'Product ${i + 1}: ${widget.historyItem.args.items[i].component.name}    ${widget.historyItem.args.items[i].noProducts} x ${widget.historyItem.shop.priceList[widget.historyItem.args.items[i].component.name]?.toStringAsFixed(2)}\$'),
            ],
          ),
        ));
  }
}
