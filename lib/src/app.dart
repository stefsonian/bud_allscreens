import 'package:allscreens/src/record/add_record.dart';
import 'package:flutter/material.dart';
import 'package:allscreens/src/background/background.dart';
import 'package:allscreens/src/start/start.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          color: Colors.white70,
          child: Background(child: AddRecord()),
        ),
      ),
    );
  }
}
