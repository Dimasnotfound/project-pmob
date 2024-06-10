import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trash_solver/utils/utils.dart';

class TambahDaurulangViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  XFile? _image;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    _image = pickedImage;
    // print("Image picked: $_image");
    notifyListeners();
  }

  XFile? get image => _image;

  Stream<List<Map<String, dynamic>>>? articlesStream;

  TambahDaurulangViewModel() {
    fetchDataFromFirestore();
  }

  void fetchDataFromFirestore() {
    articlesStream = FirebaseFirestore.instance
        .collection('daur_ulang')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              data['id'] = doc.id; // Menambahkan ID dari dokumen Firestore
              return data;
            }).toList());
    notifyListeners();
  }

  Future<void> saveData(BuildContext context) async {
    // Validasi input tidak boleh kosong
    if (nameController.text.isEmpty || descriptionController.text.isEmpty) {
      Utils.showErrorSnackBar(
        Overlay.of(context),
        "Nama dan Deskripsi tidak boleh kosong",
      );
      return;
    }

    if (_image == null) {
      Utils.showErrorSnackBar(
        Overlay.of(context),
        "Image Kosong",
      );
      return;
    }

    // Ensure user is signed in
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // print("User is not signed in");
      return;
    }

    String? imageUrl;
    try {
      // Upload image to Firebase Storage
      final fileName = _image!.name;
      final File file = File(_image!.path);
      final storageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');

      // print("Uploading file: ${file.path}");

      UploadTask uploadTask = storageRef.putFile(file);
      TaskSnapshot snapshot = await uploadTask;

      if (snapshot.state == TaskState.success) {
        imageUrl = await storageRef.getDownloadURL();
        // print("Image uploaded: $imageUrl");
      } else {
        // print("Upload failed");
        Utils.showErrorSnackBar(
          Overlay.of(context),
          "Upload Gagal",
        );
      }
    } catch (e) {
      // print("Error uploading image: $e");
      Utils.showErrorSnackBar(
        Overlay.of(context),
        "Error Upload",
      );
    }

    if (imageUrl != null) {
      // Save data to Firestore
      try {
        final docRef =
            FirebaseFirestore.instance.collection('daur_ulang').doc();
        await docRef.set({
          'name': nameController.text,
          'description': descriptionController.text,
          'imageUrl': imageUrl,
        });
        // print("Data saved to Firestore");

        // Clear inputs
        nameController.clear();
        descriptionController.clear();
        _image = null;
        notifyListeners();

        // Tampilkan snackbar sukses
        Utils.showSuccessSnackBar(
          Overlay.of(context),
          "Data telah ditambahkan",
        );
      } catch (e) {
        // print("Error saving data to Firestore: $e");
      }
    } else {
      // print("Image URL is null");
      Utils.showErrorSnackBar(
        Overlay.of(context),
        "Image Kosong",
      );
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('daur_ulang')
          .doc(id)
          .delete();
      // Refresh data setelah penghapusan
      fetchDataFromFirestore();
    } catch (e) {
      // Handle error
    }
  }
}
