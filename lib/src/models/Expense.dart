import 'package:allscreens/src/models/Location.dart';
import 'package:allscreens/src/models/MainCategory.dart';
import 'package:allscreens/src/models/SubCategory.dart';
import 'package:allscreens/src/models/Frozen_amount.dart';

class Expense {
  var creationDT = DateTime.now();
  DateTime expenseDT = DateTime.now();
  String createdBy; // user id
  FrozenAmount amount;
  MainCategory mainCategory;
  SubCategory subCategory;
  String paidBy; // user id
  Location location;
  var note = '';
  var photo; // TODO: change type to Photo
  var paymentType = '';
  var tripId = '';
}
