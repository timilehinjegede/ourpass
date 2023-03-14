import 'package:flutter/material.dart';
import 'package:our_pass/core/constants/constants.dart';
import 'package:our_pass/features/shared/views/pages/dashboard_page.dart';
import 'package:our_pass/features/shared/views/widgets/widgets.dart';

class VerifyOtpPage extends StatelessWidget {
  const VerifyOtpPage({super.key});

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
            const Text(
              'Enter the OTP sent to jeg*************n@gmail.com',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            const YBox(40),
            const CustomPinCodeField(
              length: 6,
            ),
            const YBox(30),
            CustomTextButton(
              title: 'Verify',
              buttonColor: appColors.yellow,
              textColor: appColors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DashboardPage(),
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
