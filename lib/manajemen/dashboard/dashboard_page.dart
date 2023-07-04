import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marikost/general/akun/akun.dart';
import 'package:marikost/general/chat/kontak.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/home_page/home_page.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/manajemen/management_page.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/notifikasi/notifikasi_manajemen.dart';
import 'package:marikost/manajemen/login/login_register.dart';

class DashboardManajemenKost extends StatefulWidget {
  const DashboardManajemenKost({super.key});

  @override
  State<DashboardManajemenKost> createState() => _DashboardManajemenKostState();
}

class _DashboardManajemenKostState extends State<DashboardManajemenKost> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
        } else {
          return true;
        }
        return false;
      },
      child: Scaffold(
          body: _listPage.elementAt(_currentIndex),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onTappedBottomNavbar,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.orange,
              unselectedIconTheme: const IconThemeData(color: Colors.grey),
              showUnselectedLabels: true,
              showSelectedLabels: true,
              unselectedItemColor: Colors.grey,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Beranda'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.article), label: 'Kelola'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_rounded), label: 'Pesan'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications), label: 'Notifikasi'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Akun'),
              ])),
    );
  }

  final List _listPage = [
    const HomeManajemenKost(),
    const ManagementPageKost(),
    const KontakChat(),
    const NotifikasiManajemen(),
    const AkunPengguna(),
  ];

  void _onTappedBottomNavbar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
