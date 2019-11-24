import 'package:allscreens/src/models/Location.dart';
import 'package:allscreens/src/models/MainCategory.dart';
import 'package:allscreens/src/models/SubCategory.dart';
import 'package:allscreens/src/models/frozen_amount.dart';

class Expense {
  var creationDT = DateTime.now();
  DateTime expenseDT;
  String createdBy; // user id
  FrozenAmount amount;
  MainCategory mainCategory;
  SubCategory subCategory;
  String paidBy; // user id
  Location location;
  var note = '';
  var photo; // TODO: change type to Photo
  var paymentType = '';
}
