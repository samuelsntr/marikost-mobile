import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/kamar_controller.dart';

class ListKelolaKostKamar extends StatefulWidget {
  ListKelolaKostKamar({super.key, required this.idKost});

  var idKost;

  @override
  State<ListKelolaKostKamar> createState() => _ListKelolaKostKamarState();
}

class _ListKelolaKostKamarState extends State<ListKelolaKostKamar> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final KamarController _kamarController = Get.put(KamarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Kamar Kost'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: RefreshIndicator(
          key: _refreshKey,
          child: FutureBuilder(
            future: _kamarController.getListKamarIdKost(widget.idKost),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemBuilder: (context, index) {
                      var data = snapshot.data[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
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
                                        'https://api.marikost.com/storage/tampilan_kamar/${data['tampilan']['foto_kamar1']}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                              const SizedBox(width: 20),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['nama_kamar'],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        data['luas_kamar'],
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    '/kost/kamar/edit',
                                                    arguments: data['id']
                                                        .toString());
                                              },
                                              icon: const Icon(Icons.edit)),
                                          IconButton(
                                              onPressed: () {
                                                Get.dialog(AlertDialog(
                                                  title: const Text(
                                                      'Peringatan'),
                                                  content: const Text(
                                                      'Anda yakin hapus data ini?'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          _kamarController
                                                              .deleteKamarKost(
                                                                  data['id']);
                                                        },
                                                        child:
                                                            const Text('Ya')),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            'Tidak')),
                                                  ],
                                                ));
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ))
                                        ],
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );

                      // return Card(
                      //   elevation: 2,
                      //   child: ListTile(
                      //     leading: CircleAvatar(
                      //       backgroundImage: NetworkImage(
                      //           'https://api.marikost.com/storage/tampilan_kamar/${data['tampilan']['foto_kamar1']}'),
                      //     ),
                      //     title: Text(data['nama_kamar']),
                      //     subtitle: Text(data['luas_kamar']),
                      //     trailing: Chip(label: Text(data['status_kamar'])),
                      //     onTap: () {
                      //       Navigator.pushNamed(context, '/kost/kamar/edit',
                      //           arguments: data['id']);
                      //     },
                      //   ),
                      // );
                    },
                    itemCount: snapshot.data.length);
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(child: Text('Tidak ada data kamar'));
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/kost/kamar/add',
              arguments: widget.idKost);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
