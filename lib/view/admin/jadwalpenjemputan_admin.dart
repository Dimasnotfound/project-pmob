import 'package:flutter/material.dart';

class JadwalpenjemputanAdmin extends StatefulWidget {
  const JadwalpenjemputanAdmin({super.key});

  @override
  State<JadwalpenjemputanAdmin> createState() => _JadwalpenjemputanAdminState();
}

class _JadwalpenjemputanAdminState extends State<JadwalpenjemputanAdmin> {
  final List<Schedule> schedules = [
    Schedule(day: 'Hari Senin', slots: [
      PickupSlot(time: '07:50 - 08:50', location: 'Jl. Jawa'),
      PickupSlot(time: '11:20 - 12:20', location: 'Jl. Ahmad Yani'),
      PickupSlot(time: '15:00 - 16:50', location: 'Jl. Kaliurang'),
    ]),
    Schedule(day: 'Hari Selasa', slots: [
      PickupSlot(time: '07:50 - 08:50', location: 'Jl. Kaliurang'),
      PickupSlot(time: '11:20 - 12:20', location: 'Jl. Kalimantan 5'),
      PickupSlot(time: '15:00 - 16:50', location: 'Jl. Riau'),
    ]),
    Schedule(day: 'Hari Rabu', slots: [
      PickupSlot(time: '07:50 - 08:50', location: 'Jl. Riau'),
      PickupSlot(time: '11:20 - 12:20', location: 'Jl. Karimata'),
      PickupSlot(time: '15:00 - 16:50', location: 'Jl. Dhoho'),
    ]),
    Schedule(day: 'Hari Kamis', slots: [
      PickupSlot(time: '07:50 - 08:50', location: 'Jl. Dhoho'),
      PickupSlot(time: '11:20 - 12:20', location: 'Jl. Soedirman'),
      PickupSlot(time: '15:00 - 16:50', location: 'Jl. Mastrip'),
    ]),
    Schedule(day: 'Hari Jumat', slots: [
      PickupSlot(time: '07:50 - 08:50', location: 'Jl. Mastrip'),
      PickupSlot(time: '11:20 - 12:20', location: 'Jl. Sumatra'),
      PickupSlot(time: '15:00 - 16:50', location: 'Jl. Nias'),
    ]),
    Schedule(day: 'Hari Sabtu', slots: [
      PickupSlot(time: '07:50 - 08:50', location: 'Jl. Nias'),
      PickupSlot(time: '11:20 - 12:20', location: 'Jl. Semeru'),
      PickupSlot(time: '15:00 - 16:50', location: 'Jl. Jawa'),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF77B6FF), // Custom blue background
        automaticallyImplyLeading: false,
        title: Text(
          'Jadwal Penjemputan',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final schedule = schedules[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _getColorForDay(schedule.day),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          schedule.day,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Edit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: schedule.slots.map((slot) {
                      return ListTile(
                        title: Text(slot.time),
                        subtitle: Text(slot.location),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getColorForDay(String day) {
    switch (day) {
      case 'Hari Senin':
        return Colors.yellow[700]!;
      case 'Hari Selasa':
        return Colors.green[400]!;
      case 'Hari Rabu':
        return Colors.blue[400]!;
      case 'Hari Kamis':
        return Colors.orange[400]!;
      case 'Hari Jumat':
        return Colors.purple[400]!;
      case 'Hari Sabtu':
        return Colors.red[400]!;
      default:
        return Colors.grey;
    }
  }
}

class Schedule {
  final String day;
  final List<PickupSlot> slots;

  Schedule({required this.day, required this.slots});
}

class PickupSlot {
  final String time;
  final String location;

  PickupSlot({required this.time, required this.location});
}
