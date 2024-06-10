import 'package:flutter/material.dart';
import 'package:trash_solver/viewmodel/jadwalpenjemputan_viewmodel.dart';
import 'package:provider/provider.dart';

class JadwalPenjemputan extends StatefulWidget {
  const JadwalPenjemputan({super.key});

  @override
  State<JadwalPenjemputan> createState() => _JadwalPenjemputanState();
}

class _JadwalPenjemputanState extends State<JadwalPenjemputan> {
  final List<Map<String, dynamic>> jadwal = [
    {
      'hari': 'Senin',
    },
    {
      'hari': 'Selasa',
    },
    {
      'hari': 'Rabu',
    },
    {
      'hari': 'Kamis',
    },
    {
      'hari': 'Jumat',
    },
    {
      'hari': 'Sabtu',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Memanggil init() setiap kali initState dipanggil
    context.read<JadwalpenjemputanViewmodel>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Jadwal Penjemputan'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Consumer<JadwalpenjemputanViewmodel>(
        builder: (context, viewModel, child) {
          if (viewModel.isSaving || viewModel.jadwal.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          // Sorting jadwal by day order
          List<Map<String, dynamic>> sortedJadwal = List.from(viewModel.jadwal);
          sortedJadwal.sort((a, b) {
            const dayOrder = {
              'Senin': 1,
              'Selasa': 2,
              'Rabu': 3,
              'Kamis': 4,
              'Jumat': 5,
              'Sabtu': 6,
            };
            return dayOrder[a['hari']]!.compareTo(dayOrder[b['hari']]!);
          });

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: sortedJadwal.length,
              itemBuilder: (context, index) {
                final item = sortedJadwal[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: item['color'],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                          ),
                          child: Text(
                            'Hari ${item['hari']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...item['waktu'].map<Widget>((waktu) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(waktu['jam']),
                                Text(waktu['lokasi']),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
