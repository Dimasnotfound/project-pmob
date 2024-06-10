import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pmob_project/view/users/jadwal_penjemputan/jadwal_penjemputan.dart';
import 'package:pmob_project/view/users/jenis_sampah/jenis_sampah.dart';
import 'package:pmob_project/view/users/tukar_poin/tukar_poin.dart';
import 'dashboard_user.dart';

class NavbarUser extends StatefulWidget {
  const NavbarUser({super.key});

  @override
  State<NavbarUser> createState() => _NavbarUserState();
}

class _NavbarUserState extends State<NavbarUser> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [DashboardUser(), JenisSampah(), JadwalPenjemputan(), TukarPoin()];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(0.1),
            )
          ],
        ),
        child: SafeArea(
          child: GNav(
            gap: 8,
            activeColor: Colors.white,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            duration: Duration(milliseconds: 800),
            tabBackgroundColor: Colors.grey[800]!,
            color: Colors.black,
            tabs: const [
              GButton(
                icon: Icons.home,
              ),
              GButton(
                icon: Icons.delete,
              ),
              GButton(
                icon: Icons.local_shipping,
              ),
              GButton(
                icon: Icons.monetization_on,
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
          ),
        ),
      ),
    );
  }
}

class HapusState extends StatelessWidget {
  const HapusState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Hapus'),
    );
  }
}

class PengantaranState extends StatelessWidget {
  const PengantaranState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Hapus'),
    );
  }
}

class MoneyState extends StatelessWidget {
  const MoneyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Hapus'),
    );
  }
}
