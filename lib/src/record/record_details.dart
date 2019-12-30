import 'package:allscreens/src/components/splitter.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/services/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//WHERE
class RecordDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Splitter(
            icon: Icons.person,
            label: 'What, how much and where',
            padding: EdgeInsets.only(bottom: 15),
            showLine: false,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.restaurant,
                      size: 30,
                      color: appState.cols.content,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Breakfast',
                      style: TextStyle(
                        color: appState.cols.content,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 8, 2, 0),
                              child: Text(
                                'AUD  \$',
                                style: TextStyle(
                                  color: appState.cols.content,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Text(
                              '77.00',
                              style: TextStyle(
                                  color: appState.cols.content,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      size: 15,
                      color: appState.cols.content,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Melbourne, Australia',
                      style: TextStyle(
                        color: appState.cols.content,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Splitter(
            icon: Icons.person,
            label: 'Who paid?',
            padding: EdgeInsets.only(top: 30, bottom: 15),
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _optionBox('Plato', true, appState),
              _optionBox('Aristotle', false, appState),
              _optionBox('Pick', false, appState),
            ],
          ),
          Splitter(
            icon: Icons.calendar_today,
            label: 'When?',
            padding: EdgeInsets.only(top: 30, bottom: 15),
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _optionBox('Today', true, appState),
              _optionBox('Yesterday', false, appState),
              _optionBox('Pick', false, appState),
            ],
          ),
          Splitter(
            icon: Icons.note,
            label: 'Note',
            padding: EdgeInsets.only(top: 30, bottom: 15),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(1, 12, 1, 12),
            decoration: BoxDecoration(
              // color: appState.cols.content,
              borderRadius: BorderRadius.circular(360),
              border: Border.all(width: 1, color: appState.cols.content),
            ),
            child: Text(
              'Add a note with #hashtags',
              style: TextStyle(
                color: appState.cols.content,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ),
          Splitter(
            icon: Icons.camera_alt,
            label: 'Photo',
            padding: EdgeInsets.only(top: 30, bottom: 15),
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _optionBox('Camera', true, appState),
              _optionBox('Select', true, appState),
            ],
          ),
          Container(height: 50),
        ],
      ),
    );
  }

  Widget _optionBox(String label, bool selected, AppState appState) {
    final _optionTextStyleSelected = TextStyle(
      color: appState.cols.background2,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.1,
    );

    final _optionTextStyle = TextStyle(
      color: appState.cols.content,
      fontSize: 14,
      letterSpacing: 1.1,
    );

    var textStyle = _optionTextStyle;
    var backColor = Colors.transparent;

    if (selected) {
      textStyle = _optionTextStyleSelected;
      backColor = appState.cols.content;
    }

    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(1, 7, 1, 7),
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(360),
          border: Border.all(width: 1, color: appState.cols.content),
        ),
        child: Text(label, style: textStyle),
      ),
    );
  }
}
