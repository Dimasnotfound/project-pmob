import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoggedIn = false;
  String _userRole = '';

  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();
  final TextEditingController pointsController = TextEditingController();

  bool get isLoggedIn => _isLoggedIn;
  String get userRole => _userRole;

  Map<String, dynamic> userData = {};

  LoginViewModel() {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (_isLoggedIn) {
      await fetchUserData();
    }
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
          userData = userDoc.data()!;
          namaController.text = userData['nama'] ?? '';
          alamatController.text = userData['alamat'] ?? '';
          noHpController.text = userData['nomorPonsel'] ?? '';
          pointsController.text = userData['points']?.toString() ?? '';
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

  Future<void> fetchUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      var userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        userData = userDoc.data()!;
        namaController.text = userData['nama'] ?? '';
        alamatController.text = userData['alamat'] ?? '';
        noHpController.text = userData['nomorPonsel'] ?? '';
        pointsController.text = userData['points']?.toString() ?? '';
        notifyListeners();
      }
    }
  }

  Future<int> fetchUserPoints() async {
    User? user = _auth.currentUser;
    if (user != null) {
      var userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final userPoints = userData['points'] ?? 0;
        return userPoints;
      }
    }
    return 0; // Return default value if user document doesn't exist or user is null
  }

  Future<void> updateUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'nama': namaController.text,
        'alamat': alamatController.text,
        'nomorPonsel': noHpController.text,
        'points': int.tryParse(pointsController.text) ?? 0,
      });
      await fetchUserData();
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
