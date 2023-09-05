import 'package:flutter/material.dart';

class CalendarProvider extends ChangeNotifier {
  bool _filter = false;

  bool get filter => _filter;

  set setfilter(bool value) {
    _filter = value;

    notifyListeners();
  }
}
