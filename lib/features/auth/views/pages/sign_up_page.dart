import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:our_pass/core/constants/constants.dart';
import 'package:our_pass/features/auth/views/pages/pages.dart';
import 'package:our_pass/features/shared/views/widgets/widgets.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
              'Get started',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const YBox(20),
            Text.rich(
              TextSpan(
                text: 'Already have an account? ',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: 'Sign in',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignInPage(),
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
            ),
            const YBox(40),
            CustomTextField(
              labelText: 'First name',
              hintText: 'Ex: John',
              keyboardType: TextInputType.text,
              onChanged: (val) {},
            ),
            const YBox(20),
            CustomTextField(
              labelText: 'Last name',
              hintText: 'Ex: Wayne',
              keyboardType: TextInputType.text,
              onChanged: (val) {},
            ),
            const YBox(20),
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
              title: 'Get started',
              buttonColor: appColors.yellow,
              textColor: appColors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const VerifyOtpPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
