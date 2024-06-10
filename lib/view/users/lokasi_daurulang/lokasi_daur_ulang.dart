// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LokasiDaurUlang extends StatefulWidget {
  const LokasiDaurUlang({super.key});

  @override
  State<LokasiDaurUlang> createState() => _LokasiDaurUlangState();
}

class _LokasiDaurUlangState extends State<LokasiDaurUlang> {
  final String mapUrl = 'https://www.google.com/maps/place';
  final String phoneNumber = '0834xxxxxxx';

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchPhone(String phoneNumber) async {
    final phoneUrl = 'tel:$phoneNumber';
    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw 'Could not call $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lokasi Daur Ulang Sampah'),
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.lightGreen[100], // Warna latar belakang hijau muda
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Image.asset(
                'assets/lokasi.png', // Ganti dengan URL gambar peta Anda
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Container(
                width: 350, // Lebar tetap untuk Card
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Ecocycle'),
                        SizedBox(height: 8),
                        Text(
                          'Alamat',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Jalan Mastrip'),
                        SizedBox(height: 8),
                        Text(
                          'No HP',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () => _launchPhone(phoneNumber),
                          child: Text(
                            phoneNumber,
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Jam',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('08:00 - 16:00'),
                        SizedBox(height: 8),
                        Text(
                          'Link',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () => _launchURL(mapUrl),
                          child: Text(
                            mapUrl,
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
