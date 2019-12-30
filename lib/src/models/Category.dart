import 'package:flutter/material.dart';

class Category {
  String id;
  String name;
  IconData icon;

  Category({@required this.id, @required this.name, @required this.icon});
}

class MainCategory extends Category {
  MainCategory({id, name, icon}) : super(id: id, name: name, icon: icon);
}

class SubCategory extends Category {
  String groupId;

  SubCategory({id, name, icon, @required this.groupId})
      : super(id: id, name: name, icon: icon);
}
