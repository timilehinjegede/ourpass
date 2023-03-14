import 'package:flutter/material.dart';
import 'package:our_pass/core/constants/constants.dart';
import 'package:our_pass/features/auth/views/pages/sign_up_page.dart';

class OurPassApp extends StatelessWidget {
  const OurPassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const SignUpPage(),
    );
  }
}
