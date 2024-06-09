import 'package:flutter/material.dart';

class PenukaranuangAdmin extends StatefulWidget {
  const PenukaranuangAdmin({super.key});

  @override
  State<PenukaranuangAdmin> createState() => _PenukaranuangAdminState();
}

class _PenukaranuangAdminState extends State<PenukaranuangAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Penukaran Uang',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF8AB4F8),
        centerTitle: true, // Adjust this color as needed
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter, // Align the box to the top center
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 16.0), // Add some padding to the top
                child: Container(
                  margin: EdgeInsets.all(16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'User 1',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text('Menukarkan:'),
                      SizedBox(height: 8.0),
                      Text(
                        '100.000 Poin',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Text(
                            'Via :',
                          ),
                          // memberikan jarak antara teks dan gambar
                          Image.asset(
                            'assets/danalogo.png', // Path to DANA logo image asset
                            height: 24,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Tolak',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Konfirmasi',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
