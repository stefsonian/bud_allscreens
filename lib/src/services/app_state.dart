import 'package:eatsleeptravel/src/models/App_settings.dart';
import 'package:eatsleeptravel/src/models/New_expense.dart';
import 'package:eatsleeptravel/src/models/Trip.dart';
import 'package:eatsleeptravel/src/models/User.dart';
import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  // AppSettings _settings;
  AppState() {
    _settings.addListener(() => shareUpdate());
  }

  void shareUpdate() {
    notifyListeners();
  }

  double viewHeight;
  double viewWidth;

  AppSettings _settings = AppSettings();
  AppSettings get settings => _settings;
  Cols get cols => settings.cols;
  void changeColor(String name, Color color) =>
      settings.changeColor(name, color);

  NewExpense _newExpense;
  NewExpense get newExpense => _newExpense;
  void initaliseNewExpense(Trip trip, User user) {
    if (_newExpense != null) return;
    _newExpense = NewExpense();
    _newExpense.initialise(trip: trip, user: user);
    _newExpense.addListener(() => shareUpdate());
    // _newExpense.addListener(() => notifyListeners());
  }

  void updateNewExpense(String property, dynamic value) {
    newExpense.update(property, value);
  }

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

  String _loginStage = 'sign in';
  // String _loginStage = 'check if signed in';
  String get loginStage => _loginStage;
  set loginStage(String loginStage) {
    _loginStage = loginStage;
    notifyListeners();
  }
}
