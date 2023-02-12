import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:interview/Pages/ShopsPage.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

import '../Components/Model/Components.dart';
import 'Model/ShopComponent.dart';
import 'Model/ShopDropdownChoices.dart';

const _kAnimationDuration = Duration(milliseconds: 100);
const _kPadding = EdgeInsets.symmetric(vertical: 70, horizontal: 24);

class OverlayTest extends StatefulWidget {

  static const String route = 'save_note';

  @override
  State<OverlayTest> createState() => _OverlayTestState();
}

class _OverlayTestState extends State<OverlayTest> {

  DateTime _selectedDay = DateTime.now();
  int _currentStep = 0;
  List<DataRow> _shopList = [];

  final TextEditingController _searchTextEditingController =
  TextEditingController();
  final TextEditingController _quantityController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    ShopDropdownChoices.setElements([
      Components.fromTypeName("Guns"),
      Components.fromTypeName("Shields"),
      Components.fromTypeName("Generators"),
    ]);

    _shopList.add(DataRow(cells: [
      DataCell(
        CustomDropdown.search(
          hintText: 'Select component',
          controller: _searchTextEditingController,
          items: ShopDropdownChoices.componentsList,
        ),
      ),
      DataCell(
        TextFormField(
          controller: _quantityController,
          decoration: InputDecoration(hintText: "2"),
          keyboardType: TextInputType.number,
        ),
      ),
      DataCell(
        Text(""),
      ),
      DataCell(
        Text(""),
      ),
      DataCell(
        IconButton(
          onPressed: () {
            if (_quantityController.text != "" &&
                _searchTextEditingController.text != "") {
              ShopComponent chosenComponent;
              switch (_searchTextEditingController.text.split(' ')[0]) {
                case 'Shield':
                  chosenComponent = ShopComponent(
                      component: Components.fromTypeName("Shields"),
                      noProducts: int.parse(_quantityController.text));
                  break;
                case 'Generator':
                  chosenComponent = ShopComponent(
                      component: Components.fromTypeName("Generators"),
                      noProducts: int.parse(_quantityController.text));
                  break;
                default:
                  chosenComponent = ShopComponent(
                      component: Components.fromTypeName("Guns"),
                      noProducts: int.parse(_quantityController.text));
              }
              print(chosenComponent.component.name);
              setState(() {
                _shopList = [
                  DataRow(cells: [
                    DataCell(Text(chosenComponent.component.name)),
                    DataCell(Text(chosenComponent.noProducts.toString())),
                    DataCell(Text(chosenComponent.component.price.toString())),
                    DataCell(Text(chosenComponent.totalPrice)),
                    DataCell(
                        IconButton(onPressed: () {}, icon: Icon(Icons.delete))),
                  ]),
                  ..._shopList
                ];
              });
            } else {
              print("Sper ca nu printezi");
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
    final padding = MediaQuery
        .of(context)
        .viewInsets + _kPadding;

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return AnimatedPadding(padding: padding,
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
              title: Text('Creaza deviz'),
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
              state: _currentStep > 0
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: Text('Alege data'),
              content: Center(
                  child: Column(
                    children: [
                      WeeklyDatePicker(
                        selectedDay: _selectedDay,
                        changeDay: (value) => setState(() {
                          _selectedDay = value;
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

                    ],
                  )),
            )
          ],
        ),
      ),);


  }

  DataTable _createDataTable() {
    return DataTable(
      columns: _createColumns(),
      rows: _shopList,
      dividerThickness: 5,
      dataRowHeight: 80,
      showBottomBorder: true,
      headingTextStyle:
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      headingRowColor:
      MaterialStateProperty.resolveWith((states) => Colors.black),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Component')),
      DataColumn(label: Text('Quantity')),
      DataColumn(label: Text('Price/Unit')),
      DataColumn(label: Text('Total')),
      DataColumn(label: Text('')),
    ];
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 1 ? setState(() => _currentStep += 1) : Navigator.popAndPushNamed(context, ShopsPage.route);
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : Navigator.pop(context);
  }
}
