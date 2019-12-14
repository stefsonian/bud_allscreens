import 'package:allscreens/src/models/Numpad_input.dart';
import 'package:flutter/material.dart';

class RecordState with ChangeNotifier {
  RecordState();

  bool _isAmountRecorded = false;
  bool get isAmountRecorded => _isAmountRecorded;
  set isAmountRecorded(bool isAmountRecorded) {
    _isAmountRecorded = isAmountRecorded;
    notifyListeners();
  }

  bool _isMainCatRecorded = false;
  bool get isMainCatRecorded => _isMainCatRecorded;
  set isMainCatRecorded(bool mainCatRecorded) {
    _isMainCatRecorded = mainCatRecorded;
    notifyListeners();
  }

  bool _isSubCatRecorded = false;
  bool get isSubCatRecorded => _isSubCatRecorded;
  set isSubCatRecorded(bool subCatRecorded) {
    _isSubCatRecorded = subCatRecorded;
    notifyListeners();
  }

  bool get isCategoriesRecorded => _isMainCatRecorded && _isSubCatRecorded;

  int _recordStage = 0;
  int get recordStage => _recordStage;
  set recordStage(int recordStage) {
    _recordStage = recordStage;
    notifyListeners();
  }

  NumpadInput _numpad = NumpadInput();
  NumpadInput get numpad => _numpad;
  String get numpadValue => numpad.displayValue();
  updateNumpadValue(String value) {
    numpad.updateValue(value);
    print('New numpad value: ${numpad.displayValue()}');
    notifyListeners();
  }

  // int get recordStage {
  //   if (!_isAmountRecorded) return 1;
  //   if (!_isMainCatRecorded) return 2;
  //   if (!_isSubCatRecorded) return 3;
  //   return 1;
  // }

  reset() {
    _isSubCatRecorded = false;
    _isMainCatRecorded = false;
    _isAmountRecorded = false;
    notifyListeners();
  }
}
