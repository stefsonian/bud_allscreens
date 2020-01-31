import 'package:eatsleeptravel/src/app.dart';
import 'package:eatsleeptravel/src/background/background.dart';
import 'package:eatsleeptravel/src/components/loading_spinner.dart';
import 'package:eatsleeptravel/src/components/some_alert_dialog.dart';
import 'package:eatsleeptravel/src/helpers/utils.dart';
import 'package:eatsleeptravel/src/navigation/bottom_nav.dart';
import 'package:eatsleeptravel/src/navigation/bottom_nav_providers.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/authentication_service.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginUser extends StatefulWidget {
  LoginUser({Key key}) : super(key: key);

  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  AppState appState;
  SessionData sessionData;
  Records records;
  final _authService = AuthenticationService();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  var isWaiting = false;

  void didChangeDependencies() {
    super.didChangeDependencies();
    appState = Provider.of<AppState>(context);
    sessionData = Provider.of<SessionData>(context);
    records = Provider.of<Records>(context);
    // if (_authService.user != null) _onSuccessfulSignIn();
  }

  onLoginTap() async {
    setState(() => isWaiting = true);
    var email = _emailCtrl.text.trim();
    var pwd = _passwordCtrl.text;
    var result = await _authService.loginWithEmail(
      email: email,
      password: pwd,
    );
    await _processLoginResult(result);
    setState(() => isWaiting = false);
  }

  onSkipTap() async {
    setState(() => isWaiting = true);
    var result = await _authService.signInAnonymously();
    await _processLoginResult(result);
    setState(() => isWaiting = false);
  }

  onSignUpTap() {
    Navigator.pushNamed(context, 'sign up');
  }

  _processLoginResult(dynamic result) async {
    // result is either a bool stating whether signup was successful,
    // or it is an error message emanating from the signup process.
    if (result is bool) {
      if (result) {
        _onSuccessfulSignIn();
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
  }

  _onSuccessfulSignIn() async {
    await Utils().completeAppInitialisation(
      _authService.user,
      sessionData,
      records,
    );
    appState.onLoginPath = false;
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
    return ListView(
      padding: EdgeInsets.all(20),
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        SizedBox(height: 40),
        Text(
          'eat sleep travel',
          textAlign: TextAlign.center,
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
        SizedBox(height: 40),
        SizedBox(
          width: 180,
          child: FloatingActionButton.extended(
            label: Text(
              'Sign in',
              style: TextStyle(color: appState.cols.background1),
            ),
            icon: Icon(Icons.person, color: appState.cols.background1),
            backgroundColor: appState.cols.content,
            heroTag: 'Sign in',
            onPressed: onLoginTap,
          ),
        ),
        SizedBox(height: 80),
        Text(
          "First time here?",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: appState.cols.content.withOpacity(0.9),
            letterSpacing: 1.6,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 15),
        FlatButton(
          child: Text(
            'Sign up',
            style: TextStyle(
              color: appState.cols.action,
              letterSpacing: 1.6,
              fontSize: 16,
            ),
          ),
          onPressed: onSignUpTap,
        ),
        SizedBox(height: 12),
        FlatButton(
          child: Text(
            'Skip for now',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: appState.cols.content.withOpacity(0.6),
              letterSpacing: 1.6,
              fontSize: 14,
            ),
          ),
          onPressed: onSkipTap,
        ),
        SizedBox(height: 30),
        isWaiting ? LoadingSpinner() : Container(),
      ],
    );
  }
}
