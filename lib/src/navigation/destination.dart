import 'package:flutter/material.dart';

class Destination {
  const Destination(this.title, this.icon, this.color);
  final String title;
  final IconData icon;
  final MaterialColor color;
}

const List<Destination> allDestinations = <Destination>[
  Destination('Home', Icons.home, Colors.teal),
  Destination('Expenses', Icons.list, Colors.cyan),
  Destination('New', Icons.add, Colors.cyan),
  Destination('Stats', Icons.show_chart, Colors.orange),
  Destination('Settings', Icons.settings, Colors.blue)
];
