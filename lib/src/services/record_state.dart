import 'package:eatsleeptravel/src/models/New_expense.dart';
import 'package:eatsleeptravel/src/models/Numpad_input.dart';
import 'package:eatsleeptravel/src/models/Trip.dart';
import 'package:eatsleeptravel/src/models/User.dart';
import 'package:flutter/material.dart';

class RecordState with ChangeNotifier {
  RecordState();

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

  NewExpense _newExpense = NewExpense();
  NewExpense get newExpense => _newExpense;
  void initaliseNewExpense(Trip trip, User user) {
    if (_newExpense != null) return;
    _newExpense = NewExpense();
    _newExpense.initialise(trip: trip, user: user);
    // _newExpense.addListener(() => shareUpdate());
    notifyListeners();
    // _newExpense.addListener(() => notifyListeners());
  }

  void updateNewExpense(String property, dynamic value) {
    newExpense.update(property, value);
    notifyListeners();
  }

  reset() {
    notifyListeners();
  }
}
