import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:our_pass/core/constants/constants.dart';
import 'package:our_pass/features/auth/views/pages/sign_up_page.dart';
import 'package:our_pass/features/shared/views/pages/dashboard_page.dart';
import 'package:our_pass/features/shared/views/widgets/widgets.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        hasLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: hPadding,
          vertical: vPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const YBox(10),
            const Text(
              'Sign in to your account.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            const YBox(40),
            CustomTextField(
              labelText: 'Email address',
              hintText: 'hello@example.com',
              keyboardType: TextInputType.emailAddress,
              onChanged: (val) {},
            ),
            const YBox(20),
            CustomTextField(
              labelText: 'Password',
              hintText: 'Your password',
              keyboardType: TextInputType.visiblePassword,
              isPassword: true,
              onChanged: (val) {},
            ),
            const YBox(30),
            CustomTextButton(
              title: 'Sign in',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DashboardPage(),
                  ),
                );
              },
              buttonColor: appColors.yellow,
              textColor: appColors.black,
            ),
            const YBox(30),
            Align(
              child: Text.rich(
                TextSpan(
                  text: 'Don\'t have an account? ',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: 'Sign up',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignUpPage(),
                            ),
                          );
                        },
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: appColors.purple,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
