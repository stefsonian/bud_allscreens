import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatsleeptravel/src/front/manage_trip/manage_trip_model.dart';
import 'package:eatsleeptravel/src/models/User.dart';
import 'package:jiffy/jiffy.dart';
import 'package:eatsleeptravel/src/models/Member.dart';

class Trip {
  String id, budgetType, name, creator = '';
  String budgetCurrency = 'aud';
  DateTime creationDT = DateTime.now();
  DateTime startDT = DateTime.now();
  DateTime endDT = DateTime.now();
  double budgetAmount = 0.0;
  List<Member> members = [];
  Map<dynamic, dynamic> roles = {};

  Trip();

  Trip.fromFirestoreData(String tripId, Map<String, dynamic> data) {
    Timestamp dataStartDT = data['start_dt'] ?? null;
    Timestamp dataEndDT = data['end_dt'] ?? null;
    Timestamp dataCreationDT = data['creation_dt'] ?? null;
    var dataBudgetAmount = data['budget_amount'] ?? 0;
    id = tripId ?? '';
    creator = data['creator'] ?? '';
    budgetCurrency = data['budget_currency'] ?? 'aud';
    budgetType = data['budget_type'] ?? 'day';
    name = data['name'] ?? '';
    roles = data['roles'] ?? {};
    startDT = dataStartDT == null
        ? startDT
        : DateTime.fromMillisecondsSinceEpoch(
            dataStartDT.millisecondsSinceEpoch);
    endDT = dataEndDT == null
        ? endDT
        : DateTime.fromMillisecondsSinceEpoch(dataEndDT.millisecondsSinceEpoch);
    creationDT = dataCreationDT == null
        ? creationDT
        : DateTime.fromMillisecondsSinceEpoch(
            dataCreationDT.millisecondsSinceEpoch);
    budgetAmount = double.tryParse(dataBudgetAmount.toString());
  }

  updateFromManageTrip(ManageTripModel data) {
    id = data.tripId;
    name = data.name;
    budgetAmount = double.tryParse(data.budgetAmount) ?? 1.0;
    budgetCurrency = data.budgetCurrency;
    budgetType = data.budgetType;
    startDT = data.startDate;
    endDT = data.endDate;
  }

  Map<String, dynamic> toFirestoreMap() {
    Map<String, dynamic> t = {};
    t['creation_dt'] = creationDT;
    t['start_dt'] = startDT;
    t['end_dt'] = endDT;
    t['creator'] = creator;
    t['budget_amount'] = budgetAmount;
    t['budget_currency'] = budgetCurrency;
    t['budget_type'] = budgetType;
    t['name'] = name;
    t['roles'] = roles;
    return t;
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
