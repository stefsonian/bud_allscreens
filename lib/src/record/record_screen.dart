import 'package:allscreens/src/background/background.dart';
import 'package:allscreens/src/record/record_amount.dart';
import 'package:allscreens/src/record/record_category.dart';
import 'package:allscreens/src/record/record_details.dart';
import 'package:allscreens/src/record/record_options.dart';
import 'package:allscreens/src/services/app_state.dart';
import 'package:allscreens/src/services/record_state.dart';
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
  AnimationController _controller;

  final inputWidgets = [
    // RecordOptions(),
    RecordAmount(),
    Container(),
    Container(),
    // RecordOther(),
    // Container(),
    Container()
  ];

  final stages = [Stage0(), Stage1()];

  didChangeDependencies() {
    super.didChangeDependencies();
    recordState = Provider.of<RecordState>(context);
    appState = Provider.of<AppState>(context);
    // Future.microtask(() => appState.showQuickAddButton = false);
  }

  tapNextButton() {
    if (recordState.recordStage == 1) recordState.recordStage = -1;
    recordState.recordStage = recordState.recordStage + 1;
  }

  tapPreviousButton() {
    if (recordState.recordStage != 0) recordState.recordStage -= 1;
  }

  // tapNextButton() => recordState.isAmountRecorded = true;
  // tapAmountBox() => recordState.isAmountRecorded = false;
  // tapMainCat() => recordState.isMainCatRecorded = true;
  // tapSubCat() => recordState.isSubCatRecorded = true;
  // tapCategoriesBox() {
  //   recordState.isMainCatRecorded = false;
  //   recordState.isSubCatRecorded = false;
  // }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    // print('sHeight: $height');
    return SafeArea(
      // top: false,
      left: false,
      right: false,
      child: Container(
        color: col_aqua,
        child: Stack(
          children: <Widget>[
            ClipShadow(
              clipper: RecordScreenClipper(),
              boxShadow: kElevationToShadow[2],
              child: Background(),
            ),
            // Content
            Positioned(
              top: 0,
              bottom: 94,
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
              bottom: 23,
              left: 18.5,
              child: SizedBox(
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  backgroundColor: col_orange_dark,
                  elevation: 2,
                  child: Icon(Icons.remove, color: Colors.white, size: 33),
                  onPressed: () => appState.activeTabIndex = 0,
                ),
              ),
            ),
            Positioned(
              bottom: 23,
              left: 92.5,
              child: SizedBox(
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  backgroundColor: col_orange_dark,
                  elevation: 2,
                  child: Icon(Icons.arrow_back, color: Colors.white, size: 33),
                  onPressed: tapPreviousButton,
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: width * 0.5 - 35,
              child: SizedBox(
                height: 70,
                width: 70,
                child: FloatingActionButton(
                  backgroundColor: col_orange,
                  elevation: 2,
                  child: recordState.recordStage < 1
                      ? Icon(Icons.arrow_forward, color: Colors.white, size: 44)
                      : Icon(Icons.check, color: Colors.white, size: 44),
                  onPressed: tapNextButton,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Stage0 extends StatelessWidget {
  const Stage0({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Spacer(flex: 1),
        Expanded(
          flex: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RecordCategory(),
              RecordAmount(),
            ],
          ),
        ),
      ],
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
    var bottom = h - 42;
    var top = 0.0;

    final path = Path();
    path.moveTo(left, top);
    path.lineTo(left, bottom);
    path.lineTo(15, bottom);
    path.arcToPoint(Offset(62, bottom), radius: Radius.circular(w * 0.05));
    path.lineTo(89, bottom);
    path.arcToPoint(Offset(136, bottom), radius: Radius.circular(w * 0.05));
    path.lineTo(w * 0.4, bottom);
    path.arcToPoint(Offset(w * 0.6, bottom), radius: Radius.circular(w * 0.1));
    path.lineTo(right, bottom);
    path.lineTo(right, top);
    path.close();
    // path.quadraticBezierTo(size.width * 0.3, 270, size.width * 0.6, 220);
    return path;
  }

  @override
  bool shouldReclip(RecordScreenClipper oldClipper) => false;
}
