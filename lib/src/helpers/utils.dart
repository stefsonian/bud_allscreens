import 'dart:async';
import 'dart:math';
import 'package:eatsleeptravel/src/models/Category.dart';
import 'package:eatsleeptravel/src/models/Expense.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

import 'package:eatsleeptravel/src/models/Location.dart';

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
    sessionData.initialiseUserCurrentTrip();
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
}
