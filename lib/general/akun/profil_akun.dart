import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marikost/app_service/controller/account_controller.dart';

class ProfilAkun extends StatefulWidget {
  const ProfilAkun({super.key, required this.idUser});

  final idUser;
  @override
  State<ProfilAkun> createState() => _ProfilAkunState();
}

class _ProfilAkunState extends State<ProfilAkun> {
  final AkunController _akunController = Get.put(AkunController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFB82E),
        title: const Text('Profil Akun'),
        shadowColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _akunController.getOneUserAkun(widget.idUser),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            var profil = snapshot.data;
            var date = DateTime.parse(profil['created_at']);
            var formatDate =
                DateFormat('EEEE, dd MMMM y', 'id_ID').format(date);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: const Color(0xFFFFB82E),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          foregroundImage: profil['foto_profile'] != null
                              ? NetworkImage(
                                  'https://api.marikost.com/storage/users/${profil['foto_profile']}')
                              : null,
                          foregroundColor: profil['foto_profile'] != null
                              ? Colors.transparent
                              : Colors.black,
                          radius: 50,
                          child: profil['foto_profil'] == null
                              ? const Icon(
                                  Icons.person,
                                  size: 50,
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Informasi Akun',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          ListTile(
                            leading:
                                const Icon(Icons.person, color: Colors.amber),
                            title: const Text('Nama'),
                            subtitle: Text(profil['name']),
                          ),
                          ListTile(
                            leading: Icon(
                                profil['jenis_kelamin'] == 'Perempuan'
                                    ? Icons.female
                                    : Icons.male,
                                color: Colors.amber),
                            title: const Text('Jenis_kelamin'),
                            subtitle: Text(profil['jenis_kelamin'].toString()),
                          ),
                          ListTile(
                            leading:
                                const Icon(Icons.mail, color: Colors.amber),
                            title: const Text('Email'),
                            subtitle: Text(profil['email']),
                          ),
                          ListTile(
                            leading:
                                const Icon(Icons.phone, color: Colors.amber),
                            title: const Text('No. Telepon'),
                            subtitle: Text(profil['no_handphone']),
                          ),
                          if (profil['no_ktp'] != null)
                            ListTile(
                              leading:
                                  const Icon(Icons.badge, color: Colors.amber),
                              title: const Text('No. KTP'),
                              subtitle: Text(profil['no_ktp']),
                            ),
                          if (profil['nama_bank'] != null)
                            ListTile(
                              leading: const Icon(Icons.account_balance,
                                  color: Colors.amber),
                              title: const Text('nama_bank'),
                              subtitle: Text(profil['nama_bank']),
                            ),
                          ListTile(
                            leading: const Icon(Icons.calendar_month,
                                color: Colors.amber),
                            title: const Text('Akun Dibuat'),
                            subtitle: Text(formatDate.toString()),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40))),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/akun/profile/edit',
                                    arguments: profil);
                              },
                              child: const Text('Edit Profil')),
                          const SizedBox(height: 40),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.red),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Warning!'),
                                      content: const Text(
                                        'Apakah anda yakin tutup akun ini? \n\nAnda tidak bisa kembali log in dengan akun ini',
                                        textAlign: TextAlign.center,
                                      ),
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              const storage =
                                                  FlutterSecureStorage();
                                              await storage.delete(key: 'user');
                                              // ignore: use_build_context_synchronously
                                              _akunController
                                                  .deleteAccount(profil['id']);
                                            },
                                            child: const Text(
                                                'Ya, Tutup Akun Ini')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Tidak'))
                                      ],
                                    ),
                                  );
                                },
                                child: const Text('Tutup Akun')),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(child: Text('Error: data not found'));
          }
        },
      ),
    );
  }
}
