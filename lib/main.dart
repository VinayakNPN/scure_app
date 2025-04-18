import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:scure_app/theme.dart';
import 'package:scure_app/screens/auth/login_screen.dart';
import 'package:scure_app/config_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize SharedPreferences
  await SharedPreferences.getInstance();
  
  // Initialize Gemini
  final configFile = await rootBundle.loadString('assets/config.json');
  final configData = json.decode(configFile);
  final config = ConfigModel.fromJson(configData);
  Gemini.init(apiKey: config.geminiAPIkey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      title: 'Scure_App',
      home: const LoginScreen(),
    );
  }
}
