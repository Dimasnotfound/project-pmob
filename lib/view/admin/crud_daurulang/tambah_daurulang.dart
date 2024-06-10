import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trash_solver/viewmodel/tambahdaurulang_viewmodel.dart';

class TambahDaurulang extends StatelessWidget {
  const TambahDaurulang({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TambahDaurulangViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Jenis Daur Ulang',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: viewModel.nameController,
              decoration: InputDecoration(
                labelText: 'Masukkan Nama Jenis Sampah',
                suffixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              height: 200,
              child: TextField(
                controller: viewModel.descriptionController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  labelText: 'Masukkan Deskripsi Jenis Sampah',
                  suffixIcon: Icon(Icons.edit),
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: viewModel.pickImage,
                  child: Text('Choose File'),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    viewModel.image == null
                        ? 'No File Chosen'
                        : viewModel.image!.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: () => viewModel.saveData(context),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  ),
                  child: Text(
                    'Tambah',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  ),
                  child: Text(
                    'Batal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
