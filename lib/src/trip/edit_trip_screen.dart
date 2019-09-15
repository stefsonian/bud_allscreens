import 'package:allscreens/src/background/background.dart';
import 'package:allscreens/src/components/gradient_box.dart';
import 'package:allscreens/src/trip/edit_current_trip.dart';
import 'package:flutter/material.dart';

class EditTripScreen extends StatefulWidget {
  @override
  _EditTripScreenState createState() => _EditTripScreenState();
}

class _EditTripScreenState extends State<EditTripScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Edit current trip'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Background(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GradientBox(
                name: 'Trip details',
                child: EditCurrentTrip(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
