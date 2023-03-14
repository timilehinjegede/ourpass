import 'package:flutter/material.dart';

// styles
final sonaStyles = _AppStyles();

class _AppStyles {
  // height / font size

  final light10 = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w300,
    height: 1.5,
  );

  final light13 = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w300,
    height: 1.15,
  );

  final light15 = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    height: 1.3,
  );

  final regular13 = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  final regular15 = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.67,
  );

  final bold9 = const TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.w700,
    height: 2.2,
  );

  final medium11 = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1,
  );

  final medium13 = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.15,
  );

  final medium15 = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.67,
  );

  final medium17 = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    height: 1.47,
  );

  final medium14 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.78,
  );

  final medium20 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  final medium25 = const TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  final medium35 = const TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.w500,
    height: 1,
  );

  final bold16 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.4,
  );

  final bold26 = const TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: .9,
  );

  final gradientStyle = TextStyle(
    foreground: Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF49D9FD),
          Color(0xFF7205F8),
          Color(0xFFED36E1),
        ],
      ).createShader(
        const Rect.fromLTWH(0, 0, 300, 0),
      ),
  );
}
