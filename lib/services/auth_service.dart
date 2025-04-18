import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _storageKey = 'users';
  
  Future<bool> signup(UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final users = prefs.getStringList(_storageKey) ?? [];
      
      if (users.any((u) => UserModel.fromJson(jsonDecode(u)).email == user.email)) {
        return false;
      }
      
      users.add(jsonEncode(user.toJson()));
      await prefs.setStringList(_storageKey, users);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel?> login(String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final users = prefs.getStringList(_storageKey) ?? [];
      
      final userJson = users.firstWhere(
        (u) {
          final UserModel user = UserModel.fromJson(jsonDecode(u));
          return user.email == email && user.password == password;
        },
        orElse: () => '',
      );
      
      if (userJson.isEmpty) return null;
      return UserModel.fromJson(jsonDecode(userJson));
    } catch (e) {
      return null;
    }
  }
}