import 'package:eatsleeptravel/src/components/tapered_divider_h.dart';
// import 'package:eatsleeptravel/src/front/front_averages.dart';
import 'package:eatsleeptravel/src/front/front_by_category.dart';
import 'package:eatsleeptravel/src/front/front_by_hashtag.dart';
// import 'package:eatsleeptravel/src/front/front_by_person.dart';
import 'package:eatsleeptravel/src/front/front_recent.dart';
import 'package:eatsleeptravel/src/front/front_select_currency.dart';
import 'package:eatsleeptravel/src/front/front_stats.dart';
import 'package:eatsleeptravel/src/front/trip_options_popup.dart';
import 'package:eatsleeptravel/src/helpers/utils.dart';
import 'package:eatsleeptravel/src/models/Currency.dart';

import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/home_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FrontScreen extends StatefulWidget {
  @override
  _FrontScreenState createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  SessionData session;
  AppState appState;
  Records records;
  HomeState homeState;
  double budgetAmount;
  Currency budgetCurrency;

  @override
  void didChangeDependencies() {
    session = Provider.of<SessionData>(context);
    appState = Provider.of<AppState>(context);
    records = Provider.of<Records>(context);
    homeState = Provider.of<HomeState>(context);
    _updateBudgetCurrency();
    _updateBudgetAmount();
    super.didChangeDependencies();
  }

  _updateBudgetCurrency() {
    var curId = session.user.displayCurrencies.containsKey('home')
        ? session.user.displayCurrencies['home']
        : session.user.homeCurrency;
    setState(() => budgetCurrency = records.getCurrency(curId));
    // budgetCurrency = records.getCurrency(curId);
  }

  _updateBudgetAmount() {
    var amount = Utils().convertAmount(
      amount: session.trip.budgetAmount,
      xRates: records.latestXrates(),
      fromCurrency: session.trip.budgetCurrency,
      toCurrency: budgetCurrency.id,
    );
    setState(() => budgetAmount = amount);
    // budgetAmount = amount;
  }

  @override
  Widget build(BuildContext context) {
    if (session.trip == null) return _buildTripRequired();
    if (records.full.isEmpty) return _buildExpenseRequired(session.trip.name);
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[],
            floating: false,
            snap: false,
            backgroundColor: appState.cols.background2,
            // backgroundColor: Colors.transparent,
            expandedHeight: 100.0,
            // elevation: 4,

            flexibleSpace: FlexibleSpaceBar(
              background: _tripInfo(context, appState),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FrontRecent(),
                ),
                taperedDivder(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FrontSelectCurrency(
                    currency: budgetCurrency,
                  ),
                  // child: Container(),
                ),
                taperedDivder(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FrontStats(),
                  // child: Container(),
                ),
                taperedDivder(),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: FrontAverages(),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FrontByCategory(currency: budgetCurrency),
                  // child: Container(),
                ),
                taperedDivder(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FrontByHashtag(currency: budgetCurrency),
                  // child: Container(),
                ),

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: FrontByPerson(),
                // ),
                SizedBox(height: 100),
              ],
            ),

            // SliverChildBuilderDelegate(
            //   (BuildContext context, int index) {
            //     final Color color =
            //         index.isEven ? Colors.pink : Colors.yellowAccent;
            //     return Container(
            //       height: 100,
            //       color: color,
            //     );
            //   },
            //   childCount: 30,
            // ),
          ),
        ],
      ),
    );
  }

  Widget _tripInfo(BuildContext context, AppState appState) {
    if (session.trip == null) {
      return FlatButton(
        child: Text(
          'Tap to add a trip',
          style: TextStyle(color: appState.cols.content),
        ),
        onPressed: () => Navigator.pushNamed(context, 'new trip'),
      );
    }
    // else return the trip name
    var tripText = session.trip.name;
    return Container(
      padding: EdgeInsets.only(left: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        tripText,
                        style: TextStyle(
                          fontSize: tripText.length < 19 ? 22 : 18,
                          letterSpacing: 1.1,
                          color: appState.cols.content,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    TripOptionsPopup(),
                  ],
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
          // SizedBox(height: 2),
          Text(
            session.trip == null
                ? ''
                : '${session.trip.startDayMonth} - ${session.trip.endDayMonth}  •  day ${session.trip.travelDay + 1}',
            style: TextStyle(
                fontSize: 12, letterSpacing: 1.1, color: appState.cols.content),
          ),
        ],
      ),
    );
  }

  Widget taperedDivder() {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
      child: TaperedDividerH(
        color1: appState.cols.content,
        color2: appState.cols.background1,
        thickness: 1,
      ),
    );
  }

  Widget _buildTripRequired() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              'Welcome to',
              style: TextStyle(
                color: appState.cols.content,
                fontSize: 18,
                letterSpacing: 1.6,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Eat Sleep Travel',
              style: TextStyle(
                color: appState.cols.content,
                fontSize: 25,
                letterSpacing: 1.6,
              ),
            ),
          ],
        ),
        Text(
          'Set up your first trip\nto get started',
          style: TextStyle(
            color: appState.cols.content,
            fontSize: 18,
            letterSpacing: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 70,
          width: 200,
          child: RaisedButton(
            child: Text(
              'New trip',
              style: TextStyle(
                color: appState.cols.actioncontent,
                fontSize: 20,
                letterSpacing: 1.6,
              ),
            ),
            elevation: 16,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(360),
            ),
            color: appState.cols.action,
            onPressed: () => Navigator.pushNamed(
              context,
              'new trip',
              arguments: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseRequired(String tripName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              'Your trip',
              style: TextStyle(
                color: appState.cols.content,
                fontSize: 18,
                letterSpacing: 1.6,
              ),
            ),
            SizedBox(height: 15),
            Text(
              tripName,
              style: TextStyle(
                color: appState.cols.content,
                fontSize: 35,
                letterSpacing: 1.6,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'is all set up',
              style: TextStyle(
                color: appState.cols.content,
                fontSize: 18,
                letterSpacing: 1.6,
              ),
            ),
          ],
        ),
        Text(
          'Tap + to record your\nfirst expense',
          style: TextStyle(
            color: appState.cols.content,
            fontSize: 18,
            letterSpacing: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Container(
  //       padding: EdgeInsets.fromLTRB(8, 14, 8, 10),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: <Widget>[
  //           FrontTrip(),
  //           SizedBox(height: 14),
  //           Expanded(child: FrontStats()),
  //           SizedBox(height: 14),
  //           FrontAverages(),
  //           // SizedBox(height: 50),
  //           // _addExpenseButton(),
  //           SizedBox(height: 30),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _addExpenseButton() {
  //   return SizedBox(
  //     width: 200,
  //     child: FloatingActionButton.extended(
  //       label: Text('Expense'),
  //       icon: Icon(Icons.add),
  //       backgroundColor: col_orange,
  //       onPressed: () {},
  //     ),
  //   );
  // }
}
