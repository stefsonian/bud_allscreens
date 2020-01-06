import 'package:allscreens/src/background/background.dart';
import 'package:allscreens/src/components/option_button.dart';
import 'package:allscreens/src/models/New_expense.dart';
import 'package:allscreens/src/record/record_amount.dart';
import 'package:allscreens/src/record/record_category.dart';
import 'package:allscreens/src/record/record_details.dart';
import 'package:allscreens/src/record/record_options.dart';
import 'package:allscreens/src/services/app_state.dart';
import 'package:allscreens/src/services/record_state.dart';
import 'package:allscreens/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:provider/provider.dart';
import 'package:clip_shadow/clip_shadow.dart';

class RecordScreen extends StatefulWidget {
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen>
    with SingleTickerProviderStateMixin {
  AppState appState;
  RecordState recordState;
  SessionData sessionData;

  final stages = [Stage0(), Stage1()];

  didChangeDependencies() {
    super.didChangeDependencies();
    recordState = Provider.of<RecordState>(context);
    appState = Provider.of<AppState>(context);
    sessionData = Provider.of<SessionData>(context);
    appState.initaliseNewExpense(sessionData.trip, sessionData.user);
  }

  tapNextButton() {
    if (recordState.recordStage == 1) recordState.recordStage = -1;
    recordState.recordStage = recordState.recordStage + 1;
    setState(() {});
  }

  tapPreviousButton() {
    if (recordState.recordStage == 0)
      appState.activeTabIndex = appState.previousTabIndex;
    if (recordState.recordStage != 0) recordState.recordStage -= 1;
    setState(() {});
  }

  Widget build(BuildContext context) {
    return SafeArea(
      // top: false,
      left: false,
      right: false,
      child: Container(
        color: appState.cols.action.withOpacity(0.92),
        child: Stack(
          children: <Widget>[
            Background(),
            // Content
            Positioned(
              top: 0,
              bottom: 60,
              left: 0,
              right: 0,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 150),
                key: Key('K'),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: const Offset(0.0, 0.0),
                    ).animate(CurvedAnimation(
                        parent: animation, curve: Curves.linear)),
                    child: child,
                  );
                },
                child: stages[recordState.recordStage],
              ),
            ),
            // Buttons
            Positioned(
              bottom: 10,
              left: 20,
              right: 20,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  height: 42,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: buildNavButton(() {}, Icons.delete),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        flex: 1,
                        child: buildNavButton(() {}, Icons.arrow_back_ios),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        flex: 3,
                        child: buildNavButton(() {}, Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell buildNavButton(Function onTap, IconData icon) {
    return InkWell(
      splashColor: appState.cols.actioncontent,
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: appState.cols.action.withOpacity(0.85),
          boxShadow: kElevationToShadow[4],
        ),
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Icon(
            icon,
            color: appState.cols.actioncontent,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}

class Stage0 extends StatelessWidget {
  const Stage0({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: RecordCategory(),
            ),
          ),
          RecordAmount(),
        ],
      ),
    );
  }
}

class Stage1 extends StatelessWidget {
  const Stage1({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RecordCategory();
  }
}

class RecordScreenClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var w = size.width;
    var h = size.height;

    var left = w * 0.0;
    var right = w;
    var top = 0.0;
    var bottom = h - 42;

    final path = Path();
    path.moveTo(left, top);
    path.lineTo(left, bottom);
    path.lineTo(40, bottom);
    path.arcToPoint(Offset(90, bottom), radius: Radius.circular(1));
    path.lineTo(w * 0.5 - 41, bottom);
    path.arcToPoint(Offset(w * 0.5 + 41, bottom), radius: Radius.circular(1));
    path.lineTo(right, bottom);
    path.lineTo(right, top);
    path.close();
    // path.quadraticBezierTo(size.width * 0.3, 270, size.width * 0.6, 220);
    return path;
  }

  @override
  bool shouldReclip(RecordScreenClipper oldClipper) => true;
}
