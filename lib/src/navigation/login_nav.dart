import 'package:eatsleeptravel/src/login/login_user.dart';
import 'package:eatsleeptravel/src/login/register_user.dart';
import 'package:eatsleeptravel/src/login/signed_in_check.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(onGenerateRoute: (RouteSettings settings) {
      switch (settings.name) {
        // case '/':
        //   return PageTransition(
        //       child: LoginUser(), type: PageTransitionType.leftToRightWithFade);
        //   break;
        case '/':
          return PageTransition(
              child: SignedInCheck(), type: PageTransitionType.fade);
          break;
        case 'sign in':
          return PageTransition(
              child: LoginUser(), type: PageTransitionType.leftToRightWithFade);
          break;
        case 'sign up':
          return PageTransition(
              child: RegisterUser(),
              type: PageTransitionType.rightToLeftWithFade);
          break;
      }
    });
  }
}
