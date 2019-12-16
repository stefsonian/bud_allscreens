class FrozenAmount {
  String currency, homeCurrency = '';
  DateTime frozenDT = DateTime.now();
  double value, amountInUSD, amountInEUR, amountInAUD, amountInHome = 0.0;

  FrozenAmount.withTestData(double amount) {
    currency = 'AUD';
    homeCurrency = 'AUD';
    value = amount;
    amountInAUD = amount;
    amountInUSD = amount * 0.7;
    amountInEUR = amount * 0.6;
    amountInHome = amount;
  }
}
