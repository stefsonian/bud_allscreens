import 'package:allscreens/src/components/Ikon_button.dart';
import 'package:allscreens/src/components/gradient_box_simple.dart';
import 'package:allscreens/src/components/numpad.dart';
import 'package:allscreens/src/record/record_options.dart';
import 'package:flutter/material.dart';
import 'package:allscreens/src/helpers/colors.dart';

import 'display_amount.dart';

class RecordScreen extends StatefulWidget {
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  int activeWidget = 0;
  List<Widget> widgets;

  didChangeDependencies() {
    super.didChangeDependencies();
    widgets = [_amountAndNumpad(), _amountAndMainCategory()];
  }

  switchWidget() {
    if (activeWidget == widgets.length - 1) {
      setState(() => activeWidget = 0);
      return;
    }
    setState(() => activeWidget++);
    print('Switching to widget $activeWidget');
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text('Test'),
              onPressed: () => switchWidget(),
            ),
            SizedBox(
              height: 70,
              child: GradientBoxSimple(
                child: RecordOptions(),
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 60),
                // transitionBuilder: (Widget child, Animation<double> animation) {
                //   return ScaleTransition(child: child, scale: animation);
                // },
                child: widgets[activeWidget],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetShifter(List<Widget> widgets, int active) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      firstChild: widgets[0],
      secondChild: widgets[1],
      crossFadeState:
          active == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }

  Widget _widgetSwitcher(Widget w) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(child: child, scale: animation);
      },
      child: w,
    );
  }

  Widget _amountAndNumpad() {
    return Column(
      key: Key('0'),
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(
          height: 70,
          child: DisplayAmount(),
        ),
        Numpad(),
        SizedBox(
          width: 150,
          child: FloatingActionButton.extended(
            label: Text(
              'Next',
              textScaleFactor: 1.5,
            ),
            backgroundColor: Colors.yellow,
            foregroundColor: col_purple,
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _amountAndMainCategory() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Column(
        key: Key('1'),
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 70,
            child: DisplayAmount(),
          ),
          Expanded(
            child: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Choose a category',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        wordSpacing: 2,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IkonButton(
                          icon: Icons.restaurant,
                          color: col_purple,
                          backColor: Colors.white,
                        ),
                        IkonButton(
                          icon: Icons.hotel,
                          color: col_purple,
                          backColor: Colors.white,
                        ),
                        IkonButton(
                          icon: Icons.train,
                          color: col_purple,
                          backColor: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IkonButton(
                          icon: Icons.camera_alt,
                          color: col_purple,
                          backColor: Colors.white,
                        ),
                        IkonButton(
                          icon: Icons.scatter_plot,
                          color: col_purple,
                          backColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _SubcategoryOnly() {}
}
