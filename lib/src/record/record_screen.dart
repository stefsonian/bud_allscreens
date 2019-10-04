import 'package:allscreens/src/components/content_box.dart';
import 'package:allscreens/src/components/gradient_box_simple.dart';
import 'package:allscreens/src/components/numpad.dart';
import 'package:allscreens/src/record/record_amount.dart';
import 'package:allscreens/src/record/record_categories.dart';
import 'package:allscreens/src/record/record_options.dart';
import 'package:allscreens/src/record/record_other.dart';
import 'package:allscreens/src/record/record_submit.dart';
import 'package:allscreens/src/services/record_state.dart';
import 'package:flutter/material.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:provider/provider.dart';

import 'display_amount.dart';
import 'display_categories.dart';

class RecordScreen extends StatefulWidget {
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
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
  }

  tapNextButton() => recordState.isAmountRecorded = true;
  tapAmountBox() => recordState.isAmountRecorded = false;
  tapMainCat() => recordState.isMainCatRecorded = true;
  tapSubCat() => recordState.isSubCatRecorded = true;
  tapCategoriesBox() {
    recordState.isMainCatRecorded = false;
    recordState.isSubCatRecorded = false;
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 22, 15, 15),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 76,
                child: ContentBox(
                  child: RecordOptions(),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: (recordState.isCategoriesRecorded &&
                      !recordState.isAmountRecorded)
                  ? 200
                  : 100,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: tapAmountBox,
                child: SizedBox(
                  height: 76,
                  child: DisplayAmount(),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: recordState.recordStage == 3 ? 200 : 100,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                curve: Curves.linear,
                opacity: recordState.isCategoriesRecorded ? 1 : 0,
                child: GestureDetector(
                  onTap: tapCategoriesBox,
                  child: SizedBox(
                    height: 76,
                    child: DisplayCategories(
                      label: 'Excursion',
                      mainIcon: Icons.camera_alt,
                      subIcon: Icons.landscape,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: recordState.isCategoriesRecorded ? 300 : 200,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(child: child, scale: animation);
                      },
                      child: inputWidgets[recordState.recordStage],
                    ),
                  ),
                  // if (!recordState.isAmountRecorded) _nextButton(),
                ],
              ),
            ),
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   child: FlatButton(
            //     child: Text('Test: ${appState.isAmountRecorded.toString()}'),
            //     onPressed: updateRecordStage,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

final BoxDecoration _boxDecor = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(25),
  boxShadow: kElevationToShadow[1],
);
