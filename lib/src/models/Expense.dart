import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatsleeptravel/src/models/Location.dart';
import 'package:eatsleeptravel/src/models/Category.dart';
import 'package:eatsleeptravel/src/models/Frozen_amount.dart';
import 'package:jiffy/jiffy.dart';

class Expense {
  DateTime creationDT = DateTime.now();
  DateTime expenseDT = DateTime.now();
  String createdBy; // user id
  FrozenAmount amount = FrozenAmount();
  MainCategory mainCategory;
  SubCategory subCategory;
  String paidBy; // user id
  Location location;
  String note = '';
  var photo; // TODO: change type to Photo
  String paymentType = '';
  String tripId = '';
  String id;

  Expense();

  Expense.fromFirestoreData(
      {String expenseId,
      Map<String, dynamic> data,
      MainCategory mainCat,
      SubCategory subCat}) {
    Timestamp dataCreationDT = data['start_dt'] ?? null;
    Timestamp dataExpenseDT = data['end_dt'] ?? null;
    creationDT = dataCreationDT == null
        ? creationDT
        : DateTime.fromMillisecondsSinceEpoch(
            dataCreationDT.millisecondsSinceEpoch);
    expenseDT = dataExpenseDT == null
        ? expenseDT
        : DateTime.fromMillisecondsSinceEpoch(
            dataExpenseDT.millisecondsSinceEpoch);

    var dataAmount = data['amount'] ?? 0;
    amount.value = double.tryParse(dataAmount.toString());

    var dataAmountAud = data['amount_aud'] ?? 0;
    amount.amountInAUD = double.tryParse(dataAmountAud.toString());

    var dataAmountusd = data['amount_usd'] ?? 0;
    amount.amountInUSD = double.tryParse(dataAmountusd.toString());

    var dataAmounteur = data['amount_eur'] ?? 0;
    amount.amountInEUR = double.tryParse(dataAmounteur.toString());

    var dataAmounthome = data['amount_home'] ?? 0;
    amount.amountInHome = double.tryParse(dataAmounthome.toString());

    id = expenseId ?? '';
    createdBy = data['creator'] ?? null;
    amount.currency = data['currency'] ?? null;
    amount.homeCurrency = data['currency_home'] ?? null;
    mainCategory = mainCat ?? null;
    subCategory = subCat ?? null;
    paidBy = data['payer'] ?? null;
    note = data['note'] ?? '';
    paymentType = data['payment_type'] ?? '';
    tripId = data['trip_id'] ?? '';
  }

  Map<String, dynamic> toFirestoreMap() {
    Map<String, dynamic> m = {};
    m['creation_dt'] = creationDT;
    m['expense_dt'] = expenseDT;
    m['creator'] = createdBy;
    m['currency'] = amount.currency;
    m['currency_home'] = amount.homeCurrency;
    m['amount'] = amount.value;
    m['amount_usd'] = amount.amountInUSD;
    m['amount_aud'] = amount.amountInAUD;
    m['amount_eur'] = amount.amountInEUR;
    m['amount_home'] = amount.amountInHome;
    m['main_category'] = mainCategory.id;
    m['sub_category'] = subCategory.id;
    m['payer'] = paidBy;
    m['location'] = 'unknown';
    m['note'] = note;
    m['payment_type'] = paymentType;
    m['trip_id'] = tripId;
    return m;
  }

  String get dayMonthYear =>
      '${expenseDT.day} ${Jiffy(expenseDT).MMM} ${expenseDT.year.toString().substring(2)}';

  List<String> get tags => note == null
      ? []
      : note.split(' ').where((w) => w.startsWith('#')).toList();
}
