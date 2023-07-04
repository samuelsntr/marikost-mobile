import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marikost/penghuni/cari_kost/dashboard_pencari.dart';
import 'package:marikost/penghuni/cari_kost/not_login/login_kost_saya.dart';
import 'package:marikost/penghuni/cari_kost/not_login/login_notifikasi.dart';
import 'package:marikost/penghuni/cari_kost/not_login/login_pesan.dart';
import 'package:marikost/penghuni/login_penghuni/login_register_penghuni.dart';

class PencariKost extends StatefulWidget {
  const PencariKost({super.key});

  @override
  State<PencariKost> createState() => _PencariKostState();
}

class _PencariKostState extends State<PencariKost> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listPage.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Cari'),
          BottomNavigationBarItem(
              icon: Icon(Icons.apartment), label: 'Kost Saya'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_rounded), label: 'Pesan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifikasi'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: _currentIndex,
        onTap: _onTappedBottomNavbar,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange,
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  final List _listPage = [
    const DashboardPencariKost(),
    const NotLoginPencari(),
    const LoginPencariPesan(),
    const LoginPencariNotifikasi(),
    const LoginRegisterPenghuni(selectedPage: 1)
  ];

  void _onTappedBottomNavbar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
