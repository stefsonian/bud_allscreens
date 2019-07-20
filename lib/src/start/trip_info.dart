import 'package:allscreens/src/components/factoid.dart';
import 'package:flutter/material.dart';

class TripInfo extends StatefulWidget {
  @override
  _TripInfoState createState() => _TripInfoState();
}

class _TripInfoState extends State<TripInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Queensland',
          textScaleFactor: 2,
        ),
        SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Factoid(fact: "14 Aug '19", label: 'Start'),
            Factoid(fact: "27 Oct '19", label: 'End'),
            Factoid(fact: '5', label: 'Day', center: true),
          ],
        ),
      ],
    );
  }
}
