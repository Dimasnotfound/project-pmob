import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TukarUangViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int userPoints = 0;

  TukarUangViewModel() {
    fetchUserPoints();
  }

  Future<void> fetchUserPoints() async {
    User? user = _auth.currentUser;
    if (user != null) {
      var userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        // Handle case where 'points' might be stored as double
        dynamic pointsData = userData['points'];
        if (pointsData is double) {
          userPoints = pointsData.toInt();
        } else {
          userPoints = userData['points'] ?? 0;
        }
        notifyListeners();
      }
    }
  }

  Future<void> exchangePoints(int pointsToExchange, String method) async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Add the exchange request to 'tukar_uang' collection
      await _firestore.collection('tukar_uang').add({
        'userId': user.uid,
        'points_yang_ditukar': pointsToExchange,
        'method': method,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Get a reference to the user's document
      var userDocRef = _firestore.collection('users').doc(user.uid);

      // Perform a transaction to update the user's points
      await _firestore.runTransaction((transaction) async {
        var userDoc = await transaction.get(userDocRef);
        if (userDoc.exists) {
          // Convert currentPoints to int if necessary
          int currentPoints = (userDoc.data()?['points'] as num).toInt();
          transaction.update(userDocRef, {
            'points': currentPoints - pointsToExchange,
          });
        }
      });

      // Fetch updated points
      await fetchUserPoints();
    }
  }
}
