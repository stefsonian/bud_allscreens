import 'package:allscreens/src/helpers/colors.dart';
import 'package:flutter/material.dart';

const List<String> companions = [
  'Democrit',
  'Anaximander',
  'Plato',
  'Aristotle'
];

class TripCompanionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: companions.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            // height: 16,
            child: _companionTile(companions[index]),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }

  Widget _companionTile(String companion) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 4, 0, 4),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  companion,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Full access',
                  style: TextStyle(
                    fontSize: 12,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 38,
            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Row(
              children: <Widget>[
                FloatingActionButton(
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.blueGrey,
                  onPressed: () {},
                ),
                SizedBox(width: 5),
                FloatingActionButton(
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                  backgroundColor: col_main1,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
