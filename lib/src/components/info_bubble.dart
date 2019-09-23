import 'package:flutter/material.dart';

class InfoBubble extends StatelessWidget {
  const InfoBubble(
      {Key key,
      this.backcolor,
      this.textcolor,
      this.text1,
      this.text2,
      this.width})
      : super(key: key);
  final Color backcolor;
  final Color textcolor;
  final String text1;
  final String text2;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backcolor,
      ),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          text1 == null
              ? Container()
              : Text(
                  text1,
                  style: TextStyle(
                    color: textcolor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          text2 == null
              ? Container()
              : Text(
                  text2,
                  style: TextStyle(
                    color: textcolor,
                    fontSize: 13,
                  ),
                ),
        ],
      ),
    );
  }
}
