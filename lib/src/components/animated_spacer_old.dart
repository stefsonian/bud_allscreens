import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class AnimatedSpacer extends StatefulWidget {
  const AnimatedSpacer({Key key, this.expanded, this.max, this.min})
      : super(key: key);
  final bool expanded;
  final int max;
  final int min;

  _AnimatedSpacerState createState() => _AnimatedSpacerState();
}

class _AnimatedSpacerState extends State<AnimatedSpacer>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  var expandedStatus;
  var forwardNext = true;
  int begin;
  int end;

  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    CurvedAnimation curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation = IntTween(begin: 1, end: 1000).animate(curve);
    animationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    expandedStatus = widget.expanded;
    begin = expandedStatus ? widget.max : widget.min;
    end = expandedStatus ? widget.min : widget.max;
  }

  updateController() {
    if (forwardNext) {
      setState(() {
        // controller = 'Forward: I was ${expandedStatus.toString()}';
        animationController.forward();
        forwardNext = false;
      });
    } else if (!forwardNext) {
      setState(() {
        // controller = 'Reverse: I was ${expandedStatus.toString()}';
        animationController.reverse();
        forwardNext = true;
      });
    }
    expandedStatus = !expandedStatus;
  }

  Widget build(BuildContext context) {
    if (expandedStatus != widget.expanded) updateController();
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
