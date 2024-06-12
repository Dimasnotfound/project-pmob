import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Model for Sampah
class Sampah {
  final String name;
  final String imageUrl;

  Sampah(this.name, this.imageUrl);
}

// ViewModel for Sampah
class SampahViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Sampah> _sampahList = [];
  String? _selectedSampah;
  String? _selectedImageUrl;

  List<Sampah> get sampahList => _sampahList;
  String? get selectedSampah => _selectedSampah;
  String? get selectedImageUrl => _selectedImageUrl;

  Future<void> fetchSampah() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('daur_ulang').get();
    _sampahList =
        result.docs.map((doc) => Sampah(doc['name'], doc['imageUrl'])).toList();
    if (_sampahList.isNotEmpty) {
      _selectedSampah = _sampahList[0].name;
      _selectedImageUrl = _sampahList[0].imageUrl;
    }
    notifyListeners();
  }

  void selectSampah(String sampah, String imageUrl) {
    _selectedSampah = sampah;
    _selectedImageUrl = imageUrl;
    notifyListeners();
  }

  Future<void> insertTukarPoin(
      String userId, String jenisSampah, double kilo) async {
    await FirebaseFirestore.instance.collection('tukar_poin').add({
      'userId': userId,
      'jenisSampah': jenisSampah,
      'kilo': kilo,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<int> fetchUserPoints() async {
    User? user = _auth.currentUser;
    // ignore: unnecessary_null_comparison
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
}
