import 'package:flutter/material.dart';

class SubCategory {
  String id;
  String groupId;
  String name;
  IconData icon;

  SubCategory(
      {@required this.name,
      @required this.id,
      @required this.icon,
      @required this.groupId});
}
