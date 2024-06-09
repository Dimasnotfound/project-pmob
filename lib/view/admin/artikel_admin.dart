import 'package:flutter/material.dart';

class ArtikelAdmin extends StatefulWidget {
  const ArtikelAdmin({super.key});

  @override
  State<ArtikelAdmin> createState() => _ArtikelAdminState();
}

class _ArtikelAdminState extends State<ArtikelAdmin> {
  final List<Map<String, String>> articles = [
    {"title": "Artikel1", "date": "30 Februari 1999"},
    {"title": "Artikel2", "date": "30 Februari 1999"},
    {"title": "Artikel3", "date": "30 Februari 1999"},
    {"title": "Artikel4", "date": "30 Februari 1999"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     // Add the functionality to go back to the previous screen
        //     Navigator.pop(context);
        //   },
        // ),
        title: Text(
          'Artikel',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.lightGreenAccent[100],
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return ArtikelCard(
                    title: articles[index]['title']!,
                    date: articles[index]['date']!,
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Tambah',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ArtikelCard extends StatelessWidget {
  final String title;
  final String date;

  ArtikelCard({required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 3,
        child: ListTile(
          title: Text(title),
          subtitle: Text(date),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  // Edit action
                },
                child: Text(
                  'Edit',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Delete action
                },
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
