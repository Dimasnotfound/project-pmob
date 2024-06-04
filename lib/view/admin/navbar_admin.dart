import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pmob_project/view/admin/jadwalpenjemputan_admin.dart';
import 'dashboard_admin.dart';

class NavbarAdmin extends StatefulWidget {
  const NavbarAdmin({Key? key}) : super(key: key);

  @override
  State<NavbarAdmin> createState() => _NavbarAdminState();
}

class _NavbarAdminState extends State<NavbarAdmin> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      DashboardAdmin(
        navigateToJadwalPenjemputan: () {
          _pageController.jumpToPage(2);
        },
      ),
      DeleteScreen(),
      JadwalpenjemputanAdmin(),
      PointExchangeScreen(),
    ];
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
            tabs: [
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

class DeleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Delete Screen'));
  }
}

class ShippingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Shipping Screen'));
  }
}

class PointExchangeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Point Exchange Screen'));
  }
}
