import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:our_pass/core/constants/constants.dart';
import 'package:our_pass/features/auth/auth.dart';
import 'package:our_pass/features/shared/views/widgets/widgets.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: appColors.grey,
      appBar: const CustomHomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: hPadding,
          vertical: vPadding,
        ),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icFlower,
                height: 200,
              ),
              const YBox(20),
              Text(
                'Welcome ${currentUser?.email}',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const YBox(20),
              Text(
                'Click here to logout\nof your account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: appColors.darkGrey,
                  letterSpacing: .7,
                ),
                textAlign: TextAlign.center,
              ),
              Image.asset(
                icArrow,
                height: 200,
              ),
              CustomTextButton(
                title: 'Logout',
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const SignInPage()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
