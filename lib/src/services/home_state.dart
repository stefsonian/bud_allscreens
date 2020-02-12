import 'package:eatsleeptravel/src/models/Currency.dart';
import 'package:flutter/material.dart';

class HomeState with ChangeNotifier {
  HomeState();

  String _currencyPickerValue = '';
  String get currencyPickerValue => _currencyPickerValue;
  set currencyPickerValue(String currencyPickerValue) {
    _currencyPickerValue = currencyPickerValue;
    notifyListeners();
  }

  reset() {
    // reset values
    notifyListeners();
  }
}
