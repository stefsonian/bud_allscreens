import 'package:flutter/material.dart';

class FactoidCircle extends StatelessWidget {
  const FactoidCircle(
      {this.fact,
      this.label,
      this.textColor = Colors.white,
      this.backColor = Colors.black});
  final String fact;
  final String label;
  final Color textColor;
  final Color backColor;

  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backColor,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 1],
          colors: [backColor.withOpacity(0.8), backColor],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Text(
            fact,
            style: TextStyle(
              color: textColor,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 4),
          Container(
            height: 1,
            width: 70,
            color: textColor,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 4),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
