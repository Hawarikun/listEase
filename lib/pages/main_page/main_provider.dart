import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  final PageController _pageController = PageController();

  PageController get pageController => _pageController;
  int _currentIndex = 0;
  bool _showBottomSheet = false;

  int get currentIndex => _currentIndex;
  bool get showBottomSheet => _showBottomSheet;

  set changeShowBottomSheet(bool value) {
    _showBottomSheet = value;
    notifyListeners();
  }

  void changeIndex(int index) {
    _currentIndex = index;
    _pageController.jumpToPage(index);
    notifyListeners();
  }
}
