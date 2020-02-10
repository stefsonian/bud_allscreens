import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatsleeptravel/src/models/Expense.dart';
import 'package:eatsleeptravel/src/models/Trip.dart';
// import 'package:flutter/foundation.dart';

class FirestoreService {
  final fire = Firestore.instance;

  // Create expense
  Future<DocumentReference> createExpense({String tripId, Expense expense}) {
    return fire
        .collection('trips/$tripId/expenses')
        .add(expense.toFirestoreMap());
  }

  Future<DocumentReference> createTrip({String userId, Trip trip}) {
    return fire.collection('trips').add(trip.toFirestoreMap());
  }

  Future<void> updateExistingTrip({Trip trip}) {
    return fire
        .collection('trips')
        .document(trip.id)
        .setData(trip.toFirestoreMap());
  }

  Future<void> setUserCurrentTrip({String userId, String tripId}) {
    return fire
        .collection('users')
        .document(userId)
        .setData({'current_trip': tripId}, merge: true);
  }

  Future<QuerySnapshot> getExchangeRates({DateTime start}) {
    return fire
        .collection('xrates')
        .where('timestamp', isGreaterThanOrEqualTo: start)
        .getDocuments();
  }

  Future<DocumentSnapshot> getUserData({String userId}) {
    return fire.collection('users').document(userId).get();
  }

  Future<void> setUserHomeCurrency({String userId, String currencyId}) {
    return fire
        .collection('users')
        .document(userId)
        .setData({'home_currency': currencyId}, merge: true);
  }

  Future<void> setUserCurrencyValue({
    String userId,
    String currencyId,
    double usdRate,
  }) {
    return fire.collection('users').document(userId).setData({
      'currencies': {currencyId: usdRate}
    }, merge: true);
  }

  Future<void> resetUserCurrencyValues({String userId}) {
    return fire
        .collection('users')
        .document(userId)
        .setData({'currencies': null}, merge: true);
  }

  Future<QuerySnapshot> getUserTrips({String userId}) {
    return fire
        .collection('trips')
        .where('roles.$userId', isGreaterThan: '')
        .getDocuments();
  }
}
