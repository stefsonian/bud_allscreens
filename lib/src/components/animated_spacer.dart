import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

class AnimatedSpacer extends StatelessWidget {
  const AnimatedSpacer(
      {Key key,
      this.begin,
      this.end,
      this.ms = 500,
      this.curve = Curves.linear})
      : super(key: key);
  final int begin;
  final int end;
  final int ms; // milliseconds
  final Curve curve;

  Widget build(BuildContext context) {
    return Animator<int>(
      duration: Duration(milliseconds: ms),
      tween: IntTween(begin: begin, end: end),
      cycles: 1,
      builder: (anim) => Spacer(flex: anim.value),
      triggerOnInit: true,
    );
  }
}
