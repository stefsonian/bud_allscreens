import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/record_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteDialog extends StatefulWidget {
  @override
  _NoteDialogState createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  // TODO: Enable rich text editing for hashtags;
  AppState appState;
  RecordState recordState;
  var _textctrl = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appState = Provider.of<AppState>(context);
    recordState = Provider.of<RecordState>(context);
  }

  onTextChange() {
    // show hashtags in text
    // _textctrl.value
  }

  onTextSubmit(BuildContext context) {
    recordState.updateNewExpense('note', _textctrl.text);
    print('saved text: ${recordState.newExpense.note}');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      color: appState.cols.content,
      width: 500,
      child: Column(
        children: <Widget>[
          Text(
            'Add note',
            style: TextStyle(
                fontSize: 25,
                letterSpacing: 1.2,
                color: appState.cols.background2),
          ),
          SizedBox(height: 12),
          Text(
            'with #hashtags',
            style: TextStyle(
                fontSize: 18,
                letterSpacing: 1.2,
                color: appState.cols.background2),
          ),
          SizedBox(height: 40),
          TextField(
            controller: _textctrl,
            style: TextStyle(
                color: appState.cols.background2,
                fontSize: 18,
                letterSpacing: 1.2),
            minLines: 1,
            maxLines: 3,
            maxLength: 100,
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Note',
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(360),
                ),
                materialTapTargetSize: MaterialTapTargetSize.padded,
                animationDuration: Duration(milliseconds: 300),
                elevation: 1,
                color: appState.cols.background2,
                child: Icon(
                  Icons.delete,
                  color: appState.cols.content,
                  size: 28,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(360),
                ),
                materialTapTargetSize: MaterialTapTargetSize.padded,
                animationDuration: Duration(milliseconds: 300),
                elevation: 1,
                color: appState.cols.background2,
                child: Icon(
                  Icons.check,
                  color: appState.cols.content,
                  size: 34,
                ),
                onPressed: () => onTextSubmit(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
