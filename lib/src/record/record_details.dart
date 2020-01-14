import 'package:allscreens/src/components/splitter.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/record/note_dialog.dart';
import 'package:allscreens/src/services/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordDetails extends StatelessWidget {
  showNoteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            children: <Widget>[NoteDialog()],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          amountHeaderLarge(appState),
          FlatButton(
            padding: EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  size: 20,
                  color: appState.cols.content,
                ),
                SizedBox(width: 8),
                Text(
                  'Melbourne, Australia',
                  style: TextStyle(
                    color: appState.cols.content,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.repeat,
                        size: 20,
                        color: appState.cols.content.withOpacity(0.6),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Repeat',
                        style: TextStyle(
                          color: appState.cols.content.withOpacity(0.6),
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: appState.cols.content,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Today',
                        style: TextStyle(
                          color: appState.cols.content,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        Icons.call_split,
                        size: 20,
                        color: appState.cols.content.withOpacity(0.6),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Split',
                        style: TextStyle(
                          color: appState.cols.content.withOpacity(0.6),
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          FlatButton(
            padding: EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.note,
                  size: 20,
                  color: appState.cols.content,
                ),
                SizedBox(width: 8),
                Text(
                  'Add note with #hashtags',
                  style: TextStyle(
                    color: appState.cols.content,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            onPressed: () => showNoteDialog(context),
          ),
          FlatButton(
            padding: EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.camera_alt,
                  size: 20,
                  color: appState.cols.content,
                ),
                SizedBox(width: 8),
                Text(
                  'Add photo',
                  style: TextStyle(
                    color: appState.cols.content,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget amountHeaderLarge(AppState appState) {
    final Color color = appState.cols.content;
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(360),
        border: Border.all(width: 2, color: color),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.restaurant,
            color: color,
            size: 50,
          ),
          SizedBox(height: 20),
          Text(
            'Restaurant',
            style: TextStyle(
              color: color,
              fontSize: 35,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 2, 0),
                child: Text(
                  'AUD  \$',
                  style: TextStyle(
                    color: color,
                    fontSize: 18,
                  ),
                ),
              ),
              Text(
                '77.00',
                style: TextStyle(
                    color: color, fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
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

// Row(
//             // mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               _optionBox('Plato', true, appState),
//               _optionBox('Aristotle', false, appState),
//               _optionBox('Pick', false, appState),
//             ],
//           ),
//           Splitter(
//             icon: Icons.calendar_today,
//             label: 'When?',
//             padding: EdgeInsets.only(top: 30, bottom: 15),
//           ),
//           Row(
//             // mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               _optionBox('Today', true, appState),
//               _optionBox('Yesterday', false, appState),
//               _optionBox('Pick', false, appState),
//             ],
//           ),
//           Splitter(
//             icon: Icons.note,
//             label: 'Note',
//             padding: EdgeInsets.only(top: 30, bottom: 15),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 12),
//             alignment: Alignment.center,
//             padding: EdgeInsets.fromLTRB(1, 12, 1, 12),
//             decoration: BoxDecoration(
//               // color: appState.cols.content,
//               borderRadius: BorderRadius.circular(360),
//               border: Border.all(width: 1, color: appState.cols.content),
//             ),
//             child: Text(
//               'Add a note with #hashtags',
//               style: TextStyle(
//                 color: appState.cols.content,
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 1.1,
//               ),
//             ),
//           ),
//           Splitter(
//             icon: Icons.camera_alt,
//             label: 'Photo',
//             padding: EdgeInsets.only(top: 30, bottom: 15),
//           ),
//           Row(
//             // mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               _optionBox('Camera', true, appState),
//               _optionBox('Select', true, appState),
//             ],
//           ),
//           Container(height: 50),
