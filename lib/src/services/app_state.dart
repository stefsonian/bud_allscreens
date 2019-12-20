import 'package:allscreens/src/models/App_settings.dart';
import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  // AppSettings _settings;
  AppState() {
    _settings.addListener(() => shareUpdate());
  }

  shareUpdate() {
    notifyListeners();
  }

  AppSettings _settings = AppSettings();
  AppSettings get settings => _settings;
  Cols get cols => settings.cols;
  void changeColor(String name, Color color) =>
      settings.changeColor(name, color);
  // set settings(AppSettings settings) {
  //   _settings = settings;
  //   notifyListeners();
  // }

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
