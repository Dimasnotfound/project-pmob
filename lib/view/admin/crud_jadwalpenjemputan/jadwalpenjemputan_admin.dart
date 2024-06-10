import 'package:flutter/material.dart';
import 'package:pmob_project/viewmodel/jadwalpenjemputan_viewmodel.dart';
import 'package:provider/provider.dart';

class JadwalpenjemputanAdmin extends StatefulWidget {
  const JadwalpenjemputanAdmin({super.key});

  @override
  State<JadwalpenjemputanAdmin> createState() => _JadwalpenjemputanAdminState();
}

class _JadwalpenjemputanAdminState extends State<JadwalpenjemputanAdmin> {
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
      appBar: AppBar(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              final viewModel = context.watch<JadwalpenjemputanViewmodel>();

              return AlertDialog(
                content: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Positioned(
                      right: -40.0,
                      top: -40.0,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          child: Icon(Icons.close),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: DropdownButtonFormField<String>(
                              decoration:
                                  InputDecoration(labelText: "Pilih Hari"),
                              value: viewModel.selectedDay,
                              onChanged: (value) {
                                viewModel.setSelectedDay(value);
                              },
                              items: jadwal.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item['hari'],
                                  child: Text(item['hari']),
                                );
                              }).toList(),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: viewModel.jamMulaiController,
                                    decoration:
                                        InputDecoration(labelText: "Jam Mulai"),
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: viewModel.jamSelesaiController,
                                    decoration: InputDecoration(
                                        labelText: "Jam Selesai"),
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: viewModel.daerahController,
                              decoration:
                                  InputDecoration(labelText: "Pilih daerah"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: DropdownButtonFormField<int>(
                              decoration:
                                  InputDecoration(labelText: "Jadwal ke -"),
                              value: viewModel.selectedSchedule,
                              onChanged: (value) {
                                viewModel.setSelectedSchedule(value);
                              },
                              items: [1, 2, 3].map((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: Text("Konfirmasi"),
                              onPressed: () async {
                                await viewModel.saveData(context);
                                Navigator.of(context).pop();
                                // Tidak perlu setState karena ViewModel akan memberitahu perubahan data
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.edit),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
