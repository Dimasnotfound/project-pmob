import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trash_solver/utils/utils.dart';
import 'package:trash_solver/viewmodel/penukaranPoin_viewmodel.dart'; // Update this path accordingly

class PenukaranPoinAdmin extends StatefulWidget {
  const PenukaranPoinAdmin({super.key});

  @override
  State<PenukaranPoinAdmin> createState() => _PenukaranPoinAdminState();
}

class _PenukaranPoinAdminState extends State<PenukaranPoinAdmin> {
  @override
  void initState() {
    super.initState();
    Provider.of<PenukaranPoinAdminViewModel>(context, listen: false)
        .fetchTukarPoinData();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PenukaranPoinAdminViewModel>();

    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Penukaran Poin',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.lightBlue[300],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: viewModel.groupedTukarPoinData.isEmpty
              ? Center(
                  child: Text(
                    'Tidak ada notifikasi',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Column(
                  children: viewModel.groupedTukarPoinData.entries.map((entry) {
                    final userId = entry.key;
                    final userTukarPoinData = entry.value;
                    final userName = userTukarPoinData[0]['userName'];
                    final totalPoints =
                        viewModel.calculateTotalPoints(userTukarPoinData);

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            userName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text('Menukarkan:'),
                          SizedBox(height: 8.0),
                          ...userTukarPoinData.map((item) {
                            return Text(
                              '${item['jenisSampah']}        ${item['kilo']} kg',
                            );
                          }).toList(),
                          SizedBox(height: 8.0),
                          Text(
                            'Poin ditukar: $totalPoints poin',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  await viewModel.confirmTukarPoin(userId);
                                  Utils.showSuccessSnackBar(
                                    Overlay.of(context),
                                    "Point Berhasil Ditukar",
                                  );
                                },
                                child: Text(
                                  'Konfirmasi',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
