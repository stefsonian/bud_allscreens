import 'package:allscreens/src/components/currency_selector.dart';
import 'package:allscreens/src/front/manage_trip/manage_trip_model.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:flutter/material.dart';

class ManageTripForm extends StatefulWidget {
  ManageTripForm({Key key}) : super(key: key);

  @override
  _ManageTripFormState createState() => _ManageTripFormState();
}

class _ManageTripFormState extends State<ManageTripForm> {
  final _formKey = GlobalKey<FormState>();
  final data = ManageTripModel();

  _springCurrencyDialog() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,

        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(14)),
        children: <Widget>[
          CurrencySelector(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: col_aqua,
        primaryColorDark: col_aqua,
      ),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              height: 100,
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: _fieldBorder,
                  focusedBorder: _fieldBorder,
                  disabledBorder: _fieldBorder,
                  errorBorder: _fieldBorderError,
                  focusedErrorBorder: _fieldBorderError,
                  focusColor: col_aqua,
                  labelText: 'Trip name',
                  hasFloatingPlaceholder: true,
                ),
                onChanged: (val) => data.name = val,
                style: _textStyle,
                validator: (value) => _validator(value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 36.0),
              child: RaisedButton(
                onPressed: () => _springCurrencyDialog(),
                child: Text('Select currency'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 36.0),
              child: RaisedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    // Process data.
                    print(data.name);
                  }
                },
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyle = TextStyle(
    color: col_aqua,
    fontSize: 20,
    letterSpacing: 1.1,
  );

  OutlineInputBorder _fieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: col_aqua, width: 2),
  );

  OutlineInputBorder _fieldBorderError = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.red, width: 2),
  );

  _validator(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  // InputDecoration _inputDecor(String hint) {

  // }
}
