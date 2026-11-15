import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'theme.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mohamed Reda — Senior Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      // Let mouse users drag horizontal screenshot galleries.
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.stylus,
        },
      ),
      home: const HomePage(),
    );
  }
}
