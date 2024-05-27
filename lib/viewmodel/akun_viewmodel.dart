// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:pmob_project/services/firebase_services.dart';
import 'package:pmob_project/utils/utils.dart';

class AkunViewModel extends ChangeNotifier {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nomorPonselController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseService _firebaseService = FirebaseService();

  // Tambahkan method untuk membersihkan controller
  void disposeControllers() {
    namaController.dispose();
    emailController.dispose();
    nomorPonselController.dispose();
    passwordController.dispose();
  }

   void clearControllers() {
    namaController.clear();
    emailController.clear();
    nomorPonselController.clear();
    passwordController.clear();
  }

  Future<void> register(BuildContext context) async {
  try {
    // Menggunakan await untuk menunggu operasi async selesai
    await _firebaseService.tambahDataUser(
      nama: namaController.text,
      email: emailController.text,
      nomorPonsel: nomorPonselController.text,
      password: passwordController.text,
    );

    // Menampilkan snackbar sukses
    Utils.showSuccessSnackBar(
      Overlay.of(context),
      "Data Berhasil Disimpan",
    );
  } catch (e) {
    // Menangani error dan menampilkan pesan kesalahan
    Utils.showErrorSnackBar(
      Overlay.of(context),
      "Terjadi kesalahan: $e",
    );
  }
}

}
