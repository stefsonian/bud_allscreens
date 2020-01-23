import 'dart:async';
import 'dart:math';
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
}
