import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  AppState();

  int _activeTabIndex = 0;
  int get activeTabIndex => _activeTabIndex;
  set activeTabIndex(int activeTabIndex) {
    _activeTabIndex = activeTabIndex;
    notifyListeners();
  }

  bool _showQuickAddButton = true;
  bool get showQuickAddButton => _showQuickAddButton;
  set showQuickAddButton(bool showQuickAddButton) {
    _showQuickAddButton = showQuickAddButton;
    notifyListeners();
  }
}
