// app colors
import 'package:flutter/material.dart';

const appColors = _DHColors(
  yellow: Color(0xFFF3E42B),
  purple: Color(0xFF7A74F6),
  red: Color(0xFFB22A29),
  lightRed: Color(0xFFFEECEA),
  grey: Color(0xFFF2F2F2),
  darkGrey: Color(0xFFA9A8A8),
  background: Color(0xFFFEFEFF),
  disabled: Color(0xFFF2F2F2),
  black: Color(0xFF0C0C0D),
);

// app colors model
class _DHColors {
  const _DHColors({
    required this.yellow,
    required this.purple,
    required this.red,
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
  final Color lightRed;
  final Color grey;
  final Color darkGrey;
  final Color background;
  final Color disabled;
  final Color black;
}
