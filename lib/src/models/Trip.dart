import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatsleeptravel/src/models/User.dart';
import 'package:jiffy/jiffy.dart';
import 'package:eatsleeptravel/src/models/Member.dart';

class Trip {
  String id, budgetCurrency, budgetType, name = '';
  DateTime startDT, endDT = DateTime.now();
  double budgetAmount = 0.0;
  List<Member> members = [];

  Trip() {}

  Trip.fromFirestoreData(String tripId, Map<String, dynamic> data) {
    Timestamp dataStartDT = data['start_dt'] ?? null;
    Timestamp dataEndDT = data['end_dt'] ?? null;
    var dataBudgetAmount = data['budget_amount'] ?? 0;
    id = tripId ?? '';
    budgetCurrency = data['budget_currency'] ?? 'aud';
    budgetType = data['budget_type'] ?? 'day';
    name = data['name'] ?? '';
    startDT = dataStartDT == null
        ? startDT
        : DateTime.fromMillisecondsSinceEpoch(
            dataStartDT.millisecondsSinceEpoch);
    endDT = dataEndDT == null
        ? endDT
        : DateTime.fromMillisecondsSinceEpoch(dataEndDT.millisecondsSinceEpoch);
    budgetAmount = double.tryParse(dataBudgetAmount.toString());
  }

  Trip.withDemoData(String id, String name, List<User> users) {
    this.id = id;
    this.name = name;
    var d1 = DateTime.now().subtract(Duration(days: 30));
    var d2 = DateTime.now().add(Duration(days: 60));
    startDT = Jiffy(d1).startOf('day');
    endDT = Jiffy(d2).endOf('day');
    budgetAmount = 100.0;
    budgetCurrency = 'AUD';
    users.forEach((u) => members.add(Member.withDemoData(u.id)));
  }

  List<String> get memberIds => members.map((m) => m.userId).toList();

  String get startDayMonth => '${startDT.day} ${Jiffy(startDT).MMM}';
  String get endDayMonth => '${endDT.day} ${Jiffy(endDT).MMM}';
  int get travelDay => DateTime.now().difference(startDT).inDays;
  int get daysInTrip => endDT.difference(startDT).inDays;
}
