import 'package:intl/intl.dart';
import 'package:eatsleeptravel/src/models/Trip.dart';

class ManageTripModel {
  String tripId;
  String name = '';
  String budgetAmount = '';
  String budgetCurrency;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateFormat formatter = DateFormat('dd MMM yyyy');

  ManageTripModel();

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
