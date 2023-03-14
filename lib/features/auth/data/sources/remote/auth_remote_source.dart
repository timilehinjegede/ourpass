import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:our_pass/core/utils/exceptions.dart';
import 'package:our_pass/features/auth/data/models/models.dart';

abstract class IAuthRemoteSource {
  /// signs up a user with their email and password
  /// returns the `uid` of the user who just signed up
  Future<String?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// log in a user with their email and password
  /// returns the `uid` of the signed in user
  Future<String?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// adds the user to the database if they don't exists,
  /// updates the users record in the database if they exists
  Future saveUser(UserModel user);

  /// check if a user is currently verified
  Future<bool> isVerified(String? userId);
}

class AuthRemoteSource implements IAuthRemoteSource {
  AuthRemoteSource()
      : firebaseAuth = FirebaseAuth.instance,
        firestoreDB = FirebaseFirestore.instance;

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestoreDB;

  @override
  Future<String?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      log('user credentials is ${userCredential.toString()}');

      return userCredential.user?.uid;
    } on Exception catch (e) {
      throw CustomException.getException(e);
    }
  }

  @override
  Future<String?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      log('user credentials is ${userCredential.toString()}');
      return userCredential.user?.uid;
    } on Exception catch (e) {
      throw CustomException.getException(e);
    }
  }

  @override
  Future saveUser(UserModel user) async {
    final collectionRef = firestoreDB.collection('users');

    if (user.id != null) {
      final document = await collectionRef.doc(user.id).get();

      if (document.exists) {
        await collectionRef.doc(user.id).update(
              user.toJson(),
            );
      } else {
        await collectionRef.doc(user.id).set(
              user.toJson(),
            );
      }
    } else {
      final email = user.email;
      final snapshot =
          await collectionRef.where('email', isEqualTo: email).get();

      if (snapshot.docs.isNotEmpty) {
        final userId = snapshot.docs.first.data()['id'];
        await collectionRef.doc(userId).update(
              user.toJson(),
            );
      }
    }
  }

  @override
  Future<bool> isVerified(String? userId) async {
    final collectionRef = firestoreDB.collection('users');

    if (userId != null) {
      final document = await collectionRef.doc(userId).get();

      if (document.exists) {
        final user = UserModel.fromJson(
          document.data() ?? {},
        );

        return user.isVerified ?? false;
      }
    }

    return false;
  }
}
