import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PenukaranUangAdminViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, List<Map<String, dynamic>>> _groupedTukarUangData = {};
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Map<String, List<Map<String, dynamic>>> get groupedTukarUangData =>
      _groupedTukarUangData;

  Future<void> fetchTukarUangData() async {
    _isLoading = true;
    notifyListeners();

    final QuerySnapshot tukarUangSnapshot =
        await _firestore.collection('tukar_uang').get();

    Map<String, List<Map<String, dynamic>>> groupedData = {};

    for (var doc in tukarUangSnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final userId = data['userId'];

      if (userId != null) {
        final userDoc = await _firestore.collection('users').doc(userId).get();
        if (userDoc.exists) {
          final userData = userDoc.data() as Map<String, dynamic>;
          final userName = userData['nama'] ?? 'Unknown User';

          final tukarUangData = {
            'userName': userName,
            'userId': userId,
            'method': data['method'],
            'points_yang_ditukar':
                (data['points_yang_ditukar'] as num).toDouble(),
            'docId': doc.id,
          };

          if (!groupedData.containsKey(userId)) {
            groupedData[userId] = [];
          }
          groupedData[userId]!.add(tukarUangData);
        }
      }
    }

    _groupedTukarUangData = groupedData;
    _isLoading = false;
    notifyListeners();
  }

  String formatNumber(double number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  Future<void> tolakPenukaran(
      String userId, String docId, double points) async {
    try {
      final userDoc = _firestore.collection('users').doc(userId);
      final userSnapshot = await userDoc.get();
      if (userSnapshot.exists) {
        final userData = userSnapshot.data() as Map<String, dynamic>;
        final currentPoints = (userData['points'] as num).toDouble();
        final newPoints = currentPoints + points;

        await userDoc.update({'points': newPoints});
        await _firestore.collection('tukar_uang').doc(docId).delete();

        await fetchTukarUangData();
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> konfirmasiPenukaran(String docId) async {
    try {
      await _firestore.collection('tukar_uang').doc(docId).delete();
      await fetchTukarUangData();
    } catch (e) {
      print("Error: $e");
    }
  }
}
