import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> tambahDataUser({
    required String nama,
    required String email,
    required String nomorPonsel,
    required String password,
    required String alamat,
  }) async {
    try {
      // Hash password menggunakan SHA-256
      var bytes = utf8.encode(password);
      var digest = sha256.convert(bytes);
      String hashedPassword = digest.toString();

      // Simpan data ke Firestore dengan password yang sudah di-hash dan role default 'users'
      await _firestore.collection('users').add({
        'nama': nama,
        'email': email,
        'nomorPonsel': nomorPonsel,
        'password': hashedPassword,
        'alamat': alamat,
        'role': 'users', // Menambahkan field role dengan default 'users'
      });
    } catch (e) {
      print('Error tambah data user: $e');
    }
  }
}
