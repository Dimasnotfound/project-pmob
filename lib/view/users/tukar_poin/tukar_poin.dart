import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trash_solver/viewmodel/sampah_viewmodel.dart';

class TukarPoin extends StatefulWidget {
  const TukarPoin({super.key});

  @override
  State<TukarPoin> createState() => _TukarPoinState();
}

class _TukarPoinState extends State<TukarPoin> {
  final TextEditingController _kiloController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final NumberFormat _numberFormat = NumberFormat.decimalPattern();

  String formatNumber(int number) {
    return _numberFormat.format(number);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<SampahViewModel>(context, listen: false).fetchSampah();
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SampahViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.lightBlue,
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Hi, user',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Poin anda sudah terkumpul',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                // Bagian yang diubah
                FutureBuilder<int>(
                  future: viewModel.fetchUserPoints(),
                  builder: (context, AsyncSnapshot<int> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final userPoints =
                          snapshot.data ?? 0; // Menangani nilai null
                      final formattedPoints = formatNumber(userPoints);
                      final equivalentMoney = userPoints ~/ 100;
                      final formattedMoney = formatNumber(equivalentMoney);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              '$formattedPoints P',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              'Bisa dikonversikan menjadi Rp $formattedMoney',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text('Tukar Poin'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.greenAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tukar sampahmu menjadi Poin',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.network(viewModel.selectedImageUrl ?? '',
                                width: 40, height: 40),
                            SizedBox(width: 10),
                            Text(
                              viewModel.selectedSampah ?? 'Sampah jenis PET',
                              style: TextStyle(fontSize: 18),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _kiloController,
                          decoration: InputDecoration(
                            labelText: 'Masukkan dalam satuan KG',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            User? user = _auth.currentUser;
                            if (_kiloController.text.isEmpty) {
                              _showErrorSnackBar(
                                  context, "Data Tidak Boleh Kosong");
                              return;
                            }
                            final userId = user?.uid;
                            if (userId == null) {
                              _showErrorSnackBar(
                                  context, "User tidak ditemukan");
                              return;
                            }
                            final kilo = double.parse(_kiloController.text);
                            await viewModel.insertTukarPoin(
                              userId,
                              viewModel.selectedSampah!,
                              kilo,
                            );
                            _kiloController.clear();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                          ),
                          child: Text('Tukar Sampah'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      _showSampahDialog(context);
                    },
                    child: Text(
                      'Pilih Sampah Jenis Lain',
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSampahDialog(BuildContext context) {
    final viewModel = context.read<SampahViewModel>();
    viewModel.fetchSampah().then((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pilih jenis sampah'),
            content: SingleChildScrollView(
              child: Consumer<SampahViewModel>(
                builder: (context, viewModel, child) {
                  return ListBody(
                    children: viewModel.sampahList.map((sampah) {
                      return ListTile(
                        leading: Image.network(sampah.imageUrl),
                        title: Text(sampah.name),
                        trailing: Radio(
                          value: sampah.name,
                          groupValue: viewModel.selectedSampah,
                          onChanged: (value) {
                            viewModel.selectSampah(
                                value as String, sampah.imageUrl);
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tambah'),
              ),
            ],
          );
        },
      );
    });
  }
}
