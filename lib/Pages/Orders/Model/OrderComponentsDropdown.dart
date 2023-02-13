import '../../Components/Model/Components.dart';

class OrderComponentsDropdown {
  static List<String> componentsList = [];

  static void setElements(
      List<Components> components) {
    componentsList = [];
    for(Components element in components) {
      componentsList.add("${element.name} - ${element.price} \$");
    }
  }
}
