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

  isReadyForCommit() {
    var valid = true;
    if (budgetType == null || budgetType.isEmpty) valid = false;
    if (name == null || name.isEmpty) valid = false;
    if (budgetAmount == null || budgetAmount.isEmpty) valid = false;
    if (budgetCurrency == null || budgetCurrency.isEmpty) valid = false;
    if (startDate == null) valid = false;
    if (endDate == null) valid = false;
    return valid;
  }
}
