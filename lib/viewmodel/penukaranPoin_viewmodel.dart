import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class PenukaranPoinAdminViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, List<Map<String, dynamic>>> _groupedTukarPoinData = {};
  Map<String, List<Map<String, dynamic>>> get groupedTukarPoinData =>
      _groupedTukarPoinData;

  Future<void> fetchTukarPoinData() async {
    final QuerySnapshot tukarPoinSnapshot =
        await _firestore.collection('tukar_poin').get();

    Map<String, List<Map<String, dynamic>>> groupedData = {};

    for (var doc in tukarPoinSnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final userId = data['userId'];

      if (userId != null) {
        final userDoc = await _firestore.collection('users').doc(userId).get();
        if (userDoc.exists) {
          final userData = userDoc.data() as Map<String, dynamic>;
          final userName = userData['nama'] ?? 'Unknown User';

          final sampahData = {
            'userName': userName,
            'jenisSampah': data['jenisSampah'],
            'kilo': (data['kilo'] as num).toDouble(),
          };

          if (groupedData.containsKey(userId)) {
            groupedData[userId]!.add(sampahData);
          } else {
            groupedData[userId] = [sampahData];
          }
        }
      }
    }

    _groupedTukarPoinData = groupedData;
    notifyListeners();
  }

  int calculateTotalPoints(List<Map<String, dynamic>> sampahList) {
    double totalKilo =
        sampahList.fold(0.0, (sum, item) => sum + (item['kilo'] as double));
    return (totalKilo * 2000).toInt();
  }

  Future<void> confirmTukarPoin(String userId) async {
    // Fetch total points for the user
    List<Map<String, dynamic>> userTukarPoinData =
        _groupedTukarPoinData[userId] ?? [];
    int totalPoints = calculateTotalPoints(userTukarPoinData);

    // Update user's points
    final userDocRef = _firestore.collection('users').doc(userId);
    final userDoc = await userDocRef.get();
    if (userDoc.exists) {
      final userData = userDoc.data() as Map<String, dynamic>;
      int currentPoints = userData['points'] ?? 0;
      await userDocRef.update({
        'points': currentPoints + totalPoints,
      });
    }

    // Delete user's tukar_poin documents
    final tukarPoinSnapshot = await _firestore
        .collection('tukar_poin')
        .where('userId', isEqualTo: userId)
        .get();

    for (var doc in tukarPoinSnapshot.docs) {
      await _firestore.collection('tukar_poin').doc(doc.id).delete();
    }

    // Remove user from groupedTukarPoinData
    _groupedTukarPoinData.remove(userId);
    notifyListeners();
  }
}
