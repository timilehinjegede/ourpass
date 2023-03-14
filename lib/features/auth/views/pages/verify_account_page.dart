import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_pass/core/constants/constants.dart';
import 'package:our_pass/core/utils/utils.dart';
import 'package:our_pass/features/auth/cubits/signup_cubit/signup_cubit.dart';
import 'package:our_pass/features/shared/views/pages/dashboard_page.dart';
import 'package:our_pass/features/shared/views/widgets/widgets.dart';

class VerifyAccountPage extends StatelessWidget {
  const VerifyAccountPage({super.key});

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
                'Verify Email',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const YBox(10),
              StreamBuilder<String>(
                  stream: signUpCubit.emailStream,
                  builder: (context, snapshot) {
                    final email = snapshot.data ?? '';

                    if (email.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    final maskEndIndex = email.indexOf('@');

                    return Text(
                      'Enter the OTP sent to ${email.replaceRange(2, maskEndIndex, '*' * (maskEndIndex - 2))}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }),
              const YBox(40),
              CustomPinCodeField(
                length: 6,
                onChanged: (otp) {
                  signUpCubit.updateOtp(otp);
                },
              ),
              const YBox(30),
              CustomTextButton(
                title: 'Verify',
                enabledStream: signUpCubit.validateVerification,
                buttonColor: appColors.yellow,
                textColor: appColors.black,
                defaultEnabledValue: false,
                onPressed: () {
                  signUpCubit.verifyUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
