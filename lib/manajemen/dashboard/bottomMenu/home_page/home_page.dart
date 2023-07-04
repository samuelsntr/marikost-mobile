import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/account_controller.dart';

class HomeManajemenKost extends StatefulWidget {
  const HomeManajemenKost({super.key});

  @override
  State<HomeManajemenKost> createState() => _HomeManajemenKostState();
}

class _HomeManajemenKostState extends State<HomeManajemenKost> {
  final AkunController _akunController = Get.put(AkunController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFFFB82E),
        shadowColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: FutureBuilder(
              future: _akunController.getUserData(),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  var user = snapshot.data;
                  return CircleAvatar(
                    foregroundImage: user['foto_profile'] != null
                        ? NetworkImage(
                            'https://api.marikost.com/storage/users/${user['foto_profile']}')
                        : null,
                    child: user['foto_profile'] == null
                        ? const Icon(
                            Icons.person,
                            color: Colors.black,
                          )
                        : null,
                  );
                } else {
                  return const CircleAvatar(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.orange,
                    child: Text('U'),
                  );
                }
              },
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: const Color(0xFFFFB82E),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'Home Manajemen',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Waktunya mengelola kost di Marikost',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                  const Text(
                      'Maksimalkan potensi properti dan kost anda dengan memanajemen kost di Marikost.'),
                  const SizedBox(height: 30),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/kost/add');
                      },
                      leading: const CircleAvatar(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.black,
                        child: Icon(Icons.add),
                      ),
                      title: const Text('Tambah Kost'),
                      subtitle: const Text('Buat kost anda'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/kost_list');
                      },
                      leading: const CircleAvatar(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.black,
                        child: Icon(Icons.night_shelter),
                      ),
                      title: const Text('Kelola kost/Kamar'),
                      subtitle:
                          const Text('Kelola data kost dan kamar kost anda'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/mariHelp');
                      },
                      leading: const CircleAvatar(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.black,
                        child: Icon(Icons.headset_mic),
                      ),
                      title: const Text('Pusat Bantuan'),
                      subtitle: const Text('Info bantuan seputar Marikost'),
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
