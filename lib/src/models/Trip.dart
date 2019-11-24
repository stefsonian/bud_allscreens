import 'package:allscreens/src/models/Member.dart';

class Trip {
  var id, budgetCurrency, name = '';
  var startDT, endDT = DateTime.now();
  var budgetAmount = 0.0;
  List<Member> members = []; //TODO: make this a list of Member
}
