import 'package:allscreens/src/components/currency_selector.dart';
import 'package:allscreens/src/front/manage_trip/manage_trip_model.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/services/app_state.dart';
import 'package:allscreens/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageTripForm extends StatefulWidget {
  ManageTripForm({Key key}) : super(key: key);

  @override
  _ManageTripFormState createState() => _ManageTripFormState();
}

class _ManageTripFormState extends State<ManageTripForm> {
  final _formKey = GlobalKey<FormState>();
  var data = ManageTripModel();
  SessionData sessionData;
  AppState appState;

  void didChangeDependencies() {
    appState = Provider.of<AppState>(context);
    sessionData = Provider.of<SessionData>(context);
    // if no data, fill data with current trip values if exists
    if (data.name == '' && sessionData.trip != null) {
      data = ManageTripModel.withTripData(sessionData.trip);
    }
    super.didChangeDependencies();
  }

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

  _springStartDatePicker(DateTime currentStart) async {
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: currentStart,
      firstDate: currentStart.subtract(Duration(days: 365)),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    data.startDate = selectedDate;
    setState(() => data = data);
  }

  _springEndDatePicker(DateTime currentStart, DateTime currentEnd) async {
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: currentEnd,
      firstDate: currentStart,
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    data.endDate = selectedDate;
    setState(() => data = data);
  }

  Widget build(BuildContext context) {
    TextStyle _textStyleLarge = TextStyle(
      color: appState.cols.content,
      fontSize: 20,
      letterSpacing: 1.1,
    );

    TextStyle _textStyleHint = TextStyle(
      color: appState.cols.content.withOpacity(0.8),
      fontSize: 16,
      letterSpacing: 1.1,
    );

    return Theme(
      data: ThemeData(
        primaryColor: appState.cols.content,
        primaryColorDark: appState.cols.content,
        hintColor: appState.cols.content,
      ),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              height: 90,
              child: TextFormField(
                initialValue: data.name,
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
                      keyboardType: TextInputType.number,
                      initialValue: data.budgetAmount,
                      decoration: _inputDecoration('Budget amount (per day)'),
                      onChanged: (val) => data.budgetAmount = val,
                      style: _textStyleLarge,
                      validator: (value) => _validator(value),
                    ),
                  ),
                  // Expanded(
                  //   child: Center(
                  //     child: DropdownButton<String>(
                  //       value: 'per day',
                  //       icon: Icon(
                  //         Icons.arrow_downward,
                  //         color: Colors.white,
                  //       ),
                  //       iconSize: 24,
                  //       elevation: 16,
                  //       style: _textStyleLarge,
                  //       underline: Container(
                  //         height: 2,
                  //         color: Colors.transparent,
                  //       ),
                  //       onChanged: (String newValue) {
                  //         // setState(() {
                  //         //   dropdownValue = newValue;
                  //         // });
                  //       },
                  //       items: <String>[
                  //         'per day',
                  //         'per week',
                  //         'per month',
                  //         'trip total'
                  //       ].map<DropdownMenuItem<String>>((String value) {
                  //         return DropdownMenuItem<String>(
                  //           value: value,
                  //           child: Text(value, style: _textStyleLarge),
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 26),
            SizedBox(
              height: 90,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Budget currency', style: _textStyleHint),
                        // SizedBox(height: 6),
                        Row(
                          children: <Widget>[
                            Text(
                              'AUD (Australian Dollars)',
                              style: _textStyleLarge,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_downward,
                                color: appState.cols.content,
                              ),
                              onPressed: _springCurrencyDialog,
                            ),
                          ],
                        ),
                      ],
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
            SizedBox(height: 26),
            Container(
              // height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _springStartDatePicker(data.startDate),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Start date', style: _textStyleHint),
                        SizedBox(height: 8),
                        Text(
                          data.startDateString,
                          style: _textStyleLarge,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        _springEndDatePicker(data.startDate, data.endDate),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('End date', style: _textStyleHint),
                        SizedBox(height: 8),
                        Text(
                          data.endDateString,
                          style: _textStyleLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.fromLTRB(80, 36, 80, 36),
              child: FloatingActionButton.extended(
                backgroundColor: appState.cols.content,
                label: Text(
                  'Save',
                  style:
                      TextStyle(color: appState.cols.background2, fontSize: 18),
                ),
                icon: Icon(Icons.check, color: appState.cols.background2),
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
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: appState.cols.content)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: appState.cols.content)),
      focusColor: appState.cols.content,
      labelText: label,
      labelStyle: TextStyle(color: appState.cols.content.withOpacity(0.7)),
      hasFloatingPlaceholder: true,
    );
  }

  _validator(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  // InputDecoration _inputDecor(String hint) {

  // }
}
