import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatsleeptravel/src/background/background.dart';
import 'package:eatsleeptravel/src/components/option_button.dart';
import 'package:eatsleeptravel/src/models/Expense.dart';
import 'package:eatsleeptravel/src/models/New_expense.dart';
import 'package:eatsleeptravel/src/record/record_amount.dart';
import 'package:eatsleeptravel/src/record/record_category.dart';
import 'package:eatsleeptravel/src/record/record_details.dart';
import 'package:eatsleeptravel/src/record/record_options.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/firestore_service.dart';
import 'package:eatsleeptravel/src/services/record_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:eatsleeptravel/src/helpers/colors.dart';
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
  Records records;
  var isReady = false;
  FirestoreService firestore = FirestoreService();

  final stages = [Stage0(), Stage1()];

  didChangeDependencies() {
    super.didChangeDependencies();
    recordState = Provider.of<RecordState>(context);
    appState = Provider.of<AppState>(context);
    sessionData = Provider.of<SessionData>(context);
    records = Provider.of<Records>(context);
    if (sessionData.trip != null) {
      recordState.initaliseNewExpense(sessionData.trip, sessionData.user);
    }
  }

  tapNextButton() async {
    // check if payment type was populated. if not, then the user chose 'same as last'
    if (recordState.newExpense.paymentType == null) {
      recordState.updateNewExpense('paymentType', records.latestPaymentType);
    }

    if (recordState.recordStage == 1) {
      // If we're at the final stage
      final user = sessionData.user;
      recordState.updateNewExpense('createdBy', user.id);
      recordState.updateNewExpense('paidById', user.id);
      recordState.updateNewExpense('paidByName', user.name);
      recordState.updateNewExpense('tripId', sessionData.trip.id);

      // COMMIT EXPENSE:
      final Expense expense = Expense.fromNewExpense(recordState.newExpense);
      DocumentReference result = await firestore.createExpense(
        tripId: sessionData.trip.id,
        expense: expense,
      );
      print('trip id: ${sessionData.trip.id} | doc id: ${result.documentID}');
    } else {
      // else go to the next stage

      recordState.recordStage = recordState.recordStage + 1;
      // setState(() {});
    }
  }

  tapPreviousButton() {
    if (recordState.recordStage == 0)
      appState.activeTabIndex = appState.previousTabIndex;
    if (recordState.recordStage != 0) recordState.recordStage -= 1;
    setState(() {});
  }

  tapTrashButton() {
    recordState.initaliseNewExpense(sessionData.trip, sessionData.user);
    appState.activeTabIndex = appState.previousTabIndex;
  }

  Widget build(BuildContext context) {
    if (!sessionData.isInitialisationComplete) return Container();
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
              bottom: appState.viewHeight < 735 ? 60 : 76,
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
              child: Container(
                height: 42,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: buildNavButton(
                        onTap: tapTrashButton,
                        icon: Icons.delete,
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      flex: 1,
                      child: buildNavButton(
                          onTap: tapPreviousButton,
                          icon: Icons.arrow_back_ios,
                          isEnabled: recordState.recordStage > 0),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      flex: 3,
                      child: buildNavButton(
                          onTap: tapNextButton,
                          icon: recordState.recordStage < 1
                              ? Icons.arrow_forward_ios
                              : Icons.check,
                          isEnabled:
                              recordState.newExpense.subCategory != null),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavButton(
      {Function onTap, IconData icon, bool isEnabled = true}) {
    var opacity = isEnabled ? 1.0 : 0.3;
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(360),
      ),
      materialTapTargetSize: MaterialTapTargetSize.padded,
      animationDuration: Duration(milliseconds: 300),
      elevation: 8,
      color: appState.cols.action,
      disabledColor: appState.cols.action.withOpacity(opacity),
      child: Icon(
        icon,
        color: appState.cols.actioncontent.withOpacity(opacity),
        size: icon == Icons.check ? 34 : 26,
      ),
      onPressed: isEnabled ? onTap : null,
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
    return RecordDetails();
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
