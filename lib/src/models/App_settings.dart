import 'package:flutter/foundation.dart';
import 'dart:ui';

class AppSettings extends ChangeNotifier {
  Cols cols;
  AppSettings() {
    cols = Cols();
  }
  void changeColor(String name, Color color) {
    cols.changeColor(name, color);
    cols.printColors();
    notifyListeners();
  }
}

class Cols {
  Color background2 = Color(0xFFFF37474F);
  Color background1 = Color(0xFFFF546E7A);
  Color action = Color(0xFFFFE4D554);
  Color actionlight = Color(0xFFFFF5E760);
  Color actioncontent = Color(0xFFFF303030);
  Color content = Color(0xFFfbf9ef);
  Color chartbar1 = Color(0xFFfbf9ef);
  Color chartbar2 = Color(0xFFFFFF3D00);
  Color chartvalue = Color(0xFFFF526B9D);
  Color box = Color(0xFFFF78909C);
  Color boxcontent = Color(0xFFfbf9ef);

  void changeColor(String name, Color color) {
    switch (name) {
      case 'background1':
        background1 = color;
        break;
      case 'background2':
        background2 = color;
        break;
      case 'action':
        action = color;
        break;
      case 'actionlight':
        actionlight = color;
        break;
      case 'actionContent':
        actioncontent = color;
        break;
      case 'content':
        content = color;
        break;
      case 'chartbar1':
        chartbar1 = color;
        break;
      case 'chartbar2':
        chartbar2 = color;
        break;
      case 'chartValue':
        chartvalue = color;
        break;
      case 'box':
        box = color;
        break;
      case 'boxcontent':
        boxcontent = color;
        break;
      default:
    }
  }

  Map<String, Color> asMap() {
    return {
      'background2': background2,
      'background1': background1,
      'action': action,
      'actionlight': actionlight,
      'actionContent': actioncontent,
      'content': content,
      'chartbar1': chartbar1,
      'chartbar2': chartbar2,
      'chartValue': chartvalue,
      'box': box,
      'boxcontent': boxcontent
    };
  }

  void printColors() {
    List<String> strings = [];
    asMap().forEach((k, v) => print('Color $k = Color(0xFF${asHex(v)});'));
    // strings.forEach((s) => print(s));
    print('---------------------------------------');
  }

  String asHex(Color color) {
    return color.value.toRadixString(16).toUpperCase();
  }
}
