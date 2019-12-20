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
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
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
          primaryColor: Colors.white,
          primaryColorDark: Colors.white,
          hintColor: Colors.white,
          canvasColor: col_main3),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              height: 90,
              child: TextFormField(
                decoration: _inputDecoration('Trip name'),
                onChanged: (val) => data.name = val,
                style: _textStyleLarge,
                validator: (value) => _validator(value),
              ),
            ),
            SizedBox(
              height: 90,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: _inputDecoration('Budget amount'),
                      onChanged: (val) => data.name = val,
                      style: _textStyleLarge,
                      validator: (value) => _validator(value),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: DropdownButton<String>(
                        value: 'per day',
                        icon: Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        style: _textStyleLarge,
                        underline: Container(
                          height: 2,
                          color: Colors.transparent,
                        ),
                        onChanged: (String newValue) {
                          // setState(() {
                          //   dropdownValue = newValue;
                          // });
                        },
                        items: <String>[
                          'per day',
                          'per week',
                          'per month',
                          'trip total'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: _textStyleLarge),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 90,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Budget currency', style: _textStyleHint),
                          SizedBox(height: 6),
                          Row(
                            children: <Widget>[
                              Text(
                                'AUD (Australian Dollars)',
                                style: _textStyleLarge,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.white,
                                ),
                                onPressed: _springCurrencyDialog,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // FloatingActionButton(
                    //   child: Icon(Icons.edit, color: col_aqua),
                    //   backgroundColor: Colors.white,
                    //   onPressed: _springCurrencyDialog,
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 90,
              child: Text('Start date', style: _textStyleHint),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 90,
              child: Text('End date', style: _textStyleHint),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(80, 36, 80, 36),
              child: FloatingActionButton.extended(
                backgroundColor: Colors.white,
                label: Text(
                  'Save',
                  style: TextStyle(color: col_main1, fontSize: 18),
                ),
                icon: Icon(Icons.check, color: col_main1),
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    // Process data.
                    print(data.name);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      // enabledBorder: _fieldBorder,
      // focusedBorder: _fieldBorder,
      // disabledBorder: _fieldBorder,
      // errorBorder: _fieldBorderError,
      // focusedErrorBorder: _fieldBorderError,
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      focusColor: Colors.white,
      labelText: label,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
      hasFloatingPlaceholder: true,
    );
  }

  TextStyle _textStyleLarge = TextStyle(
    color: Colors.white,
    fontSize: 20,
    letterSpacing: 1.1,
  );

  TextStyle _textStyleSmall = TextStyle(
    color: Colors.white,
    fontSize: 20,
    letterSpacing: 1.1,
  );

  TextStyle _textStyleHint = TextStyle(
    color: Colors.white.withOpacity(0.8),
    fontSize: 16,
    letterSpacing: 1.1,
  );

  UnderlineInputBorder _fieldBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white.withOpacity(0.8)),
  );

  // OutlineInputBorder _fieldBorderError = OutlineInputBorder(
  //   borderRadius: BorderRadius.circular(10),
  //   borderSide: BorderSide(color: Colors.red, width: 2),
  // );

  _validator(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  // InputDecoration _inputDecor(String hint) {

  // }
}

//  SizedBox(
//               height: 90,
//               child: Container(
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text('Currency', style: _textStyleHint),
//                           SizedBox(height: 6),
//                           Text(
//                             'AUD (Australian Dollars)',
//                             style: _textStyleLarge,
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 4),
//                     FloatingActionButton(
//                       child: Icon(Icons.edit, color: col_aqua),
//                       backgroundColor: Colors.white,
//                       onPressed: _springCurrencyDialog,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
