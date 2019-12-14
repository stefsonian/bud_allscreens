class NumpadInput {
  String value = '';

  int get len => value.length;
  double get valueDouble => double.tryParse(value) ?? 0.0;

  String displayValue() {
    var dotIndex = value.indexOf('.');
    if (value == '') return '0.00';
    if (dotIndex == -1) return '$value.00';
    if (dotIndex == len - 1) return '${value}00';
    if (dotIndex == len - 2) return '${value}0';
    return value;
  }

  updateValue(String newVal) {
    var dotIndex = value.indexOf('.');

    switch (newVal) {
      case 'del':
        // remove the last character if exists
        if (len > 0) value = value.substring(0, len - 1);
        if (value.endsWith('.')) value = value.substring(0, len - 1);
        break;
      case '.':
        // only add a dot if there isn't already a dot
        if (dotIndex == -1) value = '$value.';
        break;
      default:
        // if there are already two decimals, then replace the last decimal,
        // otherwise just add the new value onto the current value
        // (except if the first number is 0. If it is, then replace it)
        if (dotIndex != -1 && dotIndex == len - 3) {
          value = '${value.substring(0, len - 1)}$newVal';
        } else if (dotIndex == -1 && value == '0') {
          value = newVal;
        } else {
          value = '$value$newVal';
        }
    }
  }
}
