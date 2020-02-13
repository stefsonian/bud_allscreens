import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatsleeptravel/src/helpers/utils.dart';
import 'package:eatsleeptravel/src/models/Location.dart';
import 'package:eatsleeptravel/src/models/Category.dart';
import 'package:eatsleeptravel/src/models/New_expense.dart';
import 'package:eatsleeptravel/src/models/User.dart';
import 'package:jiffy/jiffy.dart';

class Expense {
  DateTime creationDT = DateTime.now();
  DateTime expenseDT = DateTime.now();
  String createdBy; // user id
  MainCategory mainCategory;
  SubCategory subCategory;
  String paidBy; // user id
  Location location;
  String note = '';
  var photo; // TODO: change type to Photo
  String paymentType = '';
  String tripId = '';
  String id;
  String currencyId;
  double amount;
  String homeCurrency;
  Map<String, double> userRates = {};
  Map<String, double> xRates = {};

  Expense();

  Expense.fromFirestoreData(
      {String expenseId,
      Map<String, dynamic> data,
      MainCategory mainCat,
      SubCategory subCat,
      Map<String, double> usdRates}) {
    Timestamp dataCreationDT = data['creation_dt'] ?? null;
    Timestamp dataExpenseDT = data['expense_dt'] ?? null;
    creationDT = dataCreationDT == null
        ? creationDT
        : DateTime.fromMillisecondsSinceEpoch(
            dataCreationDT.millisecondsSinceEpoch);
    expenseDT = dataExpenseDT == null
        ? expenseDT
        : DateTime.fromMillisecondsSinceEpoch(
            dataExpenseDT.millisecondsSinceEpoch);

    Map dataUserRates = data['user_rates'];
    if (dataUserRates != null) {
      dataUserRates.forEach((k, v) {
        double rate;
        if (v.runtimeType is double) {
          rate = v;
        } else {
          rate = double.tryParse(v.toString()) ?? 1.0;
        }
        userRates[k] = rate;
      });
    }

    currencyId = data['currency'] ?? null;

    var dataAmount = data['amount'] ?? 0;
    amount = double.tryParse(dataAmount.toString());

    // userRates = data['user_rates'] ?? {};
    xRates = usdRates;

    id = expenseId ?? '';
    createdBy = data['creator'] ?? null;
    mainCategory = mainCat ?? null;
    subCategory = subCat ?? null;
    paidBy = data['payer'] ?? null;
    note = data['note'] ?? '';
    paymentType = data['payment_type'] ?? '';
    tripId = data['trip_id'] ?? '';
    homeCurrency = data['home_currency'];
  }

  Expense.fromNewExpense(NewExpense ne, Map<String, double> xrates, User user) {
    creationDT = ne.creationDT;
    expenseDT = ne.expenseDT;
    createdBy = ne.createdBy;
    mainCategory = ne.mainCategory;
    subCategory = ne.subCategory;
    paidBy = ne.paidById;
    note = ne.note;
    currencyId = ne.currency.id;
    // photo;
    // location;
    // tags;
    paymentType = ne.paymentType;
    tripId = ne.tripId;
    id = ne.id;
    amount = ne.amount;
    userRates = user.userRates;
    homeCurrency = user.homeCurrency;
    tripId = user.currentTrip;
  }

  Map<String, dynamic> toFirestoreMap() {
    Map<String, dynamic> m = {};
    m['creation_dt'] = creationDT;
    m['expense_dt'] = expenseDT;
    m['creator'] = createdBy;
    m['currency'] = currencyId;
    m['amount'] = amount;
    m['user_rates'] = userRates;
    m['main_category'] = mainCategory.id;
    m['sub_category'] = subCategory.id;
    m['payer'] = paidBy;
    m['location'] = 'unknown';
    m['note'] = note;
    m['payment_type'] = paymentType;
    m['trip_id'] = tripId;
    m['home_currency'] = homeCurrency;
    return m;
  }

  String get dayMonthYear =>
      '${expenseDT.day} ${Jiffy(expenseDT).MMM} ${expenseDT.year.toString().substring(2)}';

  String get shortDate => Utils().shortDate(expenseDT);

  double getAmount(String inCurrency) {
    if (currencyId == inCurrency) return amount;
    var usdAmount = convertToUsd(amount, currencyId);
    return convertFromUsd(usdAmount, inCurrency);
  }

  double getCustomRate(String currency) {
    var userRate = userRates[currency]; // aud -> dkk = 5.0
    var homeUsdRate = xRates[homeCurrency]; // usd -> aud = 1.48
    var usdRate = xRates[currency]; // usd -> dkk = 6.78
    var homeCurRate =
        usdRate / homeUsdRate; // aud -> dkk = 6.78 / 1.48 = dkk 4.58
    return usdRate *
        (userRate / homeCurRate); // amount * 6.78 * (5 / 4.58) = 7.40
  }

  double convertToUsd(double amount, String currency) {
    if (userRates.containsKey(currency)) {
      return amount / getCustomRate(currency);
    }
    return amount / xRates[currency];
  }

  double convertFromUsd(double amount, String currency) {
    if (userRates.containsKey(currency)) {
      return amount * getCustomRate(currency);
    }
    return amount * (xRates[currency]);
  }

  String getAmountString(String currency) {
    return getAmount(currency).toStringAsFixed(2);
  }

  List<String> get tags => note == null
      ? []
      : note.split(' ').where((w) => w.startsWith('#')).toList();
}
