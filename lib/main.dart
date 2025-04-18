import 'package:flutter/material.dart';
import 'package:scure_app/theme.dart';
import 'package:scure_app/screens/auth/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      title: 'Scure_App',
      home: const LoginScreen(),
    );
  }
}
