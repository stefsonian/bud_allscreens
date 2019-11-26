import 'dart:math';
import 'package:allscreens/src/models/Expense.dart';
import 'package:allscreens/src/models/Frozen_amount.dart';
import 'package:allscreens/src/models/Location.dart';
import 'package:allscreens/src/services/session_data.dart';
import 'package:flutter/material.dart';

class Records with ChangeNotifier {
  Records();
  List<Expense> _full = [];
  List<Expense> get full => _full;

  void addRecord(Expense expense) {
    _full.add(expense);
    notifyListeners();
  }

  double get totalAmount =>
      _full.fold(0.0, (curr, next) => curr + next.amount.value);

  void createTestData(int n) {
    final sData = SessionData.withCatsOnly();
    for (var i = 0; i < n; i++) {
      var e = Expense();
      var x = Random().nextInt(sData.subcats.length);
      var subCat = sData.subcats[x];
      var mainCat =
          sData.maincats.singleWhere((cat) => cat.id == subCat.groupId);
      e.subCategory = subCat;
      e.mainCategory = mainCat;
      var amount = Random().nextDouble() * 100;
      var fa = FrozenAmount.withTestData(amount);
      e.amount = fa;
      e.createdBy = 'Stefan';
      e.paidBy = 'Stefan';
      var location = Location.withDemoData();
      e.location = location;
      e.note = 'A quick note';
      e.paymentType = ['Cash', 'Credit', 'Debit'][Random().nextInt(2)];
      e.tripId = 'demo trip';
      _full.add(e);
    }
    notifyListeners();
  }
}
