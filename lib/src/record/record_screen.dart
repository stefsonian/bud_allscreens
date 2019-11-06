import 'package:allscreens/src/background/background.dart';
import 'package:allscreens/src/components/content_box.dart';
import 'package:allscreens/src/components/gradient_box_simple.dart';
import 'package:allscreens/src/components/numpad.dart';
import 'package:allscreens/src/record/record_amount.dart';
import 'package:allscreens/src/record/record_categories.dart';
import 'package:allscreens/src/record/record_options.dart';
import 'package:allscreens/src/record/record_other.dart';
import 'package:allscreens/src/record/record_stepper.dart';
import 'package:allscreens/src/record/record_submit.dart';
import 'package:allscreens/src/services/app_state.dart';
import 'package:allscreens/src/services/record_state.dart';
import 'package:flutter/material.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:clip_shadow/clip_shadow.dart';

import 'display_amount.dart';
import 'display_categories.dart';

class RecordScreen extends StatefulWidget {
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  AppState appState;
  RecordState recordState;

  final inputWidgets = [
    RecordAmount(),
    RecordMainCategory(),
    RecordSubCategory(),
    // RecordOther(),
    RecordSubmit(),
    // Container(),
    Container()
  ];

  didChangeDependencies() {
    super.didChangeDependencies();
    recordState = Provider.of<RecordState>(context);
    appState = Provider.of<AppState>(context);
    // Future.microtask(() => appState.showQuickAddButton = false);
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
            Positioned(
              top: 20,
              bottom: 420,
              left: 0,
              right: 0,
              child: RecordOptions(),
            ),
            Positioned(
              bottom: 130,
              left: 0,
              right: 0,
              child: RecordAmount(),
            ),
            Positioned(
              bottom: 35,
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
              bottom: 35,
              left: 92.5,
              child: SizedBox(
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  backgroundColor: col_orange_dark,
                  elevation: 2,
                  child: Icon(Icons.arrow_back, color: Colors.white, size: 33),
                  onPressed: () => appState.activeTabIndex = 0,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: width * 0.5 - 35,
              child: SizedBox(
                height: 70,
                width: 70,
                child: FloatingActionButton(
                  backgroundColor: col_orange,
                  elevation: 2,
                  child:
                      Icon(Icons.arrow_forward, color: Colors.white, size: 44),
                  onPressed: () => appState.activeTabIndex = 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecordScreenClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var w = size.width;
    var h = size.height;

    var left = w * 0.0;
    var right = w;
    var bottom = h - 55;
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

class RecordScreenBackground extends StatelessWidget {
  const RecordScreenBackground({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 1],
          colors: [col_aqua, col_aqua_lighter],
          // colors: [col_aqua_lighter, col_aqua],
        ),
        boxShadow: kElevationToShadow[4],
      ),
      // color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: child,
    );
  }
}
