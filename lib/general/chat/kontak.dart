import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/account_controller.dart';
import 'package:marikost/app_service/controller/chat_controller.dart';

class KontakChat extends StatefulWidget {
  const KontakChat({super.key});

  @override
  State<KontakChat> createState() => _KontakChatState();
}

class _KontakChatState extends State<KontakChat> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  var user;

  final AkunController _akunController = Get.put(AkunController());
  final ChatController _chatController = Get.put(ChatController());

  @override
  void initState() {
    // TODO: implement initState
    _getUserData();
    super.initState();
  }

  void _getUserData() async {
    var data = await _akunController.getUserData();
    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFB82E),
          shadowColor: Colors.transparent,
          // title: const Text('Kontak'),
          automaticallyImplyLeading: false,
        ),
        body: user != null
            ? Column(
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
                        'Kontak',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: _chatController.getListChatContact(user['id']),
                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          return Column(
                            children: [
                              RefreshIndicator(
                                  onRefresh: () async {
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      setState(() {});
                                    });
                                  },
                                  key: _refreshKey,
                                  child: ListView.builder(
                                    itemCount: snapshot.data.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return FutureBuilder(
                                          future:
                                              _akunController.getOneUserAkun(
                                                  snapshot.data[index]
                                                      ['id_sender']),
                                          builder: (context, snapshot2) {
                                            var profile = snapshot2.data;
                                            if (snapshot2.hasData) {
                                              return Card(
                                                child: ListTile(
                                                  leading: CircleAvatar(
                                                    foregroundImage: profile[
                                                                'foto_profile'] !=
                                                            null
                                                        ? NetworkImage(
                                                            'https://api.marikost.com/storage/users/${profile['foto_profile']}')
                                                        : null,
                                                    child:
                                                        profile['foto_profile'] ==
                                                                null
                                                            ? const Icon(
                                                                Icons.person,
                                                                color: Colors
                                                                    .black,
                                                              )
                                                            : null,
                                                  ),
                                                  title: Text(profile['name']),
                                                  subtitle: Text(
                                                      profile['no_handphone']),
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context, '/chat',
                                                        arguments: {
                                                          "id_user": user['id'],
                                                          "user_name":
                                                              user['name'],
                                                          "id_sender":
                                                              profile['id'],
                                                          "sender_name":
                                                              profile['name'],
                                                          "sender_foto": profile[
                                                              'foto_profile'],
                                                        });
                                                  },
                                                ),
                                              );
                                            } else {
                                              return const Center(
                                                child: Text('Loading..'),
                                              );
                                            }
                                          });
                                    },
                                  )),
                            ],
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return const Center(
                              child: Text('Error: Terjadi kesalahan'));
                        }
                      },
                    ),
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator()));
  }
}
