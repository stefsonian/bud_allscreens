import 'dart:math';
import 'package:allscreens/src/models/Expense.dart';
import 'package:allscreens/src/models/Frozen_amount.dart';
import 'package:allscreens/src/models/Location.dart';
import 'package:allscreens/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class Records with ChangeNotifier {
  List<Expense> _full = [];
  List<Expense> get full => _full;

  Records();

  void createTestData(int n, int start, int end) {
    final sData = SessionData.withCatsOnly();
    for (var i = 0; i < n; i++) {
      var e = Expense();
      var y = Random().nextInt(start + end) - start;
      e.expenseDT = DateTime.now().add(Duration(days: y));
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

  void addRecord(Expense expense) {
    _full.add(expense);
    notifyListeners();
  }

  double get totalAmount =>
      _full.fold(0.0, (curr, next) => curr + next.amount.value);

  List<Expense> expensesOnDate(DateTime date) {
    DateTime dStart = Jiffy(date).startOf('day');
    DateTime dEnd = Jiffy(date).endOf('day');
    return _full
        .where((e) =>
            e.expenseDT.compareTo(dStart) >= 0 &&
            e.expenseDT.compareTo(dEnd) <= 0)
        .toList();
  }
}
