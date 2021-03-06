import 'package:eatsleeptravel/src/components/currency_selector.dart';
import 'package:eatsleeptravel/src/components/full_modal_ok.dart';
import 'package:eatsleeptravel/src/front/manage_trip/manage_trip_model.dart';
import 'package:eatsleeptravel/src/front/user_settings/set_home_currency.dart';
import 'package:eatsleeptravel/src/helpers/colors.dart';
import 'package:eatsleeptravel/src/models/Trip.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/firestore_service.dart';
import 'package:eatsleeptravel/src/services/home_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';

class ManageTripForm extends StatefulWidget {
  ManageTripForm({Key key, this.isCreateMode = false}) : super(key: key);
  final bool isCreateMode;

  @override
  _ManageTripFormState createState() => _ManageTripFormState();
}

class _ManageTripFormState extends State<ManageTripForm> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirestoreService();
  var data = ManageTripModel();
  SessionData sessionData;
  AppState appState;
  Records records;
  HomeState homeState;

  void didChangeDependencies() {
    appState = Provider.of<AppState>(context);
    sessionData = Provider.of<SessionData>(context);
    records = Provider.of<Records>(context);
    homeState = Provider.of<HomeState>(context);
    // only populate fields if in manage mode (leave empty if in create mode)
    if (!widget.isCreateMode) {
      if (data.name == '' && sessionData.trip != null) {
        data = ManageTripModel.withTripData(sessionData.trip);
      }
    }
    super.didChangeDependencies();
  }

  _springCurrencyDialog() {
    _submitFunction() {
      var curId = homeState.currencyPickerValue;
      // data.budgetCurrency = curId;
      // var newData = data;
      // setState(() => data = newData);
      setState(() => data.budgetCurrency = curId);
      Navigator.pop(context);
    }

    Navigator.of(context).push(
      FullModalOk(
        header: SetBudgetCurrencyHeader(),
        body: SelectCurrency(initialCurrencyId: data.budgetCurrency),
        buttonColor: appState.cols.content,
        onOkTap: _submitFunction,
      ),
    );
  }

  _springStartDatePicker(DateTime currentStart) async {
    FocusScope.of(context).requestFocus(FocusNode());
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
    data.startDate = Jiffy(selectedDate).startOf('day');
    setState(() => data = data);
  }

  _springEndDatePicker(DateTime currentStart, DateTime currentEnd) async {
    FocusScope.of(context).requestFocus(FocusNode());
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
    data.endDate = Jiffy(selectedDate).endOf('day');
    setState(() => data = data);
  }

  onCreateNewTrip() async {
    if (!data.isReadyForCommit()) return; // TODO: notify user
    var userId = sessionData.user.id;
    Trip trip = Trip();
    trip.updateFromManageTrip(data);
    trip.creator = userId;
    trip.roles[userId] = 'owner';
    var newTripId = await _firestore.createTrip(userId: userId, trip: trip);
    await _firestore.setUserCurrentTrip(
      userId: userId,
      tripId: newTripId.documentID,
    );
    records.currentTripId = newTripId.documentID;
    // TODO: show pop-up confirmation
  }

  onUpdateExistingTrip() async {
    if (!data.isReadyForCommit()) return; // TODO: notify user
    var userId = sessionData.user.id;
    Trip trip = sessionData.trip;
    trip.updateFromManageTrip(data);
    await _firestore.updateExistingTrip(trip: trip);
    // TODO: show pop-up confirmation
  }

  String _getBudgetCurrency() {
    if (data.budgetCurrency == null || data.budgetCurrency.isEmpty) {
      return 'Select currency';
    }

    var curId = data.budgetCurrency;
    var cur = records.getCurrency(curId);
    return ('${cur.name} (${cur.id.toUpperCase()})');
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
              child: GestureDetector(
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
                                _getBudgetCurrency(),
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
                    ],
                  ),
                ),
                onTap: _springCurrencyDialog,
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
                    if (widget.isCreateMode) onCreateNewTrip();
                    if (!widget.isCreateMode) onUpdateExistingTrip();
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
