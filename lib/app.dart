import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_pass/core/constants/constants.dart';
import 'package:our_pass/features/auth/cubits/signin_cubit/signin_cubit.dart';
import 'package:our_pass/features/auth/cubits/signup_cubit/signup_cubit.dart';
import 'package:our_pass/features/auth/views/pages/sign_up_page.dart';
import 'package:our_pass/features/shared/views/pages/pages.dart';

class OurPassApp extends StatelessWidget {
  const OurPassApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SigninCubit()),
        BlocProvider(create: (_) => SignupCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        home: currentUser != null ? const DashboardPage() : const SignUpPage(),
      ),
    );
  }
}

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent${bloc.runtimeType} $event');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('onTransition${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}
