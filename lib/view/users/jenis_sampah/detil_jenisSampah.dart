import 'package:flutter/material.dart';
import 'package:pmob_project/viewmodel/editdaurulang_viewmodel.dart';
import 'package:provider/provider.dart';

class DetilJenisSampah extends StatefulWidget {
  final String id;
  const DetilJenisSampah({super.key, required this.id});

  @override
  State<DetilJenisSampah> createState() => _DetilJenisSampahState();
}

class _DetilJenisSampahState extends State<DetilJenisSampah> {
  @override
  void initState() {
    super.initState();
    // Panggil method fetchDataFromFirestore saat initState
    context
        .read<EditDaurulangViewModel>()
        .fetchDataFromFirestorejenis(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EditDaurulangViewModel>();
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green[800]),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Kembali',
          style: TextStyle(color: Colors.green[800]),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                viewModel.jenisNamaController.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Image.network(
                viewModel.imageController
                    .text, // Ganti dengan URL gambar yang sesuai
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                viewModel.jenisDeskripsiController.text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
