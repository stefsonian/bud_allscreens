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
  double screenHeight;
  int activeWidget = 0;
  List<Widget> widgets;
  double bufferHeight;

  didChangeDependencies() {
    super.didChangeDependencies();
    screenHeight = MediaQuery.of(context).size.height;
    setBufferHeight();
    widgets = [Numpad(), _mainCategoryOnly(), _subcategoryOnly()];
  }

  setBufferHeight() {
    double newHeight = 16.0;
    if (activeWidget == 0) {
      newHeight = screenHeight < 830 ? 28.0 : 58.0;
    }
    setState(() => bufferHeight = newHeight);
  }

  switchWidget() {
    if (activeWidget == widgets.length - 1) {
      setState(() => activeWidget = 0);
    } else {
      setState(() => activeWidget++);
    }
    setBufferHeight();
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
            _recordOptions(),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: bufferHeight,
            ),
            _amount(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(child: child, scale: animation);
                    },
                    child: widgets[activeWidget],
                  ),
                  if (activeWidget == 0) _nextButton(),
                ],
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

  Widget _amount() {
    return SizedBox(
      height: 70,
      child: DisplayAmount(),
    );
  }

  Widget _buffer(double screenHeight) {
    double boxHeight = 28.0;
    if (screenHeight > 830) boxHeight = 84.0;
    return SizedBox(height: boxHeight);
  }

  Widget _recordOptions() {
    return SizedBox(
      height: 70,
      child: GradientBoxSimple(
        child: RecordOptions(),
      ),
    );
  }

  Widget _nextButton() {
    return SizedBox(
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
    );
  }

  Widget _mainCategoryOnly() {
    return Center(
      key: Key('mainCat'),
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
    );
  }

  Widget _subcategoryOnly() {
    return Center(
      key: Key('subCats'),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Choose a sub-category',
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
                  icon: Icons.train,
                  color: col_purple,
                  backColor: Colors.white,
                ),
                IkonButton(
                  icon: Icons.tram,
                  color: col_purple,
                  backColor: Colors.white,
                ),
                IkonButton(
                  icon: Icons.directions_bus,
                  color: col_purple,
                  backColor: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IkonButton(
                  icon: Icons.directions_subway,
                  color: col_purple,
                  backColor: Colors.white,
                ),
                IkonButton(
                  icon: Icons.flight,
                  color: col_purple,
                  backColor: Colors.white,
                ),
                IkonButton(
                  icon: Icons.directions_boat,
                  color: col_purple,
                  backColor: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IkonButton(
                  icon: Icons.directions_car,
                  color: col_purple,
                  backColor: Colors.white,
                ),
                IkonButton(
                  icon: Icons.directions_bike,
                  color: col_purple,
                  backColor: Colors.white,
                ),
                IkonButton(
                  icon: Icons.directions_run,
                  color: col_purple,
                  backColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
