import 'package:flutter/material.dart';
import 'package:our_pass/core/core.dart';
import 'package:our_pass/features/shared/views/widgets/widgets.dart';

class VerifyAccountPage extends StatelessWidget {
  const VerifyAccountPage({
    super.key,
    required this.emailStream,
    required this.ctaEnabledStream,
    required this.onOtpChanged,
    required this.onVerify,
  });

  final Stream<String> emailStream;
  final Stream<bool> ctaEnabledStream;
  final Function(String) onOtpChanged;
  final VoidCallback onVerify;

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
              'Verify Email',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const YBox(10),
            StreamBuilder<String>(
                stream: emailStream,
                builder: (context, snapshot) {
                  final email = snapshot.data ?? '';

                  if (email.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  final maskEndIndex = email.indexOf('@');

                  return Text(
                    'Enter the OTP sent to ${email.replaceRange(1, maskEndIndex, '*' * (maskEndIndex - 2))}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }),
            const YBox(40),
            CustomPinCodeField(
              length: 6,
              onChanged: (otp) {
                onOtpChanged(otp);
              },
            ),
            const YBox(30),
            CustomTextButton(
              title: 'Verify',
              enabledStream: ctaEnabledStream,
              buttonColor: appColors.yellow,
              textColor: appColors.black,
              defaultEnabledValue: false,
              onPressed: onVerify,
            ),
          ],
        ),
      ),
    );
  }
}
