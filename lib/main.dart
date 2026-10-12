import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TapBackApp());
}

class TapBackApp extends StatelessWidget {
  const TapBackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TapBack',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const WelcomeScreen(),
    );
  }
}
