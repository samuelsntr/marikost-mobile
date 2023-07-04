import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';

class RoomKostList extends StatefulWidget {
  const RoomKostList({super.key});

  @override
  State<RoomKostList> createState() => _RoomKostListState();
}

class _RoomKostListState extends State<RoomKostList> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final KostController kostController = Get.put(KostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Kamar Kost'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        child: FutureBuilder(
          future: kostController.getkelolaKost(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var data = snapshot.data[index];
                  return InkWell(
                    onTap: () {
                      if (data['aktivasi'] == '1') {
                        Navigator.pushNamed(context, '/kost/profile',
                            arguments: data['id']);
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              "Warning",
                            ),
                            content: const Text(
                              "Anda belum bisa kelola kost ini, karena belum teraktivasi!",
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Ok'))
                            ],
                          ),
                        );
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  width: 80,
                                  height: 90,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      'https://api.marikost.com/storage/kost/${data['foto_kost']}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),
                            const SizedBox(width: 20),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['nama_kost'],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Container(
                                      width: 170,
                                      child: Text(
                                        data['alamat_kost'],
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Align(
                              alignment: Alignment.topRight,
                              child: Chip(
                                // labelPadding: const EdgeInsets.symmetric(
                                //     vertical: -1, horizontal: 3),
                                label: Text(
                                  data['aktivasi'] == '1'
                                      ? 'Aktif'
                                      : 'Belum Aktif',
                                  style: TextStyle(
                                      color: data['aktivasi'] == '1'
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 10),
                                ),
                                backgroundColor: data['aktivasi'] == '1'
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text('Tidak ada data Kost!'),
              );
            }
          },
        ),
        onRefresh: () async {
          Future.delayed(
            const Duration(seconds: 2),
            () {
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
