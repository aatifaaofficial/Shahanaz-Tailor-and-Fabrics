import 'package:flutter/material.dart';

class AuthService {
  static Future<bool> signIn(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (email.trim().isEmpty || password.trim().isEmpty) {
      throw FlutterError('Email and password are required.');
    }
    return true;
  }

  static Future<bool> register(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (name.trim().isEmpty || email.trim().isEmpty || phone.trim().isEmpty) {
      throw FlutterError('Please complete all required fields.');
    }
    return true;
  }

  static Future<bool> resetPassword(String email) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return email.trim().isNotEmpty;
  }
}
