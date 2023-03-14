import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_pass/core/constants/constants.dart';
import 'package:our_pass/core/utils/utils.dart';
import 'package:our_pass/features/auth/cubits/signin_cubit/signin_cubit.dart';
import 'package:our_pass/features/auth/views/pages/sign_up_page.dart';
import 'package:our_pass/features/shared/views/pages/dashboard_page.dart';
import 'package:our_pass/features/shared/views/widgets/widgets.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signInCubit = context.read<SigninCubit>();

    return Scaffold(
      appBar: const CustomAppBar(
        hasLeading: false,
      ),
      body: BlocListener<SigninCubit, SigninState>(
        listener: (_, state) {
          if (state is SigninError) {
            /// pop the loading dialog
            Navigator.of(context).pop();

            /// show an error if one occured during signin
            context.showError(state.error);
          } else if (state is SigninSuccess) {
            /// pop the loading dialog
            Navigator.of(context).pop();

            /// navigate the user to the dasboard page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const DashboardPage(),
              ),
            );
          } else if (state is SigninLoading) {
            /// show a loading dialog while signing in the user
            context.showLoader(context);
          }
        },
        child: SingleChildScrollView(
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
                stream: signInCubit.emailStream,
                labelText: 'Email address',
                hintText: 'hello@example.com',
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) {
                  signInCubit.updateEmail(val.trim());
                },
              ),
              const YBox(20),
              CustomTextField(
                stream: signInCubit.passwordStream,
                labelText: 'Password',
                hintText: 'Your password',
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                onChanged: (val) {
                  signInCubit.updatePassword(val.trim());
                },
              ),
              const YBox(30),
              CustomTextButton(
                enabledStream: signInCubit.validateForm,
                title: 'Sign in',
                defaultEnabledValue: false,
                onPressed: () {
                  signInCubit.signin();
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
      ),
    );
  }
}
