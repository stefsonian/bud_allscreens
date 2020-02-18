import 'package:flutter/material.dart';

class DialogHeader extends StatelessWidget {
  const DialogHeader(
      {Key key, this.mainHeader, this.subHeader, this.color, this.height = 100})
      : super(key: key);
  final String mainHeader;
  final String subHeader;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            mainHeader,
            style: TextStyle(fontSize: 20, letterSpacing: 1.2, color: color),
            textAlign: TextAlign.center,
          ),
          subHeader == null
              ? Container()
              : Column(
                  children: <Widget>[
                    SizedBox(height: 12),
                    Text(
                      subHeader,
                      style: TextStyle(
                          fontSize: 14, letterSpacing: 1.2, color: color),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
