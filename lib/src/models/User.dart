import 'package:firebase_auth/firebase_auth.dart';

class User {
  FirebaseUser fireUser;
  String id = '';
  String email = '';
  String name = '';
  String homeCurrency = '';
  String currentTrip = '';
  List<String> trips = [];
  bool isAnonymous = true;
  String currencyLastUsed; // id of the last currency they used
  String countryLastIn; // id of the country they were in at last expense
  String paymentMethodLastUsed;
  Map<String, double> userRates = {};
  Map<String, String> displayCurrencies = {};

  User();

  User.fromFirebaseUser(FirebaseUser user) {
    fireUser = user;
    id = user.uid;
    name = user?.displayName;
    email = user?.email;
  }

  User.withDemoData(String id, String name) {
    id = id;
    name = name;
    email = '$id@email.com';
    homeCurrency = 'AUD';
    trips = ['demotrip1', 'demotrip2'];
    currentTrip = 'demotrip1';
    currencyLastUsed = 'AUD';
    countryLastIn = 'au';
    paymentMethodLastUsed = 'card';
  }

  updateData(Map<String, dynamic> data) {
    homeCurrency = data['home_currency'] ?? '';
    currentTrip = data['current_trip'] ?? '';
    if (data.containsKey('user_rates')) {
      Map tmp = data['user_rates'];
      tmp.forEach(
        (k, v) => userRates[k] = double.tryParse(v.toString()) ?? 1.0,
      );
    }
    if (data.containsKey('display_currencies')) {
      Map tmp = data['display_currencies'];
      tmp.forEach((k, v) => displayCurrencies[k] = v.toString());
    }
  }
}
