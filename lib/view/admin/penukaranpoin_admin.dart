import 'package:flutter/material.dart';

class PenukaranPoinAdmin extends StatefulWidget {
  const PenukaranPoinAdmin({super.key});

  @override
  State<PenukaranPoinAdmin> createState() => _PenukaranPoinAdminState();
}

class _PenukaranPoinAdminState extends State<PenukaranPoinAdmin> {
  bool _isNotificationVisible = true;

  void _hideNotification() {
    setState(() {
      _isNotificationVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Add the functionality to go back to the previous screen
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
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter, // Align the box to the top center
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 16.0), // Add some padding to the top
              child: _isNotificationVisible
                  ? Container(
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
                          Text('Sampah Jenis a        20 kg'),
                          Text('Sampah Jenis b        40 kg'),
                          SizedBox(height: 8.0),
                          Text(
                            'Poin ditukar: 10000 poin',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: _hideNotification,
                                child: Text(
                                  'Tolak',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              TextButton(
                                onPressed: _hideNotification,
                                child: Text(
                                  'Konfirmasi',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  : Text(
                      'No notifications',
                      style: TextStyle(fontSize: 18),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
