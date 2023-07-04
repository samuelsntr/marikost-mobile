import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/notification_controller.dart';

class NotifikasiManajemen extends StatefulWidget {
  const NotifikasiManajemen({super.key});

  @override
  State<NotifikasiManajemen> createState() => _NotifikasiManajemenState();
}

class _NotifikasiManajemenState extends State<NotifikasiManajemen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicator =
      GlobalKey<RefreshIndicatorState>();
  final NotificationController _controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFB82E),
        shadowColor: Colors.transparent,
        // title: const Text('Kontak'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
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
                'Notifikasi',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: RefreshIndicator(
                key: _refreshIndicator,
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 2), () {
                    setState(() {});
                  });
                },
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future: _controller.getNotifikasiIdUser(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var data = snapshot.data[index];
                              return Card(
                                elevation: 2,
                                child: ListTile(
                                  leading: const CircleAvatar(
                                    backgroundColor: Colors.orange,
                                    radius: 30,
                                    child: Icon(
                                      Icons.notification_important,
                                      color: Colors.black,
                                    ),
                                  ),
                                  title: Text(data['judul']),
                                  subtitle: Container(
                                      width: 220,
                                      child: Text(
                                        data['pesan'],
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/manajemen/notif/details',
                                        arguments: data);
                                  },
                                ),
                              );
                            },
                            itemCount: snapshot.data.length);
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return const Center(
                            child: Text('tidak ada notifikasi!'));
                      }
                    },
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
