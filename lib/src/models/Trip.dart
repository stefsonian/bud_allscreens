import 'package:allscreens/src/models/User.dart';
import 'package:jiffy/jiffy.dart';
import 'package:allscreens/src/models/Member.dart';

class Trip {
  String id, budgetCurrency, name = '';
  DateTime startDT, endDT = DateTime.now();
  double budgetAmount = 0.0;
  List<Member> members = [];

  Trip() {}

  Trip.withDemoData(String id, String name, List<User> users) {
    id = id;
    name = name;
    var d1 = DateTime.now().subtract(Duration(days: 30));
    var d2 = DateTime.now().add(Duration(days: 60));
    startDT = Jiffy(d1).startOf('day');
    endDT = Jiffy(d2).endOf('day');
    budgetAmount = 90 * 100.0;
    budgetCurrency = 'AUD';
    users.forEach((u) => members.add(Member.withDemoData(u.id)));
  }

  List<String> get memberIds => members.map((m) => m.userId).toList();
}
