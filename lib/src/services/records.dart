import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatsleeptravel/src/helpers/utils.dart';
import 'package:eatsleeptravel/src/models/Category.dart';
import 'package:eatsleeptravel/src/models/Currency.dart';
import 'package:eatsleeptravel/src/models/Expense.dart';
import 'package:eatsleeptravel/src/models/Frozen_amount.dart';
import 'package:eatsleeptravel/src/models/Location.dart';
import 'package:eatsleeptravel/src/models/User.dart';
import 'package:eatsleeptravel/src/services/firestore_service.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiffy/jiffy.dart';

class Records with ChangeNotifier {
  // FirestoreService firestore = FirestoreService();
  List<Expense> _full = [];
  List<Expense> get full => _full;
  Map<String, MainCategory> maincats;
  Map<String, SubCategory> subcats;
  List<Currency> currencies;
  Map<DateTime, Map<String, double>> xrates = {};
  bool isInitCurrencies = false;
  bool isInitExchangeRates = false;
  bool isInitFull = false;

  bool get isInitialisationComplete =>
      isInitCurrencies && isInitExchangeRates && isInitFull;

  String _currentTripId = '';
  String get currentTripId => _currentTripId;
  set currentTripId(String currentTripId) {
    _currentTripId = currentTripId;
    initialiseRecords();
    notifyListeners();
  }

  Records();

  Future<void> initialiseCurrencies() async {
    WidgetsFlutterBinding.ensureInitialized();
    List<Currency> tmp = [];
    String data = await rootBundle.loadString('assets/currencies.json');

    Map currencyMap = json.decode(data);
    currencyMap.forEach((k, v) => tmp.add(Currency.fromMap({k: v})));
    tmp.sort((Currency a, Currency b) => a.id.compareTo(b.id));
    currencies = List.unmodifiable(tmp);
    if (!isInitCurrencies) isInitCurrencies = true;
  }

  void initialiseExchangeRates() {
    Firestore.instance.collection('xrates').snapshots().listen((data) {
      // var count = 0;
      data.documents.forEach((doc) {
        final docData = Map<String, dynamic>.from(doc.data);
        final timestamp = docData['timestamp'] ?? DateTime.now();
        final timestampDT = Utils().timestampToDate(timestamp);
        docData.remove('timestamp');
        xrates[timestampDT] = {};
        docData.forEach((k, v) {
          double rate;
          if (v.runtimeType is double) {
            rate = v;
          } else {
            rate = double.tryParse(v.toString()) ?? 1.0;
          }
          xrates[timestampDT][k.toLowerCase()] = rate;
        });
        // print('added exchange rate number $count');
        // count++;
      });
      if (!isInitExchangeRates) isInitExchangeRates = true;
    }).onError((err) => print(err.toString()));
  }

  void initialiseRecords() async {
    if (currentTripId.isEmpty) {
      if (!isInitFull) isInitFull = true;
      return;
    }

    // wait for data needed to create expense record objects
    var attempts = 0;
    while (attempts < 100 && !isInitExchangeRates) {
      await Future.delayed(Duration(milliseconds: 50));
      attempts++;
    }

    if (attempts >= 100) {
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
        final Timestamp timestamp = doc.data['creation_dt'];
        final timestampDT = timestamp.toDate();
        final xrateDate =
            Utils().getClosestDateBefore(timestampDT, xrates.keys.toList());
        Map<String, double> usdRates = xrates[xrateDate];
        MainCategory mc = maincats[data['main_category']];
        SubCategory sc = subcats[data['sub_category']];
        newExpenses.add(Expense.fromFirestoreData(
          expenseId: doc.documentID,
          data: data,
          mainCat: mc,
          subCat: sc,
          usdRates: usdRates,
        ));
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
      print(
          'Records | attempt: $attempts, is init complete: $isInitialisationComplete');
      if (isInitialisationComplete) {
        completer.complete(true);
        t.cancel();
      }
      if (attempts == 120) {
        completer.complete(false);
        t.cancel();
      }
    });
    return completer.future;
  }

  void addRecord(Expense expense) {
    _full.add(expense);
    notifyListeners();
  }

  double get totalAmount => _full.fold(
      0.0,
      (curr, next) =>
          curr + next.getAmount('aud')); //TODO change to add currency parameter

  List<Expense> expensesOnDate(DateTime date) {
    DateTime dStart = Jiffy(date).startOf('day');
    DateTime dEnd = Jiffy(date).endOf('day');
    return _full
        .where((e) =>
            e.expenseDT.compareTo(dStart) >= 0 &&
            e.expenseDT.compareTo(dEnd) <= 0)
        .toList();
  }

  Map<String, double> totalByMainCat({
    String currencyId,
    DateTime start,
    DateTime end,
  }) {
    Map<String, double> result = {};
    full
        .where((e) => e.expenseDT.isAfter(start) && e.expenseDT.isBefore(end))
        .forEach((e) {
      var cat = e.mainCategory.id;
      var updateAmount = e.getAmount(currencyId);
      if (!result.containsKey(cat)) result[cat] = 0.0;
      result.update(cat, (current) => current + updateAmount);
    });
    return result;
  }

  Map<String, double> totalByHashtag({
    String currencyId,
    DateTime start,
    DateTime end,
  }) {
    Map<String, double> result = {};
    full
        .where((e) => e.expenseDT.isAfter(start) && e.expenseDT.isBefore(end))
        .forEach((e) {
      e.tags.forEach((tag) {
        var updateAmount = e.getAmount(currencyId);
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

  Map<String, double> latestXrates() {
    var rateDates = xrates.keys.toList();
    rateDates.sort();
    return xrates[rateDates.last];
  }

  String get latestPaymentType =>
      _full.isEmpty ? 'cash' : _full.last.paymentType;

  String get latestCurrencyId => _full.isEmpty ? 'eur' : _full.last.currencyId;

  double get maxAmountInHomeCur => _full
      .map((e) => e.getAmount('eur'))
      .reduce(max); //TODO change to add currency parameter

  Currency getCurrency(String curId) {
    var index = currencies.indexWhere((c) => c.id == curId);
    return currencies[index];
  }

  Currency someCurrency(String curId) {
    Currency cur;
    cur = currencies[5];
    return cur;
  }

  Map<DateTime, List<Expense>> groupedByDay({
    DateTime start,
    DateTime end,
    bool includeEmptyDays = true,
  }) {
    final numDays = end.difference(start).inDays;
    Map<DateTime, List<Expense>> result = {};
    for (var i = 0; i <= numDays; i++) {
      final d = start.add(Duration(days: i));
      result[d] =
          _full.where((e) => Jiffy(e.expenseDT).isSame(d, 'day')).toList();
      if (!includeEmptyDays && result[d].isEmpty) result.remove(d);
    }
    return result;
  }

  List<Currency> recentlyUsedCurrencies() {
    var now = DateTime.now();
    var candidates = full
        .where((e) => e.expenseDT.isAfter(now.subtract(Duration(days: 30))))
        .toList();
    var curIdList = candidates.map((e) => e.currencyId).toSet().toList();
    return curIdList.map((c) => getCurrency(c)).toList();
  }
}
