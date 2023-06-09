// app colors
import 'package:flutter/material.dart';

const appColors = _AppColors(
  yellow: Color(0xFFF3E42B),
  purple: Color(0xFF7A74F6),
  red: Color(0xFFB22A29),
  green: Color.fromARGB(255, 10, 170, 47),
  lightRed: Color(0xFFFEECEA),
  grey: Color(0xFFF2F2F2),
  darkGrey: Color(0xFFA9A8A8),
  background: Color(0xFFFEFEFF),
  disabled: Color(0xFFF2F2F2),
  black: Color(0xFF0C0C0D),
);

// app colors model
class _AppColors {
  const _AppColors({
    required this.yellow,
    required this.purple,
    required this.red,
    required this.green,
    required this.lightRed,
    required this.grey,
    required this.darkGrey,
    required this.background,
    required this.disabled,
    required this.black,
  });

  final Color yellow;
  final Color purple;
  final Color red;
  final Color green;
  final Color lightRed;
  final Color grey;
  final Color darkGrey;
  final Color background;
  final Color disabled;
  final Color black;
}
