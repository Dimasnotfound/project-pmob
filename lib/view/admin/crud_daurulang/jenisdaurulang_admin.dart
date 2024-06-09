import 'package:flutter/material.dart';
import 'package:pmob_project/utils/routes/routes_names.dart';
import 'package:pmob_project/viewmodel/tambahdaurulang_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:pmob_project/utils/utils.dart';


class JenisdaurulangAdmin extends StatefulWidget {
  const JenisdaurulangAdmin({Key? key}) : super(key: key);

  @override
  State<JenisdaurulangAdmin> createState() => _JenisdaurulangAdminState();
}

class _JenisdaurulangAdminState extends State<JenisdaurulangAdmin> {
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
        backgroundColor: Colors.lightBlue,
        automaticallyImplyLeading: false,
        title: Text(
          'Jenis Daur Ulang',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.lightGreenAccent[100],
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _viewModel.articlesStream,
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final articles = snapshot.data!;
                    return ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return ArtikelCard(
                          id: article['id'], // Tambahkan ID
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.tambahDaurUlangAdmin);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(
                'Tambah',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
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
              title: Text(title),
              subtitle: Text(
                description.length > 10
                    ? '${description.substring(0, 10)}...'
                    : description,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.editDaurUlangAdmin,
                      arguments: id, // Mengirimkan ID sebagai argumen
                    );
                  },
                  child: Text(
                    'Edit',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Konfirmasi"),
                          content: Text(
                              "Apakah Anda yakin ingin menghapus item ini?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Batal"),
                            ),
                            TextButton(
                              onPressed: () {
                                // Hapus item dari view model dan Firestore
                                Provider.of<TambahDaurulangViewModel>(
                                  context,
                                  listen: false,
                                ).deleteItem(id);

                                Utils.showSuccessSnackBar(
                                  Overlay.of(context),
                                  "Data berhasil Dihapus",
                                );
                                Navigator.pop(context);
                              },
                              child: Text("Hapus"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
