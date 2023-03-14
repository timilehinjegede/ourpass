import 'package:flutter/material.dart';
import 'package:our_pass/core/constants/constants.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.title,
    this.titleWidget,
    this.onPressed,
    this.buttonColor,
    this.textColor,
    this.size,
    this.radius,
    this.isLoading = false,
    this.disabled = false,
  }) : super(key: key);

  final String title;
  final Widget? titleWidget;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final Size? size;
  final double? radius;
  final bool isLoading;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? appColors.background,
        backgroundColor:
            disabled ? appColors.grey : (buttonColor ?? appColors.purple),
        minimumSize: size ?? const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            radius ?? 0,
          ),
        ),
      ),
      child: (isLoading
              ? SizedBox(
                  height: 30,
                  width: 30,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      color: appColors.background,
                    ),
                  ),
                )
              : titleWidget) ??
          Text(
            title,
            style: TextStyle(
              color: disabled ? appColors.black.withOpacity(.7) : textColor,
            ),
          ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.size,
    this.isLoading = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final Size? size;
  final bool isLoading;

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
      child: isLoading
          ? SizedBox(
              height: 25,
              width: 25,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: appColors.background,
                ),
              ),
            )
          : Text(
              title,
              style: TextStyle(
                color: appColors.purple,
              ),
            ),
    );
  }
}
