import 'package:eatsleeptravel/src/background/background.dart';
import 'package:eatsleeptravel/src/navigation/bottom_nav.dart';
import 'package:eatsleeptravel/src/navigation/bottom_nav_providers.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:eatsleeptravel/src/helpers/utils.dart';

class SignedInCheck extends StatefulWidget {
  const SignedInCheck({Key key, this.context}) : super(key: key);
  final BuildContext context;

  @override
  _SignedInCheckState createState() => _SignedInCheckState();
}

class _SignedInCheckState extends State<SignedInCheck> {
  AppState appState;
  SessionData sessionData;
  Records records;
  bool signInWasAttempted = false;
  final _fireAuth = FirebaseAuth.instance;

  void didChangeDependencies() {
    super.didChangeDependencies();
    appState = Provider.of<AppState>(context);
    sessionData = Provider.of<SessionData>(context);
    records = Provider.of<Records>(context);
    if (!signInWasAttempted) _attemptCurrentUserSignIn(context);
  }

  _attemptCurrentUserSignIn(BuildContext context) async {
    setState(() => signInWasAttempted = true);
    // await _fireAuth.signOut();
    var currentUser = await _fireAuth.currentUser();
    if (currentUser != null) {
      // sessionData.initialiseUserFromFirebaseUser(currentUser);
      // sessionData.initialiseTrips();
      // sessionData.initialiseUserCurrentTrip();
      // await sessionData.completeIntialisation();
      // records.maincats = sessionData.maincats;
      // records.subcats = sessionData.subcats;
      // records.currentTripId = sessionData.user.currentTrip;
      // records.initialiseRecords();
      // await records.completeIntialisation();
      // print('all init is complete');
      await Utils().completeAppInitialisation(
        currentUser,
        sessionData,
        records,
      );

      // records.createTestData(sessionData.user.currentTrip, 100, 3, 64);
      // await records.createFirestoreTestData(sessionData.user.currentTrip);
      // _navigateToMainApp(currentUser);
      appState.onLoginPath = false;
    }

    if (currentUser == null) {
      Navigator.pushReplacementNamed(context, 'sign in');
    }
  }

  _navigateToMainApp(FirebaseUser currentUser) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Background(
          child: BottomNavProviders(
            user: currentUser,
            child: BottomNav(),
          ),
        ),
      ),
    );
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
