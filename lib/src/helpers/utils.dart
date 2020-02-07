import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatsleeptravel/src/models/Category.dart';
import 'package:eatsleeptravel/src/models/Expense.dart';
import 'package:eatsleeptravel/src/services/firestore_service.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

import 'package:eatsleeptravel/src/models/Location.dart';
import 'package:jiffy/jiffy.dart';

class Utils {
  List<Map<String, double>> sortMapByDoubleValue(
      {Map<String, double> m, descending = true}) {
    List<Map<String, double>> result = [];
    var keys = m.keys.toList();
    List<double> vals = m.values.toList();
    int listLength = vals.length;
    for (var i = 0; i < listLength; i++) {
      var maxVal = descending ? vals.reduce(max) : vals.reduce(min);
      var maxIndex = vals.indexOf(maxVal);
      result.add({keys[maxIndex]: vals[maxIndex]});
      keys.removeAt(maxIndex);
      vals.removeAt(maxIndex);
    }
    return result;
  }

  Future<Location> getCurrentLocation() async {
    Location location = Location();
    // var position = await Geolocator().getCurrentPosition();

    return location;
  }

  Future<void> completeAppInitialisation(FirebaseUser currentUser,
      SessionData sessionData, Records records) async {
    Completer completer = Completer();
    sessionData.initialiseUserFromFirebaseUser(currentUser);
    sessionData.initialiseTrips();
    sessionData.updateUserData();
    await sessionData.completeIntialisation();
    records.maincats = sessionData.maincats;
    records.subcats = sessionData.subcats;
    records.currentTripId = sessionData.user.currentTrip;
    records.initialiseRecords();
    await records.completeIntialisation();
    completer.complete();
    print('all init is complete');
    return completer.future;
  }

  List<String> getSmartCategories(List<Expense> expenses, int n) {
    // get the sub category ids of the weighted top n expenses by sub category
    final defaultList = [
      'breakfast',
      'lunch',
      'dinner',
      'hostel',
      'hotel',
      'bus',
      'train',
      'groceries',
      'cafe',
      'flight',
      'tour',
      'market',
      'laundry',
    ]; // TODO: maybe use categories from session data here instead of hardcode

    // first deal with corner cases
    if (expenses.isEmpty) return defaultList.take(8).toList();

    // then deal with normal cases
    final now = DateTime.now();
    Map<String, double> points = {};
    expenses.forEach((e) {
      final String subcatId = e.subCategory.id;
      // the more recent the expense, the higher the score
      final double score =
          1.0 + 2.0 / (1.0 + now.difference(e.expenseDT).inDays.abs());
      if (!points.containsKey(subcatId)) points[subcatId] = 0;
      points[subcatId] = points[subcatId] + score;
    });

    // sort scores in descending order and store the score of the nth entry (where possible)
    final List<double> scores = points.values.toList()
      ..sort((a, b) => b.compareTo(a));
    final double cutoffScore = scores[min((n - 1), (scores.length - 1))];
    points.removeWhere((k, v) => v < cutoffScore);

    // if less than n entries then add from defaultList
    var idx = 0;
    while ((points.length < n) && (idx < defaultList.length)) {
      final newEntry = defaultList[idx];
      if (!points.containsKey(newEntry)) {
        points[newEntry] = 1.0;
      }
      idx++;
    }

    // return top n sub categories
    return points.keys.take(n).toList();
  }

  String shortDate(DateTime date) {
    // if within the last 6 days, return day (eg 'Wed'). Else return date (eg 27 Jan)
    final weekBefore = DateTime.now().subtract(Duration(days: 6));
    if (Jiffy(date).isSameOrAfter(weekBefore, 'day')) return Jiffy(date).E;
    return '${date.day}\n${Jiffy(date).MMM}';
  }

  DateTime getClosestDateBefore(DateTime date, List<DateTime> candidateDates) {
    // get the closest candidate-date to the date (that's still before the date)
    DateTime result;
    final List<DateTime> candidates = [];
    candidates.addAll(candidateDates);
    candidates.sort((a, b) => b.compareTo(a)); // sort desc
    result = candidates.first;
    candidates.forEach((c) {
      if (result.isAfter(date)) result = c;
    });
    return result;
  }

  double convertAmount({
    double amount,
    String fromCurrency,
    String toCurrency,
    Map<String, double> xRates,
  }) {
    final double fromRate = xRates[fromCurrency] ?? 1.0;
    final double toRate = xRates[toCurrency] ?? 1.0;
    final double amountInUsd = amount / fromRate;
    return amountInUsd * toRate;
  }

  DateTime timestampToDate(Timestamp t) {
    return DateTime.fromMillisecondsSinceEpoch(t.millisecondsSinceEpoch);
  }
}

// fixFirestoreCurrencies() async {
//   var start = DateTime.now().subtract(Duration(days: 1));
//   var firestore = FirestoreService();
//   QuerySnapshot qsnap = await firestore.getExchangeRates(start: start);
//   var doc = qsnap.documents.first;
//   Map<String, dynamic> rates = doc.data;
//   for (var i = 90; i > 0; i--) {
//     Map<String, dynamic> newRates = {};
//     newRates.addAll(rates);
//     var newTime = Jiffy(DateTime.now().subtract(Duration(days: i)).toUtc())
//         .startOf('day')
//         .toUtc();
//     newRates['timestamp'] = newTime;
//     newRates.updateAll((k, v) =>
//         k == 'timestamp' ? v : v + (Random().nextDouble() / 10 - 0.05));
//     print('${newTime.toString()}: ${newRates['AUD']}');
//     await firestore.fire.collection('xrates').add(newRates);
//   }
// }
