import 'package:flutter/material.dart';
import 'package:our_pass/core/constants/constants.dart';
import 'package:our_pass/features/shared/views/widgets/widgets.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Text(
                'Welcome {{ USERNAME }}',
                style: TextStyle(
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
