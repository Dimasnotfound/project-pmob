import 'package:flutter/material.dart';
import 'package:pmob_project/utils/routes/routes_names.dart';
import 'package:pmob_project/viewmodel/tambahdaurulang_viewmodel.dart';

class JenisSampah extends StatefulWidget {
  const JenisSampah({super.key});

  @override
  State<JenisSampah> createState() => _JenisSampahState();
}

class _JenisSampahState extends State<JenisSampah> {
  final TambahDaurulangViewModel _viewModel = TambahDaurulangViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.fetchDataFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFACE7EF), // Warna biru
        elevation: 0,

        title: Text(
          'Jenis Sampah',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFC8F7C5), // Warna hijau muda
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: _viewModel.articlesStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No articles found'));
                    } else {
                      final articles = snapshot.data!;
                      return ListView.builder(
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
              ),
            ],
          ),
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
              title: Text(title),
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
                      RouteNames.detilSampah,
                      arguments: id,
                    );
                  },
                  child: Text(
                    'Baca Selengkapnya',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
