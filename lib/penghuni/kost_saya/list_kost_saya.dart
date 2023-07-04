import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/penghuni_controller.dart';

class KostSaya extends StatefulWidget {
  const KostSaya({super.key});

  @override
  State<KostSaya> createState() => _KostSayaState();
}

class _KostSayaState extends State<KostSaya> {
  final PenghuniController _penghuniController = Get.put(PenghuniController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicator =
      GlobalKey<RefreshIndicatorState>();
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
                      'Kost Saya',
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
                future: _penghuniController.getUserPenghuni(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data[index];
                        var date = DateTime.now().millisecondsSinceEpoch;
                        var endDate =
                            DateTime.parse(data['batas_akhir_pembayaran'])
                                .millisecondsSinceEpoch;
                        if (date > endDate) {
                          return Container();
                        } else {
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              onTap: () => Navigator.pushNamed(
                                  context, '/kost_saya/details',
                                  arguments: data),
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://api.marikost.com/storage/kost/${data['kost']['foto_kost']}')),
                              title: Text(data['kost']['nama_kost']),
                              subtitle: Container(
                                width: 190,
                                child: Text(
                                  data['kost']['alamat_kost'],
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: Text('Anda Belum memilih kost'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
