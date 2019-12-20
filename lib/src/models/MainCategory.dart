import 'package:allscreens/src/models/Category.dart';
import 'package:flutter/material.dart';

class MainCategory extends Category {
  String id;
  String name;
  IconData icon;

  MainCategory({@required this.id, @required this.name, @required this.icon});
}
