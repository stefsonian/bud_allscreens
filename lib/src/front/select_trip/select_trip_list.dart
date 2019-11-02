import 'package:flutter/material.dart';

const List<String> trips = ['Buenos Aires', 'Copenhagen', 'Brisbane', 'Toledo'];

class SelectTripList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: trips.length,
        itemBuilder: (BuildContext context, int index) {
          var isSelected = index == 2;

          return Container(
            // height: 16,
            child: _tripTile(trips[index], isSelected),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }

  Widget _tripTile(String trip, bool isSelected) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 4, 0, 4),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  trip,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '12 Oct 2019 - 20 Jan 2020',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Total spend: AUD \$2380',
                  style: TextStyle(
                    fontSize: 12,
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
                    Icons.check,
                    color: Colors.white,
                  ),
                  backgroundColor: isSelected ? Colors.green : Colors.grey,
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
