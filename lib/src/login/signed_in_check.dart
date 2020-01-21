import 'package:eatsleeptravel/src/background/background.dart';
import 'package:eatsleeptravel/src/navigation/bottom_nav.dart';
import 'package:eatsleeptravel/src/navigation/bottom_nav_providers.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignedInCheck extends StatefulWidget {
  const SignedInCheck({Key key, this.context}) : super(key: key);
  final BuildContext context;

  @override
  _SignedInCheckState createState() => _SignedInCheckState();
}

class _SignedInCheckState extends State<SignedInCheck> {
  AppState appState;
  final _fireAuth = FirebaseAuth.instance;

  void didChangeDependencies() {
    super.didChangeDependencies();
    appState = Provider.of<AppState>(context);
    _attemptCurrentUserSignIn();
  }

  _attemptCurrentUserSignIn() async {
    // await _fireAuth.signOut();
    var currentUser = await _fireAuth.currentUser();
    if (currentUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Background(
            child: BottomNavProviders(
              user: currentUser,
              appState: appState,
              child: BottomNav(),
            ),
          ),
        ),
      );
    }

    if (currentUser == null) {
      Navigator.pushReplacementNamed(context, 'sign in');
    }
  }

  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
