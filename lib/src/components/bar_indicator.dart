import 'package:flutter/material.dart';

class BarIndicator extends StatefulWidget {
  const BarIndicator({Key key, this.fillRatio, this.color, this.height = 40.0})
      : super(key: key);
  final double fillRatio;
  final Color color;
  final double height;

  @override
  _BarIndicatorState createState() => _BarIndicatorState();
}

class _BarIndicatorState extends State<BarIndicator> {
  bool isFillZero = true;

  @override
  void initState() {
    super.initState();
    startInitialAnimation();
  }

  startInitialAnimation() {
    Future.delayed(
        Duration(milliseconds: 100), () => setState(() => isFillZero = false));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: <Widget>[
            Container(
              width: constraints.maxWidth,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: widget.color.withOpacity(0.4),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.decelerate,
              width: isFillZero ? 0.1 : widget.fillRatio * constraints.maxWidth,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: widget.color,
              ),
            ),
          ],
        );
      },
    );
  }
}
