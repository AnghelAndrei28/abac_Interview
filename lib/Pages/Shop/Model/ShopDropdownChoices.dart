import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:interview/Pages/Shop/View/ShopElement.dart';

import '../../Components/Model/Components.dart';

class ShopDropdownChoices {
  static List<String> componentsList = [];

  static void setElements(
      List<Components> components) {
    for(Components element in components) {
      componentsList.add("${element.name} - ${element.price}\$");
    }
  }
}
