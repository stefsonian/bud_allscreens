import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  AppState();

  int _activeTabIndex = 0;
  int get activeTabIndex => _activeTabIndex;
  set activeTabIndex(int activeTabIndex) {
    showQuickAddButton = activeTabIndex != 2;
    showToolBar = activeTabIndex != 2;
    previousTabIndex = _activeTabIndex;
    _activeTabIndex = activeTabIndex;
    notifyListeners();
  }

  int _previousTabIndex = 0;
  int get previousTabIndex => _previousTabIndex;
  set previousTabIndex(int previousTabIndex) {
    _previousTabIndex = previousTabIndex;
    notifyListeners();
  }

  bool _showToolBar = true;
  bool get showToolBar => _showToolBar;
  set showToolBar(bool showToolBar) {
    _showToolBar = showToolBar;
    notifyListeners();
  }

  bool _showQuickAddButton = true;
  bool get showQuickAddButton => _showQuickAddButton;
  set showQuickAddButton(bool showQuickAddButton) {
    _showQuickAddButton = showQuickAddButton;
    notifyListeners();
  }
}
