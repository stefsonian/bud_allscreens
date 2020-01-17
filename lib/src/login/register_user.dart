import 'package:eatsleeptravel/src/background/background.dart';
import 'package:eatsleeptravel/src/components/loading_spinner.dart';
import 'package:eatsleeptravel/src/components/some_alert_dialog.dart';
import 'package:eatsleeptravel/src/models/User.dart';
import 'package:eatsleeptravel/src/navigation/bottom_nav.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/authentication_service.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterUser extends StatefulWidget {
  RegisterUser({Key key}) : super(key: key);

  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  AppState appState;
  SessionData sessionData;
  final _authService = AuthenticationService();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  var isWaiting = false;

  void didChangeDependencies() {
    super.didChangeDependencies();
    appState = Provider.of<AppState>(context);
    sessionData = Provider.of<SessionData>(context);
  }

  onSignUpTap(BuildContext context) async {
    setState(() => isWaiting = true);
    var email = _emailCtrl.text;
    var pwd = _passwordCtrl.text;
    var result = await _authService.signUpWithEmail(
      email: email,
      password: pwd,
    );
    // result is either a bool stating whether signup was successful,
    // or it is an error message emanating from the signup process.
    if (result is bool) {
      if (result) {
        sessionData.initialiseUserFromFirebaseUser(_authService.user);

        await sessionData.initialiseUser();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Background(
              child: BottomNav(),
            ),
          ),
        );
      } else {
        SomeAlertDialog(
          title: 'Oh no!',
          text: 'Signup failed. Please try again later',
        ).flashDialog(context);
      }
    }

    if (result is String) {
      SomeAlertDialog(
        title: 'Oh no, signup failure!',
        text: result,
      ).flashDialog(context);
    }
    setState(() => isWaiting = false);
  }

  Widget build(BuildContext context) {
    var fieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(360),
      borderSide: BorderSide(
        color: appState.cols.content.withOpacity(0.5),
        width: 1,
      ),
    );
    var fieldBorderFocus = OutlineInputBorder(
      borderRadius: BorderRadius.circular(360),
      borderSide: BorderSide(
        color: appState.cols.content,
        width: 1,
      ),
    );
    var fieldTextStyle = TextStyle(
      color: appState.cols.content,
      letterSpacing: 1.6,
    );
    var hintTextStyle = TextStyle(
      color: appState.cols.content.withOpacity(0.7),
      letterSpacing: 1.6,
    );
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'eat sleep travel',
                  style: TextStyle(
                      fontSize: 30,
                      letterSpacing: 1.6,
                      wordSpacing: 2,
                      color: appState.cols.content),
                ),
                SizedBox(height: 40),
                TextField(
                  controller: _emailCtrl,
                  style: fieldTextStyle,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: appState.cols.content,
                    ),
                    border: fieldBorder,
                    enabledBorder: fieldBorder,
                    focusedBorder: fieldBorderFocus,
                    hintText: 'you@email.com',
                    hintStyle: hintTextStyle,
                    labelText: 'Email',
                    labelStyle: fieldTextStyle,
                    alignLabelWithHint: false,
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _passwordCtrl,
                  style: fieldTextStyle,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: appState.cols.content,
                    ),
                    border: fieldBorder,
                    enabledBorder: fieldBorder,
                    focusedBorder: fieldBorderFocus,
                    hintText: '********',
                    hintStyle: hintTextStyle,
                    labelText: 'Password',
                    labelStyle: fieldTextStyle,
                    alignLabelWithHint: false,
                  ),
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: 180,
                  child: FloatingActionButton.extended(
                    label: Text(
                      'Sign up',
                      style: TextStyle(color: appState.cols.background1),
                    ),
                    icon: Icon(Icons.person, color: appState.cols.background1),
                    backgroundColor: appState.cols.content,
                    heroTag: 'Sign up',
                    onPressed: () => onSignUpTap(context),
                  ),
                ),
                SizedBox(height: 100),
                SizedBox(
                  // width: 180,
                  child: FlatButton(
                    child: Text(
                      'Already signed up? Sign in now',
                      style: TextStyle(
                        color: appState.cols.content.withOpacity(0.7),
                        letterSpacing: 1.6,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () => appState.loginStage = 'sign in',
                  ),
                ),
                SizedBox(height: 30),
                isWaiting ? LoadingSpinner() : Container(),
              ],
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Container(),
          // ),
        ],
      ),
    );
  }
}
