import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marikost/app_service/controller/chat_controller.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';
import 'package:marikost/app_service/controller/penghuni_controller.dart';

class DetailKostSaya extends StatefulWidget {
  const DetailKostSaya({super.key, required this.info});

  final info;

  @override
  State<DetailKostSaya> createState() => _DetailKostSayaState();
}

class _DetailKostSayaState extends State<DetailKostSaya> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final PenghuniController _penghuniController = Get.put(PenghuniController());
  final KostController _kostController = Get.put(KostController());
  final ChatController _chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Kost Saya'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: () async {
          Future.delayed(
            const Duration(seconds: 2),
            () {
              setState(() {});
            },
          );
        },
        child: SingleChildScrollView(
            child: FutureBuilder(
          future: _penghuniController.getOnePenghuni(widget.info['id']),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data;
              var statusBayar = '0';
              var price = (data['kamar']['harga_kamar']);
              var priceElectric = (data['kamar']['biaya_listrik']);
              var priceWater = (data['kamar']['biaya_air']);
              var priceTrash = (data['kamar']['biaya_sampah']);
              var currency = NumberFormat.simpleCurrency(
                  locale: 'id_ID', decimalDigits: 0);
              var endDate = DateTime.parse(data['batas_akhir_pembayaran']);
              var daysbefore =
                  DateTime(endDate.year, endDate.month, endDate.day - 10);
              var today = DateTime.now();
              if (today.isAfter(endDate)) {
                statusBayar = '4';
              } else if (today == endDate) {
                statusBayar = '3';
              } else if (today.isAfter(daysbefore) != today.isAfter(endDate)) {
                statusBayar = '2';
              } else {
                statusBayar = '1';
              }
              return Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x54000000),
                            spreadRadius: 4,
                            blurRadius: 20,
                          ),
                        ]),
                    margin: const EdgeInsets.only(right: 20),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20)),
                      child: SizedBox.fromSize(
                        child: Image.network(
                            'https://api.marikost.com/storage/kost/${data['kost']['foto_kost']}'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Informasi Kost',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Divider(),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.home, color: Colors.amber),
                          title: const Text('Nama Kost'),
                          subtitle: Text(data['kost']['nama_kost']),
                        ),
                        ListTile(
                          leading:
                              const Icon(Icons.person, color: Colors.amber),
                          title: const Text('Nama Pemilik Kost'),
                          subtitle: Text(data['pemilik']['name']),
                        ),
                        ListTile(
                          leading: const Icon(Icons.location_pin,
                              color: Colors.amber),
                          title: const Text('Alamat Kost'),
                          subtitle: Text(data['kost']['alamat_kost']),
                        ),
                        ListTile(
                          leading:
                              const Icon(Icons.home_work, color: Colors.amber),
                          title: const Text('Jenis Kost'),
                          subtitle: Text(data['kost']['jenis_kost'] == '1'
                              ? 'Kost Campuran'
                              : data['kost']['jenis_kost'] == '2'
                                  ? 'Kost Putra'
                                  : 'Kost Perempuan'),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Informasi Kamar',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        ListTile(
                          leading: const Icon(Icons.door_front_door,
                              color: Colors.amber),
                          title: const Text('Nama Kamar'),
                          subtitle: Text(data['kamar']['nama_kamar']),
                        ),
                        ListTile(
                          leading:
                              const Icon(Icons.straighten, color: Colors.amber),
                          title: const Text('Luas Kamar'),
                          subtitle: Text(data['kamar']['luas_kamar']),
                        ),
                        ListTile(
                          leading: const Icon(Icons.house, color: Colors.amber),
                          title: const Text('Biaya Kamar'),
                          subtitle: Text('${currency.format(price)} / Bulan'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.electric_bolt,
                              color: Colors.amber),
                          title: const Text('Biaya Listrik'),
                          subtitle:
                              Text('${currency.format(priceElectric)} / Bulan'),
                        ),
                        ListTile(
                          leading:
                              const Icon(Icons.water_drop, color: Colors.amber),
                          title: const Text('Biaya Air'),
                          subtitle:
                              Text('${currency.format(priceWater)} / Bulan'),
                        ),
                        ListTile(
                          leading:
                              const Icon(Icons.delete, color: Colors.amber),
                          title: const Text('Biaya Sampah'),
                          subtitle:
                              Text('${currency.format(priceTrash)} / Bulan'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.paid, color: Colors.amber),
                          title: const Text('Total Biaya'),
                          subtitle: Text(
                              '${currency.format(price + priceElectric + priceWater + priceTrash)} / Bulan'),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Peraturan kost',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        FutureBuilder(
                          future:
                              _kostController.getPeraturan(data['kost']['id']),
                          builder: (context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              if (snapshot.data.length > 0) {
                                return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var rule = snapshot.data[index];
                                    return Text(
                                        '${index + 1}. ${rule['aturan']}',
                                        style: const TextStyle(
                                            color: Colors.black));
                                  },
                                );
                              } else {
                                return const Center(
                                    child: Text('Belum ada peraturan kost'));
                              }
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              return const Center(
                                  child: Text('Error: terjadi kesalahan'));
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Informasi Lainnya',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        ListTile(
                          leading: const Icon(Icons.calendar_month,
                              color: Colors.amber),
                          title: const Text('Tanggal Mulai Kost'),
                          subtitle: Text(data['tanggal_mulai_kost']),
                        ),
                        ListTile(
                          leading: const Icon(Icons.calendar_month,
                              color: Colors.amber),
                          title: const Text('Batas Pembayaran Kost'),
                          subtitle: Text(data['batas_akhir_pembayaran']),
                          trailing: Chip(
                              label: Text(
                                statusBayar == '1'
                                    ? 'Lunas'
                                    : statusBayar == '2'
                                        ? 'Belum Lunas'
                                        : statusBayar == '3'
                                            ? 'Bayar Sekarang'
                                            : 'Nunggak',
                                style: TextStyle(
                                    color:
                                        statusBayar == '1' || statusBayar == '4'
                                            ? Colors.white
                                            : Colors.black),
                              ),
                              backgroundColor: statusBayar == '1'
                                  ? Colors.green
                                  : statusBayar == '2'
                                      ? Colors.grey
                                      : statusBayar == '3'
                                          ? Colors.yellow
                                          : Colors.red),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            onPressed: statusBayar != '1'
                                ? () {
                                    Navigator.pushNamed(
                                        context, '/payment/kost',
                                        arguments: widget.info['id']);
                                  }
                                : null,
                            child: const Text('Bayar Kost')),
                        const SizedBox(height: 10),
                        const Text(
                          'Bantuan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            onPressed: () {
                              Navigator.pushNamed(context, '/review_kost/add',
                                  arguments: data);
                            },
                            child: const Text('Beri Review Kost')),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            onPressed: () {
                              _chatController.addContact(data['penghuni']['id'],
                                  data['pemilik']['id']);
                              // Navigator.pushNamed(context, '/chat', arguments: {
                              //   "id_user": data['penghuni']['id'],
                              //   "user_name": data['penghuni']['name'],
                              //   "id_sender": data['pemilik']['id'],
                              //   "sender_name": data['pemilik']['name'],
                              //   "sender_foto": data['pemilik']['foto_profile'],
                              // });
                            },
                            child: const Text('Hubungi Pemilik Kost')),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text('Error: terjadi kesalahan'));
            }
          },
        )),
      ),
    );
  }
}
