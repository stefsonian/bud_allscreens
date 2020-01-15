import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_colorpicker/material_picker.dart';
import 'package:provider/provider.dart';

// create some values

class ColorPickler extends StatefulWidget {
  @override
  _ColorPicklerState createState() => _ColorPicklerState();
}

class _ColorPicklerState extends State<ColorPickler> {
  AppState appState;
  Color pickerColor = Color(0xff443a49);

  @override
  void didChangeDependencies() {
    appState = Provider.of<AppState>(context);
    // appState.showQuickAddButton = false;
    super.didChangeDependencies();
  }

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void handleTap(String colorName) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: appState.cols.asMap()[colorName],
            onColorChanged: changeColor,
            enableLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
          // Use Material color picker:
          //
          // child: MaterialPicker(
          //   pickerColor: appState.cols.asMap()[colorName],
          //   onColorChanged: changeColor,
          //   enableLabel: true, // only on portrait mode
          // ),
          //
          // Use Block color picker:
          //
          // child: BlockPicker(
          //   pickerColor: appState.cols.asMap()[colorName],
          //   onColorChanged: changeColor,
          // ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Got it'),
            onPressed: () {
              appState.changeColor(colorName, pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: appState.cols
              .asMap()
              .entries
              .map((m) => buildStripe(m.key, m.value))
              .toList(),
        ),
      ),
    );
  }

  Widget buildStripe(String colorName, Color color) {
    return Expanded(
      child: Container(
        color: color,
        child: FlatButton(
          child: Text(colorName, style: TextStyle(fontSize: 20)),
          onPressed: () => handleTap(colorName),
        ),
      ),
    );
  }
}
