import 'package:eatsleeptravel/src/helpers/utils.dart';
import 'package:eatsleeptravel/src/models/Expense.dart';
import 'package:eatsleeptravel/src/models/Trip.dart';
import 'package:eatsleeptravel/src/models/User.dart';
import 'package:flutter/foundation.dart';
import 'package:eatsleeptravel/src/models/Location.dart';
import 'package:eatsleeptravel/src/models/Category.dart';
import 'package:flutter/material.dart';

class NewExpense extends ChangeNotifier {
  String id;
  DateTime creationDT = DateTime.now();
  DateTime expenseDT = DateTime.now();
  String createdBy; // user id
  double amount;
  String currencyId;
  MainCategory mainCategory;
  SubCategory subCategory;
  String paidById; // user id
  String paidByName; // user id
  Location location;
  String note = '';
  var photo; // TODO: change type to Photo
  String paymentType = '';
  String tripId = '';
  Map<String, dynamic> split;
  Map<String, dynamic> repeat;
  bool isSplit = false;
  bool isRepeat = false;

  NewExpense();

  NewExpense.withUserandTrip({Trip trip, User user}) {
    initialise(trip: trip, user: user);
  }

  void initialise({Trip trip, User user}) {
    createdBy = user.id;
    currencyId = user.currencyLastUsed;
    paidById = user.id;
    paidByName = user.name;
    paymentType = user.paymentMethodLastUsed;
    tripId = trip.id;
    //TODO: The initial main category should be the quick/speed category

    // getLocation();
    //location
  }

  void update(String property, dynamic value) {
    switch (property) {
      case 'mainCategory':
        mainCategory = value;
        break;
      case 'subCategory':
        subCategory = value;
        break;
      case 'amount':
        amount = value;
        break;
      case 'currencyId':
        currencyId = value;
        break;
      case 'paymentType':
        paymentType = value;
        break;
      case 'note':
        note = value;
        break;
      case 'paidById':
        paidById = value;
        break;
      case 'paidByName':
        paidByName = value;
        break;
      case 'createdBy':
        createdBy = value;
        break;
      case 'tripId':
        tripId = value;
        break;
      default:
    }
    notifyListeners();
  }

  Expense asExpense() {
    final e = Expense();
  }

  void getLocation() async {
    location = await Utils().getCurrentLocation();
    notifyListeners();
  }

  String get amountAsString => amount?.toStringAsFixed(2) ?? "0.00";

  void commit() {
    // commit the expense to db
    // call reset
  }

  void reset() {
    // reset values
    // re-initialise values
  }
}
