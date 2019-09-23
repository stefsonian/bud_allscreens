import 'package:allscreens/src/components/factoid.dart';
import 'package:allscreens/src/components/info_bubble.dart';
import 'package:allscreens/src/front/trip_options_popup.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:flutter/material.dart';

class FrontTrip extends StatefulWidget {
  @override
  _FrontTripState createState() => _FrontTripState();
}

class _FrontTripState extends State<FrontTrip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 6, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('Trip'),
                ],
              ),
              TripOptionsPopup(),
            ],
          ),
          SizedBox(height: 6),
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
              // Factoid(fact: "14 Aug '19", label: 'Start'),
              // Factoid(fact: "27 Oct '19", label: 'End'),
              // Factoid(fact: '5', label: 'Day', center: true),
              InfoBubble(
                backcolor: col_aqua,
                textcolor: Colors.white,
                text1: "Start  ",
                text2: "14 Aug",
              ),
              InfoBubble(
                backcolor: col_aqua,
                textcolor: Colors.white,
                text1: "End  ",
                text2: "27 Oct",
              ),
              InfoBubble(
                backcolor: col_aqua,
                textcolor: Colors.white,
                text1: "Day  ",
                text2: "5",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
