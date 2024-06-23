import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insurrance/views/auth/main_auth_scree.dart';

class AuthResult {
  final User? user;
  final String? errorMessage;

  AuthResult({required this.user, this.errorMessage});
}

class FirebaseAuthResult {
  final User? user;
  final String? errorMessage;

  FirebaseAuthResult({this.user, this.errorMessage});
}

class UserAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String errorMessage = "Authentication failed";

  Future<AuthResult> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult(user: userCredential.user, errorMessage: null);
    } catch (e) {
      if (e is FirebaseAuthException) {
        errorMessage = getErrorMessage(e.code);
      }
      return AuthResult(user: null, errorMessage: errorMessage);
    }
  }

  Future<FirebaseAuthResult> signUpWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return FirebaseAuthResult(user: userCredential.user);
    } on FirebaseAuthException catch (e) {
      return FirebaseAuthResult(errorMessage: e.message);
    } catch (e) {
      return FirebaseAuthResult(errorMessage: e.toString());
    }
  }

  Future<void> signOut(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                try {
                  await _auth.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainAuth()),
                  );
                } catch (e) {
                  _showErrorSnackbar(context, 'Sign out failed: $e');
                }
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

String getErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'invalid-login-credentials':
      return 'Invalid password or Email';
    case 'wrong-password':
      return 'Invalid password. Please check your password and try again.';
    case 'invalid-email':
      return 'Invalid email address. Please provide a valid email.';
    case 'user-disabled':
      return 'Your account has been disabled. Please contact support.';
    case 'user-not-found':
      return 'User not found. Please check your email or sign up for an account.';
    case 'email-already-in-use':
      return 'An account with this email already exists. Please use a different email address.';
    case 'operation-not-allowed':
      return 'Email/password accounts are not enabled. Please contact support.';
    case 'weak-password':
      return 'The password is not strong enough. Please choose a stronger password.';
    default:
      return 'An unknown error occurred. Please try again later.';
  }
}
