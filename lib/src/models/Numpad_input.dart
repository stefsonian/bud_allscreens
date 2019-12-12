class NumpadInput {
  String value = '0.00';
  bool hasInput = false;
  bool hasPoint = false;

  int get len => value.length;
  double get valueDouble => double.tryParse(value) ?? 0.0;

  // updateValue(String newVal) {
  //   var len = numpadValue.length;
  //   var curVal = numpadValue;
  //   var dotIndex = curVal.indexOf('.');

  //   switch (value) {
  //     case 'del':
  //       // remove the last character if exists
  //       if (len > 0) numpadValue = curVal.substring(0, len - 1);
  //       break;
  //     case '.':
  //       // only add a dot if there isn't already a dot
  //       if (dotIndex == -1) numpadValue = '$curVal.';
  //       break;
  //     case 'done':
  //       nextStage();
  //       if (stage == 'split amount') Navigator.pushNamed(context, '/sliders');
  //       break;
  //     default:
  //       // if there are already two decimals, then replace the last decimal,
  //       // otherwise just add the new value onto the _numpadValue
  //       // (except if the first number is 0. if it is, then replace it)
  //       if (dotIndex != -1 && dotIndex == len - 3) {
  //         numpadValue = '${curVal.substring(0, len - 1)}$value';
  //       } else if (dotIndex == -1 && curVal == '0') {
  //         numpadValue = value;
  //       } else {
  //         numpadValue = '$curVal$value';
  //       }
  //   }
  // }
}
