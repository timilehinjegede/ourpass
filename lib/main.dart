import 'package:flutter/material.dart';
import 'package:our_pass/app.dart';
import 'package:our_pass/core/config.dart';

void main() async {
  await AppConfig.initialize();

  runApp(
    const OurPassApp(),
  );
}
