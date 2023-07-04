import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/notification_controller.dart';

class NotifikasiPenghuni extends StatefulWidget {
  const NotifikasiPenghuni({super.key});

  @override
  State<NotifikasiPenghuni> createState() => _NotifikasiPenghuniState();
}

class _NotifikasiPenghuniState extends State<NotifikasiPenghuni> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicator =
      GlobalKey<RefreshIndicatorState>();
  final NotificationController _controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          key: _refreshIndicator,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2), () {
              setState(() {});
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: const Color(0xFFFFB82E),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back)),
                        )),
                    const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        'Notifikasi',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: _controller.getNotifikasiIdUser(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var data = snapshot.data[index];
                            return Card(
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
                                      context, '/penghuni/notif/details',
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
                      return const Center(child: Text('tidak ada notifikasi!'));
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }
}
