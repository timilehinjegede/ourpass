import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:our_pass/app.dart';

class AppConfig {

  /// setups necessary dependencies needed for the app
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// initialize firebase
    await Firebase.initializeApp();
    /// signs out the user from Firebase
    /// this is needed because the user has to login/signup at every app restart
    await FirebaseAuth.instance.signOut();

    /// setup bloc observers
    Bloc.observer = AppBlocObserver();
  }
}
