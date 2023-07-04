import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoginPencariPesan extends StatefulWidget {
  const LoginPencariPesan({super.key});

  @override
  State<LoginPencariPesan> createState() => _LoginPencariPesanState();
}

class _LoginPencariPesanState extends State<LoginPencariPesan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/marikost_logo.png',
                width: 140,
              ),
              const Text(
                'Marikost menunggu kamu untuk bergabung',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Text(
                'Yuk bergabung dengan aplikasi Marikost, agar kamu bisa kirim pesan',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login_penghuni');
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  child: const Text('Login / Daftar')),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
