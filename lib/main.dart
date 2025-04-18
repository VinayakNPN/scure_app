import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:scure_app/theme.dart';
import 'package:scure_app/screens/auth/login_screen.dart';
import 'package:scure_app/config_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    final configFile = await rootBundle.loadString('assets/config.json');
    final configData = json.decode(configFile);
    final config = ConfigModel.fromJson(configData);
    
    // Initialize Gemini with improved settings
    Gemini.init(
      apiKey: config.geminiAPIkey,
      enableDebugging: true,
      generationConfig: GenerationConfig(maxOutputTokens: 2048),
    );
    
    runApp(const MyApp());
  } catch (e) {
    print('Initialization error: $e');
    rethrow;
  }
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
