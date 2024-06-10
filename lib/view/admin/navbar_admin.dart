import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:trash_solver/view/admin/crud_jadwalpenjemputan/jadwalpenjemputan_admin.dart';
import 'dashboard_admin.dart';
import 'crud_artikel/artikel_admin.dart';
import 'crud_daurulang/jenisdaurulang_admin.dart';
import 'penukaranuang_admin.dart';

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
          _pageController.jumpToPage(3);
        },
        navigateToArtikel: () {
          _pageController.jumpToPage(2);
        },
        navigateToDaurUlang: () {
          _pageController.jumpToPage(1);
        },
        navigateToPenukaranUang: () {
          _pageController.jumpToPage(4);
        },
      ),
      JenisdaurulangAdmin(),
      ArtikelAdmin(),
      JadwalpenjemputanAdmin(),
      PenukaranuangAdmin(),
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
            tabs: [
              GButton(
                icon: Icons.home,
              ),
              GButton(
                icon: Icons.delete,
              ),
              GButton(
                icon: Icons.article,
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
