import 'package:allscreens/src/components/gradient_box_simple.dart';
import 'package:allscreens/src/services/record_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordSubmit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RecordState recordState = Provider.of<RecordState>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: FloatingActionButton.extended(
                label: Text('Cancel', textScaleFactor: 1.1),
                icon: Icon(Icons.delete),
                backgroundColor: Colors.orange[500],
                onPressed: () => recordState.reset(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: FloatingActionButton.extended(
                  label: Text('Done', textScaleFactor: 1.1),
                  icon: Icon(Icons.check),
                  backgroundColor: Colors.green[500],
                  onPressed: () => recordState.reset(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
