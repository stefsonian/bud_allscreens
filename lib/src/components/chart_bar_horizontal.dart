import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';

class ChartBarHorizontal extends StatelessWidget {
  const ChartBarHorizontal(
      {Key key,
      this.exceedsChartMax,
      this.barColor = Colors.blue,
      this.labelColor = Colors.white,
      this.valueColor = Colors.black,
      this.labelBackColor = Colors.black45,
      this.labelBoxWidth = 46,
      this.barHeight = 56,
      this.label,
      this.formattedValue,
      this.scaledBarWidth,
      this.valuePrefix,
      this.showAmountAbove = false})
      : super(key: key);

  final bool exceedsChartMax;
  final Color barColor;
  final Color labelColor;
  final Color labelBackColor;
  final Color valueColor;
  final String formattedValue;
  final Widget label;
  final String valuePrefix;
  final double barHeight;
  final bool showAmountAbove;
  final double labelBoxWidth;
  final double scaledBarWidth; // a value between 0 and 1.

  @override
  Widget build(BuildContext context) {
    Widget bar = exceedsChartMax ? _excessBar() : _compliantBar();
    return Container(
      height: barHeight,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 0,
            left: labelBoxWidth,
            right: 0,
            child: AlignPositioned(
              alignment: Alignment.centerLeft,
              childWidthRatio: scaledBarWidth,
              childHeightRatio: 1.0,
              child: bar,
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: labelBoxWidth,
            right: 0,
            child: _displayValue(),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            child: _displayLabel(),
          ),
        ],
      ),
    );
  }

  Widget _displayLabel() {
    return Container(
      width: labelBoxWidth,
      height: barHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: labelBackColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: label,
    );
  }

  Widget _displayValue() {
    var valueOffset = showAmountAbove ? 0.27 : -0.05;
    if (scaledBarWidth < 0.01) valueOffset = 0.2;
    return AlignPositioned(
      alignment: Alignment.centerLeft,
      childWidthRatio: scaledBarWidth + valueOffset,
      // childWidthRatio: 1.0,
      child: Container(
        alignment: Alignment.centerRight,
        child: Text(
          formattedValue,
          style: TextStyle(
            color: showAmountAbove ? barColor : valueColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _compliantBar() {
    return Container(
      height: barHeight,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          stops: [0, 1],
          colors: [barColor, barColor.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
    );
  }

  Widget _excessBar() {
    return ClipPath(
      clipper: ExcessClipperBottom(),
      child: Container(
        height: barHeight,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            stops: [0, 1],
            colors: [barColor, barColor.withOpacity(0.8)],
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
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
    var h = size.width;

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
    var h = size.width;

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
