import 'package:flutter/material.dart';

class HomeState with ChangeNotifier {
  HomeState();

  double _dayBudget = 200;
  double get dayBudget => _dayBudget;
  set dayBudget(double dayBudget) {
    _dayBudget = dayBudget;
    notifyListeners();
  }

  double _daySpend = 140;
  double get daySpend => _daySpend;
  set daySpend(double daySpend) {
    _daySpend = daySpend;
    notifyListeners();
  }

  reset() {
    // reset values
    notifyListeners();
  }
}
