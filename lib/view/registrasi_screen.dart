import 'package:flutter/material.dart';
import 'package:pmob_project/utils/routes/routes_names.dart';
import 'package:pmob_project/viewmodel/akun_viewmodel.dart';
import 'package:provider/provider.dart';

class RegistrasiScreen extends StatefulWidget {
  const RegistrasiScreen({super.key});

  @override
  State<RegistrasiScreen> createState() => _RegistrasiScreenState();
}

class _RegistrasiScreenState extends State<RegistrasiScreen> {
  @override
  Widget build(BuildContext context) {
    final akunViewModel = Provider.of<AkunViewModel>(context);

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
          style: TextStyle(color: Colors.green[800]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'Daftar sekarang dan langsung gunakan fitur-fitur yang tersedia untuk membantu anda mengelola sampah daur ulang!',
              style: TextStyle(color: Colors.green[800]),
            ),
            SizedBox(height: 32),
            TextField(
              controller: akunViewModel.namaController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Nama Pengguna',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: akunViewModel.emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Email Pengguna',
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: TextField(
                    // controller: akunViewModel.nomorPonselController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: '+62',
                    ),
                    readOnly: true,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: akunViewModel.nomorPonselController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: 'Nomer Ponsel',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: akunViewModel.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await akunViewModel.register(context);
                  akunViewModel.clearControllers();
                  Navigator.pushNamed(context, RouteNames.login);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.green[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Daftar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
