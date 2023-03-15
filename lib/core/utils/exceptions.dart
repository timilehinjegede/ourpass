import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

class CustomException implements Exception {
  final String message;

  const CustomException({this.message = 'Something went wrong!'});

  static CustomException getException(Exception e) {
    if (e is FirebaseAuthException) {
      final code = e.code;
      final message = FirebaseExceptionHandler.getMessage(code);

      return FirebaseException(message);
    }

    if (e is SocketException) {
      return InternetConnectionException(
        'Please check your internet connection.',
      );
    }

    return const CustomException(message: 'Something went wrong, try again!');
  }

  @override
  String toString() {
    return 'CustomException {message: $message}';
  }
}

class FirebaseException implements CustomException {
  FirebaseException(this.error);

  final String error;

  @override
  String toString() => message;

  @override
  String get message => error;
}

class InternetConnectionException implements CustomException {
  InternetConnectionException(this.error);

  final String error;

  @override
  String toString() => message;

  @override
  String get message => error;
}

class FirebaseExceptionHandler {
  static String getMessage(String code) {
    switch (code) {
      case 'wrong-password':
        return 'The supplied password is incorrect';

      case 'weak-password':
        return 'Weak password, kindly make it stronger.';

      case 'user-not-found':
        return 'No user found with the supplied credentials';

      case 'email-already-in-use':
        return 'The email is already in use';

      case 'invalid-email':
        return 'The supplied email is invalid';

      case 'user-disabled':
        return 'User disabled, contact support';

      case 'invalid-credential':
        return 'Supplied credential is invalid';

      case 'account-exists-with-different-credential':
        return 'An account exists with a different credentials';

      case 'sign-in-cancelled':
        return 'Sign in cancelled';

      case 'create-an-account':
        return 'You haven\'t created an account yet, please proceed to signup';

      case 'proceed-to-sign-in':
        return 'You have already created an account with this email, please sign in';

      case 'network-request-failed':
        return 'Please check your internet connection and try again.';
    }

    return 'Something went wrong';
  }
}
