import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trash_solver/utils/utils.dart';

class JadwalpenjemputanViewmodel extends ChangeNotifier {
  final TextEditingController jamMulaiController = TextEditingController();
  final TextEditingController jamSelesaiController = TextEditingController();
  final TextEditingController daerahController = TextEditingController();
  List<Map<String, dynamic>> _jadwal = [];
  String? _selectedDay;
  int? _selectedSchedule;
  bool _isSaving = false;

  List<Map<String, dynamic>> get jadwal => _jadwal;
  String? get selectedDay => _selectedDay;
  int? get selectedSchedule => _selectedSchedule;
  bool get isSaving => _isSaving;

  void fetchJadwalFromFirestore() async {
    try {
      final collectionRef =
          FirebaseFirestore.instance.collection('jadwal_penjemputan');
      final snapshot = await collectionRef.get();

      _jadwal = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'hari': data['hari'],
          'color': Color(data['color']),
          'waktu': List<Map<String, dynamic>>.from(data['waktu']),
        };
      }).toList();

      notifyListeners();
    } catch (e) {
      print('Error fetching jadwal: $e');
    }
  }

  void init() {
    fetchJadwalFromFirestore();
  }

  void setSelectedDay(String? day) {
    _selectedDay = day;
    notifyListeners();
  }

  void setSelectedSchedule(int? schedule) {
    _selectedSchedule = schedule;
    notifyListeners();
  }

  Future<void> saveData(BuildContext context) async {
    if (_selectedDay == null ||
        _selectedSchedule == null ||
        jamMulaiController.text.isEmpty ||
        jamSelesaiController.text.isEmpty ||
        daerahController.text.isEmpty) {
      Utils.showErrorSnackBar(
        Overlay.of(context),
        "Hari, Jadwal, Jam Mulai, Jam Selesai, dan Daerah harus diisi",
      );
      return;
    }

    _isSaving = true;
    notifyListeners();

    String jam = "${jamMulaiController.text} - ${jamSelesaiController.text}";

    try {
      final collectionRef =
          FirebaseFirestore.instance.collection('jadwal_penjemputan');
      QuerySnapshot snapshot =
          await collectionRef.where('hari', isEqualTo: _selectedDay).get();

      if (snapshot.docs.isNotEmpty) {
        String docId = snapshot.docs.first.id;
        List<dynamic> waktu = snapshot.docs.first.get('waktu');
        waktu[_selectedSchedule! - 1] = {
          'jam': jam,
          'lokasi': daerahController.text,
        };
        await collectionRef.doc(docId).update({
          'waktu': waktu,
        });
        Utils.showSuccessSnackBar(
          Overlay.of(context),
          "Data berhasil diperbarui",
        );
      } else {
        Utils.showErrorSnackBar(
          Overlay.of(context),
          "Jadwal penjemputan tidak ditemukan untuk hari $_selectedDay",
        );
      }
    } catch (e) {
      print('Error updating data: $e');
      Utils.showErrorSnackBar(
        Overlay.of(context),
        "Terjadi kesalahan saat memperbarui data",
      );
    } finally {
      _isSaving = false;
      fetchJadwalFromFirestore(); // Refresh jadwal after saving
      notifyListeners();
    }
  }
}
