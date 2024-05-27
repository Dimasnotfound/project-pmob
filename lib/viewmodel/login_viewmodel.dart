import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  LoginViewModel() {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      // Hash password menggunakan SHA-256
      var bytes = utf8.encode(password);
      var digest = sha256.convert(bytes);
      String hashedPassword = digest.toString();

      // Cari pengguna dengan email dan password yang di-hash
      var userQuery = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: hashedPassword)
          .get();

      if (userQuery.docs.isNotEmpty) {
        // Autentikasi berhasil
        _isLoggedIn = true;
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        notifyListeners();
      } else {
        // Autentikasi gagal
        throw Exception('Email atau password salah');
      }
    } catch (e) {
      throw Exception('Login gagal: $e');
    }
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    notifyListeners();
  }
}
