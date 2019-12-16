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
      var subCats = sData.subcats.keys.toList();
      var subCat = subCats[x];
      e.subCategory = sData.subcats[subCat];
      e.mainCategory = sData.maincats[sData.subcats[subCat].groupId];
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
      int noteIndex = Random().nextInt(7);
      e.note = [
        '#fancydinner with text #beachday',
        'a #beachday',
        'a #coffeefix wt',
        '',
        '',
        '',
        ''
      ].elementAt(noteIndex);
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

  Map<String, double> totalByMainCat() {
    Map<String, double> result = {};
    full.forEach((e) {
      var cat = e.mainCategory.id;
      var updateAmount = e.amount.amountInHome;
      if (!result.containsKey(cat)) result[cat] = 0.0;
      result.update(cat, (current) => current + updateAmount);
    });
    return result;
  }

  Map<String, double> totalByHashtag() {
    Map<String, double> result = {};
    full.forEach((e) {
      e.tags.forEach((tag) {
        var updateAmount = e.amount.amountInHome;
        if (!result.containsKey(tag)) result[tag] = 0.0;
        result.update(tag, (current) => current + updateAmount);
      });
    });
    return result;
  }

  List<String> uniqueHashtags() {
    List<String> result = [];
    full.forEach((e) {
      e.tags.forEach((t) => result.add(t));
    });
    return result.toSet().toList();
  }
}
