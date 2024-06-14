import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trash_solver/viewmodel/penukaranUangAdmin_viewmodel.dart';

class PenukaranuangAdmin extends StatefulWidget {
  const PenukaranuangAdmin({super.key});

  @override
  State<PenukaranuangAdmin> createState() => _PenukaranuangAdminState();
}

class _PenukaranuangAdminState extends State<PenukaranuangAdmin> {
  @override
  void initState() {
    super.initState();
    context.read<PenukaranUangAdminViewModel>().fetchTukarUangData();
  }

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
        centerTitle: true,
      ),
      body: Consumer<PenukaranUangAdminViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (viewModel.groupedTukarUangData.isEmpty) {
            return Center(child: Text('Tidak Ada Data Penukaran'));
          } else {
            return ListView.builder(
              itemCount: viewModel.groupedTukarUangData.length,
              itemBuilder: (context, index) {
                final userId =
                    viewModel.groupedTukarUangData.keys.elementAt(index);
                final userTransactions =
                    viewModel.groupedTukarUangData[userId]!;

                return Column(
                  children: userTransactions.map((transaction) {
                    String assetPath;
                    double assetHeight = 24;
                    switch (transaction['method']) {
                      case 'DANA':
                        assetPath = 'assets/danalogo.png';
                        break;
                      case 'gopay':
                        assetPath = 'assets/gopay.png';
                        assetHeight = 64;
                        break;
                      case 'OVO':
                        assetPath = 'assets/ovo.png';
                        break;
                      default:
                        assetPath = 'assets/unknown.png';
                        break;
                    }

                    final formattedPoints = viewModel
                        .formatNumber(transaction['points_yang_ditukar']);

                    return Container(
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
                            transaction['userName'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text('Menukarkan:'),
                          SizedBox(height: 8.0),
                          Text(
                            '$formattedPoints Poin / Rp $formattedPoints',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Text('Via:'),
                              SizedBox(width: 8.0),
                              Image.asset(
                                assetPath,
                                height: assetHeight,
                              ),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  await viewModel.tolakPenukaran(
                                    transaction['userId'],
                                    transaction['docId'],
                                    transaction['points_yang_ditukar'],
                                  );
                                },
                                child: Text(
                                  'Tolak',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await viewModel.konfirmasiPenukaran(
                                    transaction['docId'],
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
                );
              },
            );
          }
        },
      ),
    );
  }
}
