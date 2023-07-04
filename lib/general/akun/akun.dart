import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/account_controller.dart';

class AkunPengguna extends StatefulWidget {
  const AkunPengguna({super.key});

  @override
  State<AkunPengguna> createState() => _AkunPengguna();
}

class _AkunPengguna extends State<AkunPengguna> {
  var user;

  @override
  void initState() {
    // TODO: implement initState
    _getUserData();
    super.initState();
  }

  _getUserData() async {
    const storage = FlutterSecureStorage();
    final String? getUser = await storage.read(key: 'user');
    var convert = await jsonDecode(getUser!);
    setState(() {
      user = convert;
    });
  }

  final AkunController _akunController = Get.put(AkunController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        Container(
          height: 180,
          decoration: const BoxDecoration(
              color: const Color(0xFFFFB82E),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Container(
            margin: const EdgeInsets.all(20),
            child: FutureBuilder(
                future: _akunController.getUserData(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    var profile = snapshot.data;
                    return Center(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          foregroundImage: profile['foto_profile'] != null
                              ? NetworkImage(
                                  'https://api.marikost.com/storage/users/${profile['foto_profile']}')
                              : null,
                          child: profile['foto_profile'] == null
                              ? const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                )
                              : null,
                        ),
                        title: Text(
                          '${profile['name']}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.red,
                          child: Text('U'),
                        ),
                        title: Text(
                          'Loading..',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }
                }),
          ),
        ),
        user != null
            ? ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Colors.amber,
                    ),
                    contentPadding: const EdgeInsets.only(left: 58),
                    onTap: () {
                      Navigator.pushNamed(context, '/akun/profile',
                          arguments: user['id']);
                    },
                    title: const Text('Akun',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip, color: Colors.amber),
                    contentPadding: const EdgeInsets.only(left: 58),
                    onTap: () {
                      Navigator.pushNamed(context, '/terms_privacy');
                    },
                    title: const Text('Privasi',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const Divider(),
                  if (user['role'] == '2')
                    Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.download,
                            color: Colors.amber,
                          ),
                          contentPadding: const EdgeInsets.only(left: 58),
                          onTap: () {},
                          title: const Text('Keep',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        const Divider(),
                      ],
                    ),
                  if (user['role'] == '3')
                    Column(
                      children: [
                        ListTile(
                          leading:
                              const Icon(Icons.favorite, color: Colors.amber),
                          contentPadding: const EdgeInsets.only(left: 58),
                          onTap: () {},
                          title: const Text('Whistlist',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        const Divider(),
                      ],
                    ),
                  if (user['role'] == '2')
                    Column(children: [
                      ListTile(
                        leading: const Icon(Icons.star, color: Colors.amber),
                        contentPadding: const EdgeInsets.only(left: 58),
                        onTap: () {
                          Navigator.pushNamed(context, '/review_app',
                              arguments: user['id']);
                        },
                        title: const Text('Rate Our App',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      const Divider(),
                    ]),
                  ListTile(
                    leading: const Icon(Icons.help, color: Colors.amber),
                    contentPadding: const EdgeInsets.only(left: 58),
                    onTap: () {
                      Navigator.pushNamed(context, '/mariHelp');
                    },
                    title: const Text('MariHelp',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.amber),
                    contentPadding: const EdgeInsets.only(left: 58),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Warning!'),
                                content: const Text(
                                    'Apakah anda yakin logout dari akun ini?'),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        const storage = FlutterSecureStorage();
                                        await storage.delete(key: 'user');
                                        // ignore: use_build_context_synchronously
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/main_page',
                                            (route) => false);
                                      },
                                      child: const Text('Ya')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Tidak'))
                                ],
                              ));
                    },
                    title: const Text('Logout',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const Divider(),
                ],
              )
            : const CircularProgressIndicator()
      ]),
    );
  }
}
