// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlue[300],
        elevation: 0,
        title: Text(
          'TRASH SOLVER',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                'assets/profile_image.png',
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, user',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Poin anda sudah terkumpul'),
                  SizedBox(height: 8),
                  Text(
                    '9.000.000 P',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Bisa dikonversikan menjadi Rp 90.000'),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: ListTile(
              leading: Image.asset(
                'assets/recycling_location.jpg', // Ganti dengan gambar yang sesuai
              ),
              title: Text(
                'Lokasi daur Ulang sampah',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Informasi mengenai lokasi yang menampung daur ulang sampah'),
              trailing: ElevatedButton(
                onPressed: () {
                  // Aksi ketika tombol diklik
                },
                child: Text('Kunjungi'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIconCard(Icons.delete, 'Jenis\nDaur Ulang'),
              _buildIconCard(Icons.schedule, 'Jadwal\npenjemputan'),
              _buildIconCard(Icons.monetization_on, 'Penukaran\nsampah'),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Berita mengenai sampah',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _buildNewsCard(
              '7,2 Juta Ton Sampah di Indonesia Belum Terkelola Dengan Baik',
              '30 Februari 1999',
              'Baca Selengkapnya'),
          _buildNewsCard('Sebegini Parah Ternyata Masalah Sampah Plastik',
              '31 Februari 2070', 'Baca Selengkapnya'),
        ],
      ),
    );
  }

  Widget _buildIconCard(IconData icon, String text) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Colors.green[700]),
            SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(String title, String date, String buttonText) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(title),
        subtitle: Text(date),
        trailing: TextButton(
          onPressed: () {
            // Aksi ketika tombol diklik
          },
          child: Text(buttonText),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
