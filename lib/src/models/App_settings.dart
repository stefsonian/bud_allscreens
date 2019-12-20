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
  Color action = Color(0xFFFFFFEE58);
  Color actionContent = Color(0xFFFF303030);
  Color content = Color(0xFFFFFFFDE7);
  Color chartbar1 = Color(0xFFFFFFFDE7);
  Color chartbar2 = Color(0xFFFFFF3D00);
  Color chartValue = Color(0xFFFF526B9D);
  Color box = Color(0xFFFF78909C);
  Color boxcontent = Color(0xFFFFFFFDE7);

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
      case 'actionContent':
        actionContent = color;
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
        chartValue = color;
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
      'actionContent': actionContent,
      'content': content,
      'chartbar1': chartbar1,
      'chartbar2': chartbar2,
      'chartValue': chartValue,
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
