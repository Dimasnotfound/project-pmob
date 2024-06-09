import 'package:flutter/material.dart';
import 'package:pmob_project/utils/routes/routes_names.dart';

class DashboardAdmin extends StatefulWidget {
  final VoidCallback navigateToJadwalPenjemputan;
  final VoidCallback navigateToArtikel;
  final VoidCallback navigateToDaurUlang;
  final VoidCallback navigateToPenukaranUang;

  const DashboardAdmin(
      {super.key,
      required this.navigateToJadwalPenjemputan,
      required this.navigateToArtikel,
      required this.navigateToDaurUlang,
      required this.navigateToPenukaranUang});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF77B6FF), // Custom blue background
        automaticallyImplyLeading: false,
        title: Text(
          'TRASH SOLVER - ADMIN',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.penukaranPoinAdmin);
              },
              child: Text('Konfirmasi penukaran poin'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16),
            AdminOptionCard(
              title: 'Jenis Daur Ulang',
              color: Colors.green,
              onPressed: widget.navigateToDaurUlang,
            ),
            AdminOptionCard(
              title: 'Artikel',
              color: Colors.red,
              onPressed: widget.navigateToArtikel,
            ),
            AdminOptionCard(
              title: 'Jadwal Penjemputan',
              color: Colors.orange,
              onPressed: widget.navigateToJadwalPenjemputan,
            ),
            AdminOptionCard(
              title: 'Penukaran Uang',
              color: Colors.blue,
              onPressed: widget.navigateToPenukaranUang,
            ),
          ],
        ),
      ),
    );
  }
}

class AdminOptionCard extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onPressed;

  const AdminOptionCard({
    required this.title,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: ElevatedButton(
          onPressed: onPressed,
          child: Text('Edit'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: color,
          ),
        ),
      ),
    );
  }
}
