import 'package:flutter/material.dart';

class BtmSheet extends StatefulWidget {
  @override
  _BtmSheetState createState() => _BtmSheetState();
}

class _BtmSheetState extends State<BtmSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 15, right: 15),
      height: 160,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: []),
    );
  }
}
