import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class AnimatedSpacer extends StatefulWidget {
  _AnimatedSpacerState createState() => _AnimatedSpacerState();
}

class _AnimatedSpacerState extends State<AnimatedSpacer>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    CurvedAnimation curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation = IntTween(begin: 1, end: 1000).animate(curve);
    animationController.forward();
  }

  Widget build(BuildContext context) {
    return AnimatedEntity(
      animation: animation,
    );
  }

  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class AnimatedEntity extends AnimatedWidget {
  AnimatedEntity({Key key, Animation animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    Animation animation = listenable;
    return Spacer(flex: animation.value);
  }
}
