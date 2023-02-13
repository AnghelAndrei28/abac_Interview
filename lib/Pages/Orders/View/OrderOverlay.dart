import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:interview/Pages/Shop/Model/ShopArguments.dart';
import 'package:interview/Pages/Shop/View/ShopsPage.dart';
import 'package:intl/intl.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

import '../../Components/Model/Components.dart';
import '../Model/OrderComponent.dart';
import '../Model/OrderComponentsDropdown.dart';
import 'package:uuid/uuid.dart';

const _kAnimationDuration = Duration(milliseconds: 100);
const _kPadding = EdgeInsets.symmetric(vertical: 70, horizontal: 24);

class OrderOverlay extends StatefulWidget {
  static const String route = 'save_note';

  const OrderOverlay({super.key});

  @override
  State<OrderOverlay> createState() => _OrderOverlayState();
}

class _OrderOverlayState extends State<OrderOverlay> {
  DateTime _selectedDay = DateTime.now();
  int _currentStep = 0;
  List<DataRow> _shopList = [];
  final List<OrderComponent> _shopComponentList = [];
  var uuid = const Uuid();
  late String selectedTime;
  int selectedCard = -1;

  final TextEditingController _searchTextEditingController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    OrderComponentsDropdown.setElements([
      Components.fromTypeName("Guns"),
      Components.fromTypeName("Shields"),
      Components.fromTypeName("Generators"),
    ]);

    _shopList.add(DataRow(cells: [
      DataCell(
        CustomDropdown.search(
          hintText: 'Select component',
          controller: _searchTextEditingController,
          items: OrderComponentsDropdown.componentsList,
        ),
      ),
      DataCell(
        TextFormField(
          controller: _quantityController,
          decoration: const InputDecoration(hintText: "2"),
          keyboardType: TextInputType.number,
        ),
      ),
      const DataCell(
        Text(""),
      ),
      const DataCell(
        Text(""),
      ),
      DataCell(
        IconButton(
          onPressed: () {
            if (_quantityController.text != "" &&
                _searchTextEditingController.text != "") {
              OrderComponent chosenComponent;
              List<String> args = _searchTextEditingController.text.split(' ');
              switch (args[0]) {
                case 'Shield':
                  chosenComponent = OrderComponent(
                      component: Components.fromTypeName("Shields"),
                      noProducts: int.parse(_quantityController.text));
                  break;
                case 'Generator':
                  chosenComponent = OrderComponent(
                      component: Components.fromTypeName("Generators"),
                      noProducts: int.parse(_quantityController.text));
                  break;
                default:
                  chosenComponent = OrderComponent(
                      component: Components.fromTypeName("Guns"),
                      noProducts: int.parse(_quantityController.text));
              }

              chosenComponent.setPrice(double.parse(args[2]));

              _shopComponentList.add(chosenComponent);

              setState(() {
                _shopList = [
                  DataRow(
                    cells: [
                      DataCell(Text(chosenComponent.component.name)),
                      DataCell(Text(chosenComponent.noProducts.toString())),
                      DataCell(
                          Text(chosenComponent.component.price.toString())),
                      DataCell(Text(chosenComponent.totalPrice)),
                      DataCell(IconButton(
                          onPressed: () {}, icon: const Icon(Icons.delete))),
                    ],
                  ),
                  ..._shopList
                ];
              });
            } else {
              //TODO: Handle it
            }
          },
          icon: const Icon(Icons.add_circle_outline_rounded),
        ),
      ),
    ]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets + _kPadding;

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return AnimatedPadding(
      padding: padding,
      duration: _kAnimationDuration,
      curve: Curves.ease,
      child: Material(
        color: Colors.white,
        child: Stepper(
          type: StepperType.horizontal,
          physics: const ScrollPhysics(),
          currentStep: _currentStep,
          onStepTapped: (step) => tapped(step),
          onStepCancel: cancel,
          onStepContinue: continued,
          steps: [
            //TODO: Sa fac widget-uri separate pe taskuri
            Step(
              title: const Text('Create order'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                      width: 0.9 * width,
                      height: 0.5 * height,
                      child: InteractiveViewer(
                        constrained: false,
                        child: _createDataTable(),
                      ))
                ],
              ),
              isActive: _currentStep >= 0,
              state: _currentStep > 0 ? StepState.complete : StepState.disabled,
            ),
            Step(
              title: const Text('Choose date'),
              content: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WeeklyDatePicker(
                    selectedDay: _selectedDay,
                    changeDay: (value) => setState(() {
                      if (value.isAtSameMomentAs(DateTime.now()) ||
                          value.isAfter(DateTime.now())) {
                        _selectedDay = value;
                        selectedCard = -1;
                      }
                    }),
                    enableWeeknumberText: false,
                    weeknumberColor: const Color(0xFF57AF87),
                    weeknumberTextColor: Colors.white,
                    backgroundColor: const Color(0xFF1A1A1A),
                    weekdayTextColor: const Color(0xFF8A8A8A),
                    digitsColor: Colors.white,
                    selectedBackgroundColor: const Color(0xFF57AF87),
                    daysInWeek: 7,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 0.8 * width,
                    height: 0.4 * height,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: const BorderRadius.all(Radius.circular(5))),
                    child: GridView.count(
                      physics: const ScrollPhysics(),
                      crossAxisCount: 2,
                      children: List.generate(8, (index) {
                        String time = '${index + 10}:00 - ${index + 11}:00';
                        return GestureDetector(
                          onTap: () {
                            selectedTime = time;
                            setState(() {
                              checkOption(index);
                            });
                          },
                          child: Card(
                            color: selectedCard == index
                                ? Colors.deepOrange
                                : Colors.teal.withOpacity(0.5),
                            child: Center(
                                child: Text(
                              time,
                            )),
                          ),
                        );
                      }),
                    ),
                  )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(
      columns: _createColumns(),
      rows: _shopList,
      dividerThickness: 5,
      dataRowHeight: 80,
      showBottomBorder: true,
      headingTextStyle:
          const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      headingRowColor:
          MaterialStateProperty.resolveWith((states) => Colors.black),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('Component')),
      const DataColumn(label: Text('Quantity')),
      const DataColumn(label: Text('Price/Unit')),
      const DataColumn(label: Text('Total')),
      const DataColumn(label: Text('')),
    ];
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    DateFormat formatter;
    _currentStep < 1
        ? setState(() => _currentStep += 1)
        : {
            formatter = DateFormat('yyyy-MM-dd'),
            Navigator.popAndPushNamed(context, ShopsPage.route,
                arguments: ShopArguments(
                    items: _shopComponentList,
                    date: formatter.format(_selectedDay),
                    hour: selectedTime,
                    uid: uuid.v1()))
          };
  }

  cancel() {
    _currentStep > 0
        ? setState(() => _currentStep -= 1)
        : Navigator.pop(context);
  }

  void deleteEntry(DataRow entry) {
    setState(() {
      _shopList.removeWhere((element) => element == entry);
    });
  }

  void checkOption(int index) {
    setState(() {
      selectedCard = index;
    });
  }
}
