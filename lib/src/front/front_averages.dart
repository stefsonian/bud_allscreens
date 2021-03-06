import 'package:eatsleeptravel/src/components/content_box.dart';
import 'package:eatsleeptravel/src/components/factoid_circle.dart';
import 'package:eatsleeptravel/src/helpers/colors.dart';
import 'package:flutter/material.dart';

class FrontAverages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContentBox(
      padding: EdgeInsets.fromLTRB(14, 2, 14, 14),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Average spend (AUD)',
                style: TextStyle(fontSize: 16),
              ),
              IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FactoidCircle(
                fact: '42',
                label: 'day',
                backColor: col_main4,
              ),
              FactoidCircle(
                fact: '588',
                label: 'week',
                backColor: col_main4,
              ),
              FactoidCircle(
                fact: '1773',
                label: 'month',
                backColor: col_main4,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
