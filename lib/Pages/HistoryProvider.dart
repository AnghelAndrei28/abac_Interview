import 'package:flutter/material.dart';
import 'package:interview/Pages/History.dart';

class HistoryProvider extends ChangeNotifier {
  List<History> _historyList = [];

  void addElement(History element) {
    _historyList.add(element);
    notifyListeners();
  }

  int getLength() {
    return _historyList.length;
  }

  List<History> getList() {
    return _historyList;
  }
}