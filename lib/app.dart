import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/promo_theme.dart';

class SotongAutomationApp extends StatelessWidget {
  const SotongAutomationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '소통웨어 산업자동화',
      debugShowCheckedModeBanner: false,
      theme: PromoTheme.light,
      home: const HomeScreen(),
    );
  }
}
