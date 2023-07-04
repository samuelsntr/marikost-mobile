import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/account_controller.dart';
import 'package:marikost/app_service/controller/kamar_controller.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';

class ManagementPageKost extends StatefulWidget {
  const ManagementPageKost({super.key});

  @override
  State<ManagementPageKost> createState() => _ManagementPageKostState();
}

class _ManagementPageKostState extends State<ManagementPageKost> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicator =
      GlobalKey<RefreshIndicatorState>();
  final AkunController _akunController = Get.put(AkunController());
  final KostController _kostController = Get.put(KostController());
  final KamarController _kamarController = Get.put(KamarController());
  var dataUser = null;

  @override
  void initState() {
    // TODO: implement initState
    _getdataUser();
    super.initState();
  }

  void _getdataUser() async {
    var user = await _akunController.getUserData();
    setState(() {
      dataUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicator,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2), () {
          setState(() {});
        });
      },
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: const Text('Kelola Kost'),
            expandedHeight: 200,
            flexibleSpace: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Image.asset(
                  'assets/images/marikost_bg_kelola.jpg',
                  fit: BoxFit.cover,
                )),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: FutureBuilder(
                    future: _akunController.getUserData(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                            child: Text(
                          'Halo, ${snapshot.data['name']}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ));
                      } else {
                        return const Center(
                            child: Text(
                          'Profile',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ));
                      }
                    })),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                FutureBuilder(
                    future: _kamarController.getKamarByIdPemilik(
                        dataUser != null ? dataUser['id'] : 2),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var kamar = snapshot.data[index];
                              var statusBayar;
                              // var endDate = DateTime.parse(
                              //     kamar['penghuni']['batas_akhir_pembayaran']);
                              // var daysbefore = DateTime(endDate.year,
                              //     endDate.month, endDate.day - 10);
                              // var today = DateTime.now();
                              // if (today.isAfter(endDate)) {
                              //   statusBayar = '4';
                              // } else if (today == endDate) {
                              //   statusBayar = '3';
                              // } else if (today.isAfter(daysbefore) !=
                              //     today.isAfter(endDate)) {
                              //   statusBayar = '2';
                              // } else {
                              //   statusBayar = '1';
                              // }
                              return Card(
                                elevation: 2,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/manajemen/kamar',
                                        arguments: kamar['id']);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                              width: 80,
                                              height: 90,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.network(
                                                    'https://api.marikost.com/storage/tampilan_kamar/${kamar['tampilan'][0]['foto_kamar1']}',
                                                    fit: BoxFit.cover,
                                                  )),
                                            )),
                                        const SizedBox(width: 20),
                                        Expanded(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  kamar['nama_kamar'],
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(
                                                  kamar['kost']['nama_kost'],
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  kamar['penghuni'] != null
                                                      ? statusBayar == '1'
                                                          ? 'Lunas'
                                                          : statusBayar == '2'
                                                              ? 'Belum Lunas'
                                                              : statusBayar ==
                                                                      '3'
                                                                  ? 'Bayar Sekarang'
                                                                  : 'Nunggak'
                                                      : "belum ada penghuni",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: statusBayar == '4'
                                                          ? Colors.red
                                                          : Colors.black),
                                                ),
                                              ],
                                            )),
                                        Chip(
                                          label: Text(
                                              kamar['status_kamar'] == '1'
                                                  ? 'Tersedia'
                                                  : 'Ditempati',
                                              style: TextStyle(
                                                color:
                                                    kamar['status_kamar'] == '1'
                                                        ? Colors.white
                                                        : Colors.black,
                                              )),
                                          backgroundColor:
                                              kamar['status_kamar'] == '1'
                                                  ? Colors.green
                                                  : Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                              //   return ListTile(
                              //     onTap: () {
                              //       Navigator.pushNamed(
                              //           context, '/manajemen/kamar',
                              //           arguments: kamar['id']);
                              //     },
                              //     leading: CircleAvatar(
                              //       backgroundImage: NetworkImage(
                              //           'https://api.marikost.com/storage/tampilan_kamar/${kamar['tampilan']['foto_kamar1']}'),
                              //     ),
                              //     title: Text('${kamar['nama_kamar']}'),
                              //     subtitle: const Text('No User'),
                              //     trailing: Chip(
                              //       label: Text('${kamar['status_kamar']}',
                              //           style: TextStyle(
                              //             color:
                              //                 kamar['status_kamar'] == 'Tersedia'
                              //                     ? Colors.white
                              //                     : Colors.black,
                              //           )),
                              //       backgroundColor:
                              //           kamar['status_kamar'] == 'Tersedia'
                              //               ? Colors.green
                              //               : Colors.grey,
                              //     ),
                              //   );
                            },
                            itemCount: snapshot.data.length);
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: Text('Loading..'));
                      } else {
                        return const Center(
                            child: Text('Tidak ada data kamar!'));
                      }
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
