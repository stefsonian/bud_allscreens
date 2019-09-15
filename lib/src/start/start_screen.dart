import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/services/app_state.dart';
import 'package:allscreens/src/services/home_state.dart';
import 'package:allscreens/src/start/budget_seven.dart';
import 'package:allscreens/src/start/trip_options_popup.dart';
import 'package:flutter/material.dart';
import 'package:allscreens/src/components/gradient_box.dart';
import 'package:allscreens/src/start/trip_info.dart';
import 'package:provider/provider.dart';

import 'budget_info.dart';
import 'budget_today.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  AppState appState;
  HomeState homeState;

  didChangeDependencies() {
    super.didChangeDependencies();
    appState = Provider.of<AppState>(context);
    homeState = Provider.of<HomeState>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GradientBox(
              name: 'Trip',
              // action: GestureDetector(
              //   onTap: () => Navigator.pushNamed(context, 'trip home'),
              //   child: Icon(Icons.settings),
              // ),
              action: TripOptionsPopup(),
              child: TripInfo(),
            ),
            GradientBox(
              name: 'Today',
              action: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'AUD',
                    textScaleFactor: 1.4,
                  ),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
              child: BudgetToday(),
            ),
            GradientBox(
              name: 'Last 7 days',
              child: BudgetSeven(),
            ),
            _nextButton(),
          ],
        ),
      ),
    );
  }

  Widget _nextButton() {
    return SizedBox(
      width: 250,
      child: FloatingActionButton.extended(
        label: Text(
          'Add expense',
          textScaleFactor: 1.4,
        ),
        icon: Icon(Icons.add_circle_outline),
        backgroundColor: Colors.yellow,
        foregroundColor: col_purple,
        onPressed: () => appState.activeTabIndex = 1,
      ),
    );
  }
}
