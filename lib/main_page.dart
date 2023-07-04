import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/account_controller.dart';
import 'package:marikost/main.dart';
import 'package:marikost/manajemen/dashboard/dashboard_page.dart';
import 'package:marikost/penghuni/dashboard_penghuni.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final AkunController _controller = Get.put(AkunController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _controller.getUserData(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            switch (snapshot.data['role']) {
              case "2":
                return const DashboardManajemenKost();
              case "3":
                return const DashboardPenghuni();
              default:
                return mainMenu(context);
            }
          } else {
            return mainMenu(context);
          }
        },
      ),
    );
  }

  SingleChildScrollView mainMenu(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 200,
              ),
              Image.asset('assets/images/marikost_logo.png'),
              const SizedBox(
                height: 200,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login_manajemen');
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  child: const Text('Manajemen Kost')),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/dashboard_pencari');
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  child: const Text('Cari Kost & Jasa')),
            ],
          ),
        ),
      ),
    );
  }
}
