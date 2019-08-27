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

  int get recordStage {
    if (!_isAmountRecorded) return 0;
    if (!_isMainCatRecorded) return 1;
    if (!_isSubCatRecorded) return 2;
    return 3;
  }

  reset() {
    _isSubCatRecorded = false;
    _isMainCatRecorded = false;
    _isAmountRecorded = false;
    notifyListeners();
  }
}
