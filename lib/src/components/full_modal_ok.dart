import 'dart:ui';

import 'package:eatsleeptravel/src/services/expense_list_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullModalOk extends ModalRoute<void> {
  FullModalOk(
      {@required this.header,
      @required this.body,
      @required this.onOkTap,
      @required this.buttonColor,
      this.parentContext});
  final Widget header;
  final Widget body;
  final Function onOkTap;
  final Color buttonColor;
  final BuildContext parentContext;

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.65);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  // @override
  // BuildContext get subtreeContext => parentContext;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: Container(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10.0, sigmaX: 10.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  header,
                  Expanded(child: body),
                  _buttons(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    return Container(
      height: 70,
      // padding: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: buttonColor.withOpacity(0.4),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Icon(Icons.close, color: buttonColor, size: 34),
              // child: Text('Cancel',
              //     style: _textStyle.copyWith(color: buttonColor)),
            ),
          ),
          // Container(
          //   width: 1,
          //   color: buttonColor.withOpacity(0.4),
          // ),
          Expanded(
            child: FlatButton(
              onPressed: onOkTap,
              child: Icon(Icons.check, color: buttonColor, size: 34),
              // child: Text('OK', style: _textStyle.copyWith(color: buttonColor)),
            ),
          ),
        ],
      ),
    );
  }

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    letterSpacing: 1.8,
  );

  // @override
  // Widget buildTransitions(BuildContext context, Animation<double> animation,
  //     Animation<double> secondaryAnimation, Widget child) {
  //   // You can add your own animations for the overlay content
  //   return FadeTransition(
  //     opacity: animation,
  //     child: child,
  //   );
  // }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
