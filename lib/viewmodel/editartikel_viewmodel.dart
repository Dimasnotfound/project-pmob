import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:pmob_project/utils/utils.dart';

class EditartikelViewmodel extends ChangeNotifier {
  final TextEditingController nameEditController = TextEditingController();
  final TextEditingController descriptionEditController =
      TextEditingController();
  XFile? _image;

  Future<void> fetchDataFromFirestore(String id) async {
    try {
      final docSnapshot =
          await FirebaseFirestore.instance.collection('artikel').doc(id).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        nameEditController.text = data['name'] ?? '';
        descriptionEditController.text = data['description'] ?? '';
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    _image = pickedImage;
    notifyListeners();
  }

  XFile? get image => _image;

  Future<void> saveData(BuildContext context, String id) async {
    // Validasi input tidak boleh kosong
    if (nameEditController.text.isEmpty ||
        descriptionEditController.text.isEmpty) {
      Utils.showErrorSnackBar(
        Overlay.of(context),
        "Nama dan Deskripsi tidak boleh kosong",
      );
      return;
    }

    // Mengambil instance dari Firestore
    final firestore = FirebaseFirestore.instance;

    try {
      // Variabel untuk menyimpan URL gambar
      String? imageUrl;

      // Cek apakah ada gambar yang dipilih
      if (_image != null) {
        // Upload image to Firebase Storage
        final fileName = _image!.name;
        final File file = File(_image!.path);
        final storageRef =
            FirebaseStorage.instance.ref().child('uploads/$fileName');

        // Upload file
        await storageRef.putFile(file);

        // Dapatkan URL download gambar setelah upload selesai
        imageUrl = await storageRef.getDownloadURL();
      }

      // Buat objek untuk menyimpan data yang akan diperbarui
      Map<String, dynamic> updateData = {
        'name': nameEditController.text,
        'description': descriptionEditController.text,
      };

      // Tambahkan imageUrl ke dalam updateData jika imageUrl tidak null atau tidak kosong
      if (imageUrl != null && imageUrl.isNotEmpty) {
        updateData['imageUrl'] = imageUrl;
      }

      // Update data di Firestore
      await firestore.collection('artikel').doc(id).update(updateData);

      // Setelah data diperbarui, kosongkan instance _image
      _image = null;

      // Menampilkan snackbar sukses
      Utils.showSuccessSnackBar(
        Overlay.of(context),
        "Data telah diperbarui",
      );

      // Kembali ke halaman sebelumnya
      Navigator.of(context).pop();
    } catch (e) {
      // Menampilkan snackbar error jika terjadi kesalahan
      Utils.showErrorSnackBar(
        Overlay.of(context),
        "Error: ${e.toString()}",
      );
    }
  }
}
