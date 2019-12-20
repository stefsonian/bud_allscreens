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
        borderRadius: BorderRadius.circular(14),
        // border: Border.all(color: Colors.black87),
        boxShadow: kElevationToShadow[1],
      ),
      // color: Colors.white,
      // height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  // Text('Trip'),
                  // SizedBox(width: 10),
                  Text(
                    'Queensland',
                    textScaleFactor: 2,
                  ),
                ],
              ),
              TripOptionsPopup(),
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Factoid(fact: "14 Aug '19", label: 'Start'),
              // Factoid(fact: "27 Oct '19", label: 'End'),
              // Factoid(fact: '5', label: 'Day', center: true),
              InfoBubble(
                backcolor: col_main1,
                textcolor: Colors.white,
                text1: "Start  ",
                text2: "14 Aug",
              ),
              InfoBubble(
                backcolor: col_main1,
                textcolor: Colors.white,
                text1: "End  ",
                text2: "27 Oct",
              ),
              InfoBubble(
                backcolor: col_main1,
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

const Color col1 = Color(0xFF56ab2f);
const Color col2 = Color(0xFFa8e063);

final BoxDecoration _boxDecor = BoxDecoration(
  // gradient: LinearGradient(
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  //   stops: [0, 1],
  //   colors: [col1.withOpacity(0.8), col2],
  // ),
  borderRadius: BorderRadius.circular(16),
  // boxShadow: kElevationToShadow[1],
);
