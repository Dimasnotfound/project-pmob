import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser({
    required String nama,
    required String email,
    required String nomorPonsel,
    required String password,
    required String alamat,
  }) async {
    try {
      // Membuat user baru dengan email dan password menggunakan Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Mendapatkan user ID dari user yang baru saja dibuat
      String uid = userCredential.user!.uid;

      // Hash password menggunakan SHA-256
      var bytes = utf8.encode(password);
      var digest = sha256.convert(bytes);
      String hashedPassword = digest.toString();

      // Simpan data tambahan ke Firestore dengan user ID sebagai document ID
      await _firestore.collection('users').doc(uid).set({
        'nama': nama,
        'email': email,
        'nomorPonsel': '0$nomorPonsel',
        'password': hashedPassword,
        'alamat': alamat,
        'points': 0,
        'role': 'users', // Menambahkan field role dengan default 'users'
      });
    } catch (e) {
      print('Error register user: $e');
      throw e; // Mengangkat kembali error untuk ditangani di tempat lain
    }
  }
}
