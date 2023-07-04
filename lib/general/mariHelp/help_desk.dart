import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HelpDesk extends StatelessWidget {
  const HelpDesk({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pusat Bantuan'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Anda dapat mengorganisir informasi berdasarkan kategori yang sesuai dengan jenis akun di bawah ini:'),
              const SizedBox(height: 10),
              OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text('Pemilik Kost')),
              const SizedBox(height: 10),
              OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text('Penghuni Kost')),
              const SizedBox(height: 20),
              const Text(
                'Paling sering ditanyakan',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              const Text('Saya lupa password, apa yang harus saya lakukan?'),
              InkWell(
                  onTap: () {},
                  child: const Text(
                    'Selengkapnya',
                    style: TextStyle(color: Color(0xFFFFB82E)),
                  )),
              const SizedBox(height: 20),
              const Text(
                  'Bagaimana caranya mengganti email di akun penghuni kost?'),
              InkWell(
                  onTap: () {},
                  child: const Text(
                    'Selengkapnya',
                    style: TextStyle(color: Color(0xFFFFB82E)),
                  )),
              const SizedBox(height: 20),
              const Text('Kebijakan privasi Marikost'),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/terms_privacy');
                  },
                  child: const Text(
                    'Selengkapnya',
                    style: TextStyle(color: Color(0xFFFFB82E)),
                  )),
              const SizedBox(height: 20),
              const Text('Syarat dan ketentuan umum Marikost'),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/terms_privacy');
                  },
                  child: const Text(
                    'Selengkapnya',
                    style: TextStyle(color: Color(0xFFFFB82E)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
