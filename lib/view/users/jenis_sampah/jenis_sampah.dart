import 'package:flutter/material.dart';

class JenisSampah extends StatefulWidget {
  const JenisSampah({super.key});

  @override
  State<JenisSampah> createState() => _JenisSampahState();
}

class _JenisSampahState extends State<JenisSampah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFACE7EF), // Warna biru
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            // Aksi kembali
          },
        ),
        title: Text(
          'Jenis sampah',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFC8F7C5), // Warna hijau muda
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            SampahCard(
              imageUrl:
                  'https://via.placeholder.com/150', // Ganti dengan URL gambar yang sesuai
              title: 'PET atau PETE',
              date: '30 Februari 1999',
            ),
            SampahCard(
              imageUrl:
                  'https://via.placeholder.com/150', // Ganti dengan URL gambar yang sesuai
              title: 'HDPE',
              date: '30 Februari 1999',
            ),
            SampahCard(
              imageUrl:
                  'https://via.placeholder.com/150', // Ganti dengan URL gambar yang sesuai
              title: 'PVC/VINYL',
              date: '30 Februari 1999',
            ),
            SampahCard(
              imageUrl:
                  'https://via.placeholder.com/150', // Ganti dengan URL gambar yang sesuai
              title: 'LDPE',
              date: '30 Februari 1999',
            ),
            SampahCard(
              imageUrl:
                  'https://via.placeholder.com/150', // Ganti dengan URL gambar yang sesuai
              title: 'PP',
              date: '30 Februari 1999',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFACE7EF), // Warna biru
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete, color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping, color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money, color: Colors.black),
            label: '',
          ),
        ],
      ),
    );
  }
}

class SampahCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;

  SampahCard({required this.imageUrl, required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image.network(
              imageUrl,
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      date,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  'Baca Selengkapnya',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
