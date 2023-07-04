import 'package:flutter/material.dart';
import 'package:marikost/general/akun/akun.dart';
import 'package:marikost/general/chat/kontak.dart';
import 'package:marikost/penghuni/home.dart';
import 'package:marikost/penghuni/kost_saya/list_kost_saya.dart';
import 'package:marikost/penghuni/notifikasi/notifikasi_penghuni.dart';

class DashboardPenghuni extends StatefulWidget {
  const DashboardPenghuni({super.key});

  @override
  State<DashboardPenghuni> createState() => _DashboardPenghuniState();
}

class _DashboardPenghuniState extends State<DashboardPenghuni> {
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
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Cari'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apartment), label: 'Kost Saya'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_rounded), label: 'Pesan'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: 'Notifikasi'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profil'),
            ]),
      ),
    );
  }

  final List _listPage = [
    const HomeSearchKost(),
    const KostSaya(),
    const KontakChat(),
    const NotifikasiPenghuni(),
    const AkunPengguna(),
  ];

  void _onTappedBottomNavbar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
