import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marikost/app_service/controller/account_controller.dart';
import 'package:marikost/app_service/controller/kamar_controller.dart';

class InfoKamarManajemen extends StatefulWidget {
  const InfoKamarManajemen({super.key, required this.idKamar});
  final idKamar;

  @override
  State<InfoKamarManajemen> createState() => _InfoKamarManajemenState();
}

class _InfoKamarManajemenState extends State<InfoKamarManajemen> {
  final KamarController _kamarController = Get.put(KamarController());
  final AkunController _akunController = Get.put(AkunController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Kamar'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _kamarController.getOneKamarkost(widget.idKamar),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              var currency = NumberFormat.simpleCurrency(
                  locale: 'id_ID', decimalDigits: 0);
              var profil = snapshot.data;
              var price = (profil['harga_kamar']);
              var priceElectric = (profil['biaya_listrik']);
              var priceWater = (profil['biaya_air']);
              var priceTrash = (profil['biaya_sampah']);

              var statusBayar;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x54000000),
                            spreadRadius: 4,
                            blurRadius: 20,
                          ),
                        ]),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      child: SizedBox.fromSize(
                        child: Image.network(
                            'https://api.marikost.com/storage/tampilan_kamar/${profil['tampilan'][0]['foto_kamar1']}'),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text('Informasi Kamar:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        ListTile(
                          leading: const Icon(
                            Icons.abc,
                            color: Colors.amber,
                          ),
                          title: const Text('Nama Kamar:'),
                          subtitle: Text(profil['nama_kamar']),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.straighten,
                            color: Colors.amber,
                          ),
                          title: const Text('Luas Kamar:'),
                          subtitle: Text(profil['luas_kamar']),
                        ),
                        ListTile(
                          title: const Text('Status Kamar:'),
                          trailing: Chip(
                            label: Text(
                                profil['status_kamar'] == '1'
                                    ? 'Tersedia'
                                    : 'Ditempati',
                                style: TextStyle(
                                  color: profil['status_kamar'] == '1'
                                      ? Colors.white
                                      : Colors.black,
                                )),
                            backgroundColor: profil['status_kamar'] == '1'
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const Text('Rincian Harga Kamar:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        ListTile(
                          leading: const Icon(
                            Icons.house,
                            color: Colors.amber,
                          ),
                          title: const Text('Harga Kamar:'),
                          subtitle: Text(currency.format(price)),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.electric_bolt,
                            color: Colors.amber,
                          ),
                          title: const Text('Biaya Listrik:'),
                          subtitle: Text(currency.format(priceElectric)),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.water_drop,
                            color: Colors.amber,
                          ),
                          title: const Text('Biaya Air:'),
                          subtitle: Text(currency.format(priceWater)),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.delete,
                            color: Colors.amber,
                          ),
                          title: const Text('Biaya Sampah:'),
                          subtitle: Text(currency.format(priceTrash)),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.paid,
                            color: Colors.amber,
                          ),
                          title: const Text('Total Biaya:'),
                          subtitle: Text(currency.format(
                              price + priceElectric + priceWater + priceTrash)),
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const Text('Penghuni kost:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        profil['penghuni'] != null
                            ? profilPenghuni(profil, statusBayar)
                            : const Padding(
                                padding: EdgeInsets.all(10),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Belum ada penghuni kost')),
                              )
                      ],
                    ),
                  )
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text('Tidak ada data ditemukan!'));
            }
          },
        ),
      ),
    );
  }

  FutureBuilder<dynamic> profilPenghuni(profil, statusBayar) {
    var endDate = DateTime.parse(profil['penghuni']['batas_akhir_pembayaran']);
    var daysbefore = DateTime(endDate.year, endDate.month, endDate.day - 10);
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
    return FutureBuilder(
      future: _akunController.getOneUserAkun(profil['penghuni']['id_penghuni']),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.isNotEmpty) {
            var user = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    foregroundImage: user['foto_profile'] != null
                        ? NetworkImage(
                            'https://api.marikost.com/storage/users/${user['foto_profile']}')
                        : null,
                    foregroundColor: user['foto_profile'] != null
                        ? Colors.transparent
                        : Colors.black,
                    radius: 40,
                    child: user['foto_profil'] == null
                        ? const Icon(
                            Icons.person,
                            size: 40,
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.abc,
                    color: Colors.amber,
                  ),
                  title: const Text('Nama'),
                  subtitle: Text(user['name']),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.phone,
                    color: Colors.amber,
                  ),
                  title: const Text('No. Telepon'),
                  subtitle: Text(user['no_handphone']),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.mail,
                    color: Colors.amber,
                  ),
                  title: const Text('Email'),
                  subtitle: Text(user['email']),
                ),
                ListTile(
                  leading: Icon(
                    user['jenis_kelamin'] == 'Perempuan'
                        ? Icons.female
                        : Icons.male,
                    color: Colors.amber,
                  ),
                  title: const Text('Jenis_kelamin'),
                  subtitle: Text(user['jenis_kelamin']),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.calendar_month,
                    color: Colors.amber,
                  ),
                  title: const Text('Tanggal Mulai Kost:'),
                  subtitle: Text(profil['penghuni']['tanggal_mulai_kost']),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.calendar_month,
                    color: Colors.amber,
                  ),
                  title: const Text('Batas Akhir Bayar:'),
                  subtitle: Text(profil['penghuni']['batas_akhir_pembayaran']),
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
                            color: statusBayar == '1' || statusBayar == '4'
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
              ],
            );
          } else {
            return const Center(
                child: Text('Tidak ada penghuni kost di kamar ini'));
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Loading...'));
        } else {
          return const Center(child: Text('Error'));
        }
      },
    );
  }
}
