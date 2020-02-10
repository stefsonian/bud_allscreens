import 'package:flutter/material.dart';

class HomeState with ChangeNotifier {
  HomeState();

  String _currencyPickerValue = '';
  String get currencyPickerValue => _currencyPickerValue;
  set currencyPickerValue(String currencyPickerValue) {
    _currencyPickerValue = currencyPickerValue;
    notifyListeners();
  }

  String pete = '';

  reset() {
    // reset values
    notifyListeners();
  }
}
