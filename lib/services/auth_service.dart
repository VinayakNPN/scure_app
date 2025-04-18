import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _storageKey = 'users';

  // Method to get all stored users
  Future<List<UserModel>> _getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(_storageKey) ?? [];
    return users.map((u) => UserModel.fromJson(jsonDecode(u))).toList();
  }

  // Method to save all users
  Future<void> _saveUsers(List<UserModel> users) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = users.map((u) => jsonEncode(u.toJson())).toList();
    await prefs.setStringList(_storageKey, usersJson);
  }

  // Signup method
  Future<bool> signup(UserModel user) async {
    try {
      final users = await _getUsers();
      
      // Check if email already exists
      if (users.any((u) => u.email.toLowerCase() == user.email.toLowerCase())) {
        return false;
      }
      
      // Add new user
      users.add(user);
      await _saveUsers(users);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Login method
  Future<UserModel?> login(String email, String password) async {
    try {
      final users = await _getUsers();
      
      // Find user with matching email and password
      final user = users.firstWhere(
        (u) => u.email.toLowerCase() == email.toLowerCase() && 
               u.password == password,
        orElse: () => UserModel(name: '', email: '', password: ''),
      );
      
      // Return null if no matching user found
      if (user.email.isEmpty) return null;
      return user;
    } catch (e) {
      return null;
    }
  }

  // Method to check if email exists
  Future<bool> emailExists(String email) async {
    final users = await _getUsers();
    return users.any((u) => u.email.toLowerCase() == email.toLowerCase());
  }

  // Method to get current user count (useful for debugging)
  Future<int> getUserCount() async {
    final users = await _getUsers();
    return users.length;
  }
}