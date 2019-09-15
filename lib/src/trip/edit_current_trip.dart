import 'package:allscreens/src/helpers/colors.dart';
import 'package:flutter/material.dart';

class EditCurrentTrip extends StatefulWidget {
  @override
  _EditCurrentTripState createState() => _EditCurrentTripState();
}

class _EditCurrentTripState extends State<EditCurrentTrip> {
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: nameController,
          decoration: _decor('Name', 'Give your trip a name', Icons.label),
        ),
        SizedBox(height: 22),
        TextFormField(
          controller: nameController,
          decoration: _decor(
              'Start date', 'The first day of the trip', Icons.calendar_today),
        ),
        SizedBox(height: 22),
        TextFormField(
          controller: nameController,
          decoration: _decor(
              'End date', 'The final day of the trip', Icons.calendar_today),
        ),
        SizedBox(height: 22),
        TextFormField(
          controller: nameController,
          decoration:
              _decor('Budget', 'Your budget for the trip', Icons.attach_money),
        ),
        SizedBox(height: 22),
        TextFormField(
          controller: nameController,
          decoration: _decor(
              'Travel companions', 'Your travel companions', Icons.people),
        ),
      ],
    );
  }

  InputDecoration _decor(String label, String hint, IconData icon) {
    return InputDecoration(
      icon: Icon(icon),
      hintText: hint,
      labelText: label,
      // hintStyle: TextStyle(color: col_purple),
      // labelStyle: TextStyle(color: col_purple),
      // focusColor: col_purple,
      // fillColor: col_purple,
    );
  }
}
