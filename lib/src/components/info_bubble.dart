import 'package:flutter/material.dart';

class InfoBubble extends StatelessWidget {
  const InfoBubble(
      {Key key, this.backcolor, this.textcolor, this.text, this.width})
      : super(key: key);
  final Color backcolor;
  final Color textcolor;
  final String text;
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
      child: Text(
        text,
        style: TextStyle(
          color: textcolor,
          fontSize: 16,
        ),
      ),
    );
  }
}
