class FrozenAmount {
  Map<String, double> amounts = {};

  FrozenAmount();

  FrozenAmount.fromMap(Map<String, double> data) {
    amounts = data;
  }
}
