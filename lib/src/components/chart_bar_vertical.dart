import 'dart:math';

import 'package:align_positioned/align_positioned.dart';
import 'package:allscreens/src/components/animated_spacer.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
// import 'package:matrix4_transform/matrix4_transform.dart';

class ChartBarVertical extends StatelessWidget {
  const ChartBarVertical(
      {Key key,
      this.value,
      this.threshold1,
      this.threshold2,
      this.complyColor = Colors.blue,
      this.exceedColor = Colors.deepOrange,
      this.labelLine1,
      this.labelLine2,
      this.valuePrefix,
      this.labelColor = Colors.white,
      this.valueColor = Colors.black,
      this.labelBackColor = Colors.black45,
      this.showAmountAbove = false})
      : super(key: key);
  final double value;
  final double threshold1;
  final double threshold2;
  final Color complyColor;
  final Color exceedColor;
  final String labelLine1;
  final String labelLine2;
  final String valuePrefix;
  final double width = 56;
  final Color labelBackColor;
  final Color labelColor;
  final Color valueColor;
  final bool showAmountAbove;
  final double labelBoxHeight = 36;

  @override
  Widget build(BuildContext context) {
    double ratio1 = value / threshold1;
    double ratio2 = value / threshold2;
    double heightRatio = min(1.0, ratio2);
    Color color = ratio1 > 1 ? exceedColor : complyColor;
    Widget bar =
        ratio2 > 1.0 ? _excessBar(color: color) : _compliantBar(color: color);
    return Container(
      width: width,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: labelBoxHeight,
            left: 0,
            right: 0,
            child: AlignPositioned(
              alignment: Alignment.bottomCenter,
              childHeightRatio: heightRatio,
              childWidthRatio: 1.0,
              child: bar,
            ),
          ),
          Positioned(
            top: 0,
            bottom: labelBoxHeight,
            left: 0,
            right: 0,
            child: _displayValue(
              color: color,
              amountAbove: showAmountAbove,
              heightRatio: heightRatio,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _displayLabel(),
          ),
        ],
      ),
    );
  }

  Widget _displayLabel() {
    return Container(
      height: labelBoxHeight,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: labelBackColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Text(
        labelLine1,
        style: TextStyle(
          color: labelColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _displayValue(
      {Color color, bool amountAbove = false, double heightRatio}) {
    var valueOffset = amountAbove ? 0.1 : -0.05;
    return AlignPositioned(
      alignment: Alignment.bottomCenter,
      childHeightRatio: heightRatio + valueOffset,
      childWidthRatio: 1.0,
      child: Container(
        alignment: Alignment.topCenter,
        child: Text(
          value.toStringAsFixed(0),
          style: TextStyle(
            color: amountAbove ? color : valueColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _compliantBar({Color color}) {
    return Container(
      width: width,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 1],
          colors: [color, color.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }

  Widget _excessBar({Color color}) {
    return ClipPath(
      clipper: ExcessClipperBottom(),
      child: Container(
        width: width,
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 1],
            colors: [color, color.withOpacity(0.8)],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
      ),
    );
  }
}

class ExcessClipperBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var w = size.width;
    var h = size.height;

    var left = 0.0;
    var right = w;
    var bottom = h;
    var top = 36.0;
    var dip = 10.0;
    var space = 8.0;
    var top2 = top + space;

    final path = Path();
    path.moveTo(left, 0.0);

    path.lineTo(left, top + dip);
    path.lineTo(right * 0.1, top);
    path.lineTo(right * 0.2, top + dip);
    path.lineTo(right * 0.3, top);
    path.lineTo(right * 0.4, top + dip);
    path.lineTo(right * 0.5, top);
    path.lineTo(right * 0.6, top + dip);
    path.lineTo(right * 0.7, top);
    path.lineTo(right * 0.8, top + dip);
    path.lineTo(right * 0.9, top);
    path.lineTo(right, top + dip);
    path.lineTo(right, 0.0);

    path.moveTo(right, top2 + dip);
    path.lineTo(right * 0.9, top2);
    path.lineTo(right * 0.8, top2 + dip);
    path.lineTo(right * 0.7, top2);
    path.lineTo(right * 0.6, top2 + dip);
    path.lineTo(right * 0.5, top2);
    path.lineTo(right * 0.4, top2 + dip);
    path.lineTo(right * 0.3, top2);
    path.lineTo(right * 0.2, top2 + dip);
    path.lineTo(right * 0.1, top2);
    path.lineTo(left, top2 + dip);

    path.lineTo(left, bottom);
    path.lineTo(right, bottom);
    path.lineTo(right, top2 + dip);
    path.moveTo(right, 0.0);

    return path;
  }

  @override
  bool shouldReclip(ExcessClipperBottom oldClipper) => false;
}

class NoClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var w = size.width;
    var h = size.height;

    var left = 0.0;
    var right = w;
    var bottom = h;
    var top = 0.0;

    final path = Path();
    path.moveTo(left, top);
    path.lineTo(left, bottom);
    path.lineTo(right, bottom);
    path.lineTo(right, top);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(NoClipper oldClipper) => false;
}

//  AnimatedSpacer(begin: 1000, end: 101 - min(100, pct2)),
//         Expanded(
//           flex: min(100, pct2),
//           child: pct2 > 100
//               ? _excessBar(color, valueColor)
//               : _compliantBar(color: color, amountAbove: showAmountAbove),
//         ),
// Expanded(
//   flex: min(100, pct2),
//   child: pct2 > 100
//       ? _excessBar(color, valueColor)
//       : _compliantBar(color: color, amountAbove: showAmountAbove),
// ),
