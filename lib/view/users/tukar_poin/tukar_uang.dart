import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trash_solver/utils/utils.dart';
import 'package:trash_solver/viewmodel/sampah_viewmodel.dart';
import 'package:trash_solver/viewmodel/tukaruang_viewmodel.dart';

class TukarUang extends StatefulWidget {
  const TukarUang({super.key});

  @override
  State<TukarUang> createState() => _TukarUangState();
}

class _TukarUangState extends State<TukarUang> {
  String? selectedMethod;
  String? selectedPoints;
  bool isButtonClicked = false;
  List<String> points = [
    "100.000 poin",
    "200.000 poin",
    "500.000 poin",
    "1.000.000 poin"
  ];
  List<int> pointsThreshold = [
    100000,
    200000,
    500000,
    1000000
  ]; // Points threshold for each option
  List<String> methods = ["DANA", "gopay", "OVO"];

  @override
  Widget build(BuildContext context) {
    final viewModelSampah = context.watch<SampahViewModel>();

    return ChangeNotifierProvider(
      create: (_) => TukarUangViewModel(),
      child: Consumer<TukarUangViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF6C7D47), // Warna hijau pada AppBar
              title: Text('Tukar Poin'),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    viewModelSampah.fetchUserPoints();
                    Navigator.pop(context);
                  }),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tukar Poin',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  ...points.asMap().entries.map((entry) {
                    int index = entry.key;
                    String point = entry.value;
                    bool isSelectable =
                        viewModel.userPoints >= pointsThreshold[index];

                    return GestureDetector(
                      onTap: isSelectable
                          ? () {
                              setState(() {
                                if (selectedPoints == point) {
                                  selectedPoints =
                                      null; // Deselect if already selected
                                } else {
                                  selectedPoints = point;
                                }
                              });
                            }
                          : () {
                              Utils.showErrorSnackBar(
                                Overlay.of(context),
                                "Poin Tidak Cukup",
                              );
                            },
                      child: Container(
                        width: double.infinity, // Memastikan lebar penuh
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        margin: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: selectedPoints == point
                              ? Color(0xFFD0E6A5)
                              : Colors
                                  .white, // Warna latar belakang saat dipilih
                          border: Border.all(
                              color: selectedPoints == point
                                  ? Color(0xFF6C7D47)
                                  : Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          point,
                          style: TextStyle(
                            fontSize: 18,
                            color: isSelectable
                                ? Colors.black
                                : Colors
                                    .grey, // Text color based on selectability
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 16),
                  Text(
                    'Pilih Metode penukaran',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  ...methods.map((method) => GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedMethod == method) {
                              selectedMethod =
                                  null; // Deselect if already selected
                            } else {
                              selectedMethod = method;
                            }
                          });
                        },
                        child: Container(
                          width: double.infinity, // Memastikan lebar penuh
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          margin: EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: selectedMethod == method
                                ? Color(0xFFD0E6A5)
                                : Colors
                                    .white, // Warna latar belakang saat dipilih
                            border: Border.all(
                                color: selectedMethod == method
                                    ? Color(0xFF6C7D47)
                                    : Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/${method.toLowerCase()}.png',
                                height: 32,
                              ),
                              SizedBox(width: 16),
                              Text(
                                method,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      )),
                  SizedBox(height: 16), // Add some space before the button
                  InkWell(
                    onTap: selectedPoints != null && selectedMethod != null
                        ? () async {
                            setState(() {
                              isButtonClicked = true;
                            });
                            await Provider.of<TukarUangViewModel>(context,
                                    listen: false)
                                .exchangePoints(
                                    int.parse(selectedPoints!
                                        .replaceAll(RegExp(r'\D'), '')),
                                    selectedMethod!);
                            Utils.showSuccessSnackBar(
                              Overlay.of(context),
                              "Penukaran Sedang Diproses",
                            );

                            setState(() {
                              isButtonClicked = false;
                              selectedPoints =
                                  null; // Reset selection after exchange
                              selectedMethod =
                                  null; // Reset selection after exchange
                            });
                          }
                        : null,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: selectedPoints != null && selectedMethod != null
                            ? (isButtonClicked
                                ? Colors.green[900]
                                : Color(
                                    0xFF6C7D47)) // Warna hijau pada tombol, lebih gelap saat diklik
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Tukar',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
