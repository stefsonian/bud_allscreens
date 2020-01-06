import 'dart:math';
import 'package:geolocator/geolocator.dart';

import 'package:allscreens/src/models/Location.dart';

class Utils {
  List<Map<String, double>> sortMapByDoubleValue(
      {Map<String, double> m, descending = true}) {
    List<Map<String, double>> result = [];
    var keys = m.keys.toList();
    List<double> vals = m.values.toList();
    int listLength = vals.length;
    for (var i = 0; i < listLength; i++) {
      var maxVal = descending ? vals.reduce(max) : vals.reduce(min);
      var maxIndex = vals.indexOf(maxVal);
      result.add({keys[maxIndex]: vals[maxIndex]});
      keys.removeAt(maxIndex);
      vals.removeAt(maxIndex);
    }
    return result;
  }

  Future<Location> getCurrentLocation() async {
    Location location = Location();
    // var position = await Geolocator().getCurrentPosition();

    return location;
  }
}