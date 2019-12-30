import 'package:allscreens/src/helpers/utils.dart';
import 'package:allscreens/src/models/Trip.dart';
import 'package:allscreens/src/models/User.dart';
import 'package:flutter/foundation.dart';
import 'package:allscreens/src/models/Location.dart';
import 'package:allscreens/src/models/Category.dart';
import 'package:flutter/material.dart';

class NewExpense extends ChangeNotifier {
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

  void initialise({Trip trip, User user}) {
    createdBy = user.id;
    currencyId = user.currencyLastUsed;
    paidById = user.id;
    paidByName = user.name;
    paymentType = user.paymentMethodLastUsed;
    tripId = trip.id;
    mainCategory = MainCategory(id: 'eat', name: 'Eat', icon: Icons.restaurant);
    //TODO: The initial main category should be the quick/speed category

    getLocation();
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
      default:
    }
    notifyListeners();
  }

  void getLocation() async {
    location = await Utils().getCurrentLocation();
    notifyListeners();
  }

  void commit() {
    // commit the expense to db
    // call reset
  }

  void reset() {
    // reset values
    // re-initialise values
  }
}
