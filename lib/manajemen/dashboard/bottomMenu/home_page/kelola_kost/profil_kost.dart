import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';

class ProfilKost extends StatefulWidget {
  const ProfilKost({super.key, required this.idKost});

  final idKost;

  @override
  State<ProfilKost> createState() => _ProfilKostState();
}

class _ProfilKostState extends State<ProfilKost> {
  final KostController _kostController = Get.put(KostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _kostController.getOneKelolaKost(widget.idKost),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            var profil = snapshot.data;
            return SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: const Color(0xFFFFB82E),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back)),
                          ),
                        ),
                        const Text(
                          'Profil Kost',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                    'https://api.marikost.com/storage/kost/${profil['foto_kost']}',
                                    width: 280,
                                    height: 160,
                                    fit: BoxFit.cover),
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text('Informasi Kost',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 20),
                        ListTile(
                          leading: const Icon(Icons.house, color: Colors.amber),
                          title: const Text('Nama Kost'),
                          subtitle: Text(profil['nama_kost']),
                        ),
                        ListTile(
                          leading: const Icon(Icons.group, color: Colors.amber),
                          title: const Text('Jenis Kost'),
                          subtitle: Text(profil['jenis_kost']),
                        ),
                        ListTile(
                          leading: const Icon(Icons.location_pin,
                              color: Colors.amber),
                          title: const Text('Alamat Kost'),
                          subtitle: Text(profil['alamat_kost']),
                        ),
                        ListTile(
                          leading: const Icon(Icons.check_circle,
                              color: Colors.amber),
                          title: const Text('Status Kost'),
                          subtitle: Text(profil['status_kost']),
                        ),
                        ListTile(
                          leading: const Icon(Icons.description,
                              color: Colors.amber),
                          title: const Text('Deskripsi'),
                          subtitle: Text(profil['deskripsi']),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            onPressed: () {
                              Navigator.pushNamed(context, '/kost/edit',
                                  arguments: profil['id']);
                            },
                            child: const Text('Edit Kost')),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            onPressed: () {
                              Navigator.pushNamed(context, '/request_iklan',
                                  arguments: profil['id']);
                            },
                            child: const Text('Ajukan Iklan Kost')),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            onPressed: () {
                              Navigator.pushNamed(context, '/kost/unit',
                                  arguments: profil['id']);
                            },
                            child: const Text('Kelola Unit Sekitar Kost')),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            onPressed: () {
                              Navigator.pushNamed(context, '/review_kost',
                                  arguments: profil['id']);
                            },
                            child: const Text('Review Kost')),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            onPressed: () {
                              Navigator.pushNamed(context, '/kost/kamar',
                                  arguments: profil['id']);
                            },
                            child: const Text('Kelola Kamar Kost')),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            onPressed: () {
                              Navigator.pushNamed(context, '/kost/peraturan',
                                  arguments: profil['id']);
                            },
                            child: const Text('Kelola Peraturan Kost')),
                        const SizedBox(height: 40),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.red),
                              onPressed: () {
                                Get.dialog(AlertDialog(
                                  title: const Text('Peringatan'),
                                  content: const Text(
                                      'Anda yakin hapus kost ini? data kost tidak bisa dikembalikan'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          _kostController
                                              .deletedKost(widget.idKost);
                                        },
                                        child: const Text('Ya')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Tidak')),
                                  ],
                                ));
                              },
                              child: const Text('Hapus Kost')),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('Tidak ada data ditemukan!'));
          }
        },
      ),
    );
  }
}
