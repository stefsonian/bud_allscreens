import 'package:allscreens/src/models/Location.dart';
import 'package:allscreens/src/models/Category.dart';
import 'package:allscreens/src/models/Frozen_amount.dart';
import 'package:jiffy/jiffy.dart';

class Expense {
  DateTime creationDT = DateTime.now();
  DateTime expenseDT = DateTime.now();
  String createdBy; // user id
  FrozenAmount amount;
  MainCategory mainCategory;
  SubCategory subCategory;
  String paidBy; // user id
  Location location;
  String note = '';
  var photo; // TODO: change type to Photo
  String paymentType = '';
  String tripId = '';

  String get dayMonthYear =>
      '${expenseDT.day} ${Jiffy(expenseDT).MMM} ${expenseDT.year.toString().substring(2)}';

  List<String> get tags => note == null
      ? []
      : note.split(' ').where((w) => w.startsWith('#')).toList();
}
