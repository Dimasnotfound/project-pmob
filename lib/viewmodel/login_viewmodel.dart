import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoggedIn = false;
  String _userRole = '';

  bool get isLoggedIn => _isLoggedIn;
  String get userRole => _userRole;

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
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        var userDoc = await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          _isLoggedIn = true;
          _userRole = userDoc['role'];
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLoggedIn', true);
          notifyListeners();
        } else {
          throw Exception('Data pengguna tidak ditemukan.');
        }
      } else {
        throw Exception('Pengguna tidak ditemukan.');
      }
    } catch (e) {
      throw Exception('Login gagal: $e');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _isLoggedIn = false;
    _userRole = '';
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    prefs.remove('userRole');
    notifyListeners();
  }
}
