import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marikost/app_service/controller/account_controller.dart';
import 'package:marikost/app_service/controller/booking_controller.dart';
import 'package:marikost/app_service/controller/chat_controller.dart';
import 'package:marikost/app_service/controller/kamar_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class KamarDetails extends StatefulWidget {
  const KamarDetails({super.key, required this.idKamar});

  final idKamar;
  @override
  State<KamarDetails> createState() => _KamarDetailsState();
}

class _KamarDetailsState extends State<KamarDetails> {
  final KamarController _kamarController = Get.put(KamarController());
  final AkunController _akunController = Get.put(AkunController());
  final BookingController _bookingController = Get.put(BookingController());
  final ChatController _chatController = Get.put(ChatController());
  var currency = NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);

  void _launchWhatsapp(String phone, String message) async {
    url() {
      if (Platform.isAndroid) {
        return Uri.parse("https://wa.me/$phone/?text=${message}");
      } else {
        return Uri.parse("https://wa.me/$phone/?text=${Uri.parse(message)}");
      }
    }

    if (await canLaunchUrl(url())) {
      await launchUrl(url(), mode: LaunchMode.externalApplication);
    } else {
      throw 'Error cannot launch ${url()}!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Detail Kamar'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              height: 250,
              child: FutureBuilder(
                future: _kamarController.getOneKamarkost(widget.idKamar),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    var kamar = snapshot.data['tampilan'][0];
                    var image = [];
                    image.add(
                        'https://api.marikost.com/storage/tampilan_kamar/${kamar['foto_kamar1']}');
                    if (kamar['foto_kamar2'] != null) {
                      image.add(
                          'https://api.marikost.com/storage/tampilan_kamar/${kamar['foto_kamar2']}');
                    }
                    if (kamar['foto_kamar3'] != null) {
                      image.add(
                          'https://api.marikost.com/storage/tampilan_kamar/${kamar['foto_kamar3']}');
                    }
                    if (kamar['foto_kamar360'] != null) {
                      image.add(
                          'https://api.marikost.com/storage/tampilan_kamar/${kamar['foto_kamar360']}');
                    }
                    return PageView.builder(
                      itemCount: image.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/view/image',
                                arguments: image[index]);
                          },
                          child: Image.network(
                            image[index],
                            width: 250,
                          ),
                        );
                      },
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(
                        child: Text('Error: terjadi kesalahan'));
                  }
                },
              ),
            ),
            Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: FutureBuilder(
                  future: _kamarController.getOneKamarkost(widget.idKamar),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      var kamarKost = snapshot.data;
                      var price = kamarKost['harga_kamar'];
                      var priceElectric = kamarKost['biaya_listrik'];
                      var priceWater = kamarKost['biaya_air'];
                      var priceTrash = kamarKost['biaya_sampah'];
                      var fasilitas = snapshot.data['fasilitas'];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(kamarKost['nama_kamar'],
                              style: const TextStyle(fontSize: 20)),
                          Text(
                            '${currency.format(price)}/ Bulan',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 21),
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Rincian Biaya',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          ListTile(
                            leading: const Icon(Icons.electric_bolt,
                                color: Colors.amber),
                            title: const Text('Biaya Listrik'),
                            subtitle: Text(
                                '${currency.format(priceElectric)}/ Bulan'),
                          ),
                          ListTile(
                            leading: const Icon(Icons.water_drop,
                                color: Colors.amber),
                            title: const Text('Biaya Air'),
                            subtitle:
                                Text('${currency.format(priceWater)}/ Bulan'),
                          ),
                          ListTile(
                            leading:
                                const Icon(Icons.delete, color: Colors.amber),
                            title: const Text('Biaya Sampah'),
                            subtitle:
                                Text('${currency.format(priceTrash)}/ Bulan'),
                          ),
                          ListTile(
                            leading:
                                const Icon(Icons.paid, color: Colors.amber),
                            title: const Text('Total Biaya'),
                            subtitle: Text(
                                '${currency.format(price + priceElectric + priceWater + priceTrash)}/ Bulan'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                          const Text(
                            'Kost',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            kamarKost['kost']['nama_kost'],
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Luas Kamar',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Chip(label: Text(kamarKost['luas_kamar'])),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Fasilitas Kamar',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              if (fasilitas['wifi'] == '1')
                                const ListTile(
                                  leading: Icon(Icons.wifi),
                                  title: Text('Wifi'),
                                ),
                              if (fasilitas['parkir'] == '1')
                                const ListTile(
                                  leading: Icon(Icons.local_parking),
                                  title: Text('Area Parkir'),
                                ),
                              if (fasilitas['cctv'] == '1')
                                const ListTile(
                                  leading: Icon(Icons.shield),
                                  title: Text('CCTV'),
                                ),
                              if (fasilitas['dapur'] == '1')
                                const ListTile(
                                  leading: Icon(Icons.kitchen),
                                  title: Text('Dapur'),
                                ),
                              if (fasilitas['ruang_santai'] == '1')
                                const ListTile(
                                  leading: Icon(Icons.chair),
                                  title: Text('Ruang Santai'),
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: Text('Loading..'));
                    } else {
                      return const Center(child: Text('Error: tidak ada data'));
                    }
                  },
                )),
          ],
        )),
        bottomNavigationBar: FutureBuilder(
          future: Future.wait([
            _kamarController.getOneKamarkost(widget.idKamar),
            _akunController.getUserData(),
          ]),
          builder: (context, AsyncSnapshot<dynamic> snapshot) => Container(
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (snapshot.data != null && snapshot.data[1] != null) {
                        var idUser = snapshot.data[1]['id'];
                        var idSender = snapshot.data[0]['kost']['id_pemilik'];
                        _chatController.addContact(idUser, idSender);
                        // _launchWhatsapp('6285155208072', "hello world");
                      } else {
                        Navigator.pushNamed(context, '/login_penghuni');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan[900],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        maximumSize: const Size.fromHeight(60)),
                    child: const Text('Kirim Pesan',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (snapshot.data != null && snapshot.data[1] != null) {
                        _bookingController.addNewBooking(
                            snapshot.data[1]['id'], widget.idKamar);
                      } else {
                        Navigator.pushNamed(context, '/login_penghuni');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        maximumSize: const Size.fromHeight(60)),
                    child: const Text(
                      'Ajukan Penawaran',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
