// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:trash_solver/utils/routes/routes_names.dart';
import 'package:trash_solver/viewmodel/login_viewmodel.dart';
import 'package:trash_solver/viewmodel/tambahartikel_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DashboardUser extends StatefulWidget {
  const DashboardUser({Key? key});

  @override
  State<DashboardUser> createState() => _DashboardUserState();
}

class _DashboardUserState extends State<DashboardUser> {
  final TambahartikelViewmodel viewModel = TambahartikelViewmodel();

  final NumberFormat _numberFormat = NumberFormat.decimalPattern();

  String formatNumber(int number) {
    return _numberFormat.format(number);
  }

  @override
  Widget build(BuildContext context) {
    final viewModelAkun = context.watch<LoginViewModel>();
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.profil);
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(
                  'assets/profile_image.png',
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
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
                  FutureBuilder(
                    future: viewModelAkun.fetchUserPoints(),
                    builder: (context, AsyncSnapshot<int> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final userPoints = snapshot.data ?? 0;
                        final formattedPoints = formatNumber(userPoints);
                        final equivalentMoney = userPoints ~/ 100;
                        final formattedMoney = formatNumber(equivalentMoney);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$formattedPoints P',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[800],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                                'Bisa dikonversikan menjadi Rp $formattedMoney'),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: ListTile(
              leading: Image.asset(
                'assets/recycling_location.jpg',
                // Ganti dengan gambar yang sesuai
              ),
              title: Text(
                'Lokasi daur Ulang sampah',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Informasi mengenai lokasi yang menampung daur ulang sampah',
              ),
              trailing: ElevatedButton(
                onPressed: () async {
                  await Navigator.pushNamed(
                    context,
                    RouteNames.lokasi,
                  );
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
          StreamBuilder(
            stream: viewModel.articlesStream,
            builder:
                (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final articles = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return ArtikelCard(
                      id: article['id'],
                      title: article['name'],
                      description: article['description'],
                      image: article['imageUrl'],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIconCard(IconData icon, String text) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
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
}

class ArtikelCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String image;

  ArtikelCard({
    required this.id, // Tambahkan parameter ID
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  width: 30,
                  height: 100,
                ),
              ),
            ),
            ListTile(
              title: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                description.length > 60
                    ? '${description.substring(0, 60)}...'
                    : description,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    await Navigator.pushNamed(
                      context,
                      RouteNames.detilArtikel,
                      arguments: id,
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Baca Selengkapnya'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
