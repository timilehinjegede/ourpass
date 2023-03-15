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

      return userCredential.user?.uid;
    } on Exception catch (e) {
      throw CustomException.getException(e);
    }
  }

  @override
  Future saveUser(UserModel user) async {
    /// get a reference to the collection reference
    final collectionRef = firestoreDB.collection('users');

    /// if the id of the user passed is not null, then find the user by their id
    if (user.id != null) {
      final document = await collectionRef.doc(user.id).get();

      if (document.exists) {
        /// if the user record exists -> update their record with the new values/fields
        await collectionRef.doc(user.id).update(
              user.toJson(),
            );
      } else {
        /// if the user record does not exists -> add their records to the DB
        await collectionRef.doc(user.id).set(
              user.toJson(),
            );
      }
    } else {
      /// if the id of the user passed is null, then find the user by their email
      final email = user.email;
      final snapshot =
          await collectionRef.where('email', isEqualTo: email).get();

      if (snapshot.docs.isNotEmpty) {
        /// update the users record after a successful find by email
        final userId = snapshot.docs.first.data()['id'];
        await collectionRef.doc(userId).update(
              user.toJson(),
            );
      }
    }
  }

  @override
  Future<bool> isVerified(String? userId) async {
    /// get a reference to the collection reference
    final collectionRef = firestoreDB.collection('users');

    if (userId != null) {
      final document = await collectionRef.doc(userId).get();

      /// finds the user by their ID
      if (document.exists) {
        final user = UserModel.fromJson(
          document.data() ?? {},
        );

        /// checks and returns if a user is currently verified or not
        return user.isVerified ?? false;
      }
    }

    return false;
  }
}
