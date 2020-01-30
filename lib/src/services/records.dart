import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatsleeptravel/src/models/Category.dart';
import 'package:eatsleeptravel/src/models/Expense.dart';
import 'package:eatsleeptravel/src/models/Frozen_amount.dart';
import 'package:eatsleeptravel/src/models/Location.dart';
import 'package:eatsleeptravel/src/services/firestore_service.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class Records with ChangeNotifier {
  FirestoreService firestore = FirestoreService();
  List<Expense> _full = [];
  List<Expense> get full => _full;
  Map<String, MainCategory> maincats;
  Map<String, SubCategory> subcats;
  bool isInitFull = false;

  bool get isInitialisationComplete => isInitFull;

  String _currentTripId = '';
  String get currentTripId => _currentTripId;
  set currentTripId(String currentTripId) {
    _currentTripId = currentTripId;
    // if (_currentTripId.isNotEmpty) {
    //   initialiseRecords();
    // }
    notifyListeners();
  }

  Records();

  void initialiseRecords() {
    if (currentTripId.isEmpty) {
      // only retrieve records if trip exists
      if (!isInitFull) isInitFull = true;
      return;
    }

    Firestore.instance
        .collection('trips/$currentTripId/expenses')
        .orderBy('creation_dt')
        .snapshots()
        .listen((data) {
      List<Expense> newExpenses = [];
      data.documents.forEach((doc) {
        final data = doc.data;
        MainCategory mc = maincats[data['main_category']];
        SubCategory sc = subcats[data['sub_category']];
        newExpenses.add(Expense.fromFirestoreData(
            expenseId: doc.documentID, data: data, mainCat: mc, subCat: sc));
        // print('expense added: ${doc.documentID}');
      });
      _full = newExpenses;
      notifyListeners();
      if (!isInitFull) isInitFull = true;
    }).onError((err) => print(err.toString()));
  }

  Future<bool> completeIntialisation() async {
    Completer<bool> completer = Completer();
    var attempts = 0;
    Timer.periodic(Duration(milliseconds: 50), (Timer t) {
      attempts += 1;
      // print('attempt: $attempts, is init complete: $isInitialisationComplete');
      if (isInitialisationComplete) {
        completer.complete(true);
        t.cancel();
      }
      if (attempts == 100) {
        completer.complete(false);
        t.cancel();
      }
    });
    return completer.future;
  }

  void createTestData(String tripId, int n, int start, int end) {
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
      e.tripId = tripId;
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

  Future createFirestoreTestData(String tripId) async {
    return Future.wait(_full
        .map((e) => firestore.createExpense(tripId: tripId, expense: e))
        .toList());
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

  String get latestPaymentType =>
      _full.isEmpty ? 'cash' : _full.last.paymentType;
  String get latestCurrencyId =>
      _full.isEmpty ? 'eur' : _full.last.amount.currency;
}
