import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_pass/core/constants/constants.dart';
import 'package:our_pass/core/utils/utils.dart';
import 'package:our_pass/features/auth/cubits/signup_cubit/signup_cubit.dart';
import 'package:our_pass/features/auth/views/pages/pages.dart';
import 'package:our_pass/features/shared/views/pages/pages.dart';
import 'package:our_pass/features/shared/views/widgets/widgets.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpCubit = context.read<SignupCubit>();

    return Scaffold(
      appBar: const CustomAppBar(
        hasLeading: false,
      ),
      body: BlocListener<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupError) {
            /// pop the loading dialog
            Navigator.of(context).pop();

            /// show an error if one occured during signin
            context.showError(state.error);
          } else if (state is SignupLoading) {
            /// show a loading dialog while signing in the user
            context.showLoader(context);
          } else if (state is AccountCreated) {
            /// pop the loading dialog
            Navigator.of(context).pop();

            /// navigate the user to the verify account page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VerifyAccountPage(
                  emailStream: signUpCubit.emailStream,
                  ctaEnabledStream: signUpCubit.validateVerification,
                  onOtpChanged: (otp) {
                    signUpCubit.updateOtp(otp);
                  },
                  onVerify: () {
                    signUpCubit.verifyUser();
                  },
                ),
              ),
            );
          } else if (state is AccountVerified) {
            /// pop the loading dialog
            Navigator.of(context).pop();

            /// navigate the user to the dasboard page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const DashboardPage(),
              ),
            );
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
                stream: signUpCubit.firstNameStream,
                labelText: 'First name',
                hintText: 'Ex: John',
                keyboardType: TextInputType.text,
                onChanged: (val) {
                  signUpCubit.updateFirstName(val.trim());
                },
              ),
              const YBox(20),
              CustomTextField(
                stream: signUpCubit.lastNameStream,
                labelText: 'Last name',
                hintText: 'Ex: Wayne',
                keyboardType: TextInputType.text,
                onChanged: (val) {
                  signUpCubit.updateLastName(val.trim());
                },
              ),
              const YBox(20),
              CustomTextField(
                stream: signUpCubit.emailStream,
                labelText: 'Email address',
                hintText: 'hello@example.com',
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) {
                  signUpCubit.updateEmail(val.trim());
                },
              ),
              const YBox(20),
              CustomTextField(
                stream: signUpCubit.passwordStream,
                labelText: 'Password',
                hintText: 'Your password',
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                onChanged: (val) {
                  signUpCubit.updatePassword(val.trim());
                },
              ),
              const YBox(30),
              CustomTextButton(
                title: 'Get started',
                enabledStream: signUpCubit.validateSignup,
                buttonColor: appColors.yellow,
                textColor: appColors.black,
                defaultEnabledValue: false,
                onPressed: () {
                  signUpCubit.signup();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
