import 'package:flutter/material.dart';
import 'package:trash_solver/services/firebase_services.dart';
import 'package:trash_solver/utils/utils.dart';

class AkunViewModel extends ChangeNotifier {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nomorPonselController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();

  final FirebaseService _firebaseService = FirebaseService();

  // Tambahkan method untuk membersihkan controller
  void disposeControllers() {
    namaController.dispose();
    emailController.dispose();
    nomorPonselController.dispose();
    passwordController.dispose();
    alamatController.dispose();
  }

  void clearControllers() {
    namaController.clear();
    emailController.clear();
    nomorPonselController.clear();
    passwordController.clear();
    alamatController.clear();
  }

  Future<void> register(BuildContext context) async {
    try {
      // Menggunakan await untuk menunggu operasi async selesai
      await _firebaseService.registerUser(
        nama: namaController.text,
        email: emailController.text,
        nomorPonsel: nomorPonselController.text,
        password: passwordController.text,
        alamat: alamatController.text,
      );

      // Menampilkan snackbar sukses
      Utils.showSuccessSnackBar(
        Overlay.of(context),
        "Registrasi Berhasil",
      );

      // Membersihkan controller setelah registrasi sukses
      clearControllers();
    } catch (e) {
      // Menangani error dan menampilkan pesan kesalahan
      Utils.showErrorSnackBar(
        Overlay.of(context),
        "Terjadi kesalahan: $e",
      );
    }
  }
}
