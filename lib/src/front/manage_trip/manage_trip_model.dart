import 'package:intl/intl.dart';
import 'package:eatsleeptravel/src/models/Trip.dart';
import 'package:jiffy/jiffy.dart';

class ManageTripModel {
  String tripId;
  String budgetType = 'day';
  String name = '';
  String budgetAmount = '';
  String budgetCurrency;
  DateTime startDate;
  DateTime endDate;
  DateFormat formatter = DateFormat('dd MMM yyyy');

  ManageTripModel() {
    final now = DateTime.now();
    startDate = Jiffy(now).startOf('day');
    endDate = Jiffy(now).startOf('day');
  }

  ManageTripModel.withTripData(Trip trip) {
    if (trip.id != null) tripId = trip.id;
    name = trip.name;
    budgetAmount = trip.budgetAmount.toStringAsFixed(2);
    budgetCurrency = trip.budgetCurrency;
    startDate = trip.startDT;
    endDate = trip.endDT;
  }

  String get startDateString => formatter.format(startDate);
  String get endDateString => formatter.format(endDate);
}
