// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pmob_project/viewmodel/login_viewmodel.dart';
import 'package:pmob_project/utils/routes/routes_names.dart';
import 'package:pmob_project/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green[800]),
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.splashScreen);
          },
        ),
        title: Text(
          'Kembali',
          style: TextStyle(
            color: Colors.green[800],
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Masukkan email dan password anda untuk masuk kedalam aplikasi.',
              style: TextStyle(
                color: Colors.green[800],
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email Pengguna',
                labelStyle: TextStyle(color: Colors.green[800]),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.green[800]),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  await loginViewModel.login(
                    _emailController.text,
                    _passwordController.text,
                  );
                  // Navigasi ke halaman utama jika login berhasil
                  if (loginViewModel.isLoggedIn) {
                    Navigator.pushNamed(context, RouteNames.dashboard);
                    Utils.showSuccessSnackBar(
                      Overlay.of(context),
                      "Data Berhasil Disimpan",
                    );
                  }
                } catch (e) {
                  // Tampilkan pesan error jika login gagal
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text(e.toString()),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Warna tombol
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                'Masuk',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
