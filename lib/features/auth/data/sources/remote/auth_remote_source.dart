import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:our_pass/core/utils/exceptions.dart';

abstract class IAuthRemoteSource {
  /// signs up a user with their email and password
  Future signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// log in a user with their email and password
  Future signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// verifys the users email
  Future verifyEmail(String email);
}

class AuthRemoteSource implements IAuthRemoteSource {
  AuthRemoteSource() : firebaseAuth = FirebaseAuth.instance;

  final FirebaseAuth firebaseAuth;

  @override
  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      log('user credentials is ${userCredential.toString()}');
    } on Exception catch (e) {
      throw CustomException.getException(e);
    }
  }

  @override
  Future signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      log('user credentials is ${userCredential.toString()}');
    } on Exception catch (e) {
      throw CustomException.getException(e);
    }
  }

  @override
  Future verifyEmail(String email) async {}
}
