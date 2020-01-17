import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final _fireAuth = FirebaseAuth.instance;
  FirebaseUser user;

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var result = await _fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result != null) {
        user = result.user;
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return err.message;
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var result = await _fireAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result != null) {
        user = result.user;
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return err.message;
    }
  }

  Future signInAnonymously() async {
    try {
      var result = await _fireAuth.signInAnonymously();

      if (result != null) {
        user = result.user;
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return err.message;
    }
  }
}
