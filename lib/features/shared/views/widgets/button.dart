import 'package:flutter/material.dart';
import 'package:our_pass/core/constants/constants.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.buttonColor,
    this.textColor,
    this.size,
    this.radius,
    this.enabledStream = const Stream.empty(),
    this.defaultEnabledValue,
  }) : super(key: key);

  final Stream<bool> enabledStream;
  final String title;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final Size? size;
  final double? radius;
  final bool? defaultEnabledValue;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: enabledStream,
      builder: (context, snapshot) {
        final isEnabled = snapshot.data ?? (defaultEnabledValue ?? true);

        return TextButton(
          onPressed: isEnabled ? onPressed : null,
          style: TextButton.styleFrom(
            foregroundColor: textColor ?? appColors.background,
            backgroundColor:
                !isEnabled ? appColors.grey : (buttonColor ?? appColors.purple),
            minimumSize: size ?? const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                radius ?? 0,
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: !isEnabled ? appColors.black.withOpacity(.7) : textColor,
            ),
          ),
        );
      },
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.size,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: appColors.purple,
        backgroundColor: appColors.background,
        side: BorderSide(
          color: appColors.purple,
          width: 2,
        ),
        minimumSize: size ?? const Size(65, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: appColors.purple,
        ),
      ),
    );
  }
}
