import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart' as mapLaunch;
import 'package:marikost/app_service/controller/account_controller.dart';
import 'package:marikost/app_service/controller/kamar_controller.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';

class KostDetails extends StatefulWidget {
  const KostDetails({super.key, required this.kost});

  final kost;
  @override
  State<KostDetails> createState() => _KostDetailsState();
}

class _KostDetailsState extends State<KostDetails> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final AkunController _akunController = Get.put(AkunController());
  final KostController _kostController = Get.put(KostController());
  final KamarController _kamarController = Get.put(KamarController());

  GoogleMapController? _googleMapController;
  Set<Marker> markers = Set();

  @override
  void initState() {
    // TODO: implement initState
    markers.add(Marker(
        markerId: MarkerId(LatLng(double.parse(widget.kost['latitude']),
                double.parse(widget.kost['longitude']))
            .toString()),
        position: LatLng(double.parse(widget.kost['latitude']),
            double.parse(widget.kost['longitude'])),
        infoWindow: InfoWindow(title: widget.kost['nama_kost']),
        icon: BitmapDescriptor.defaultMarker));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Detail Kost'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: () async {
          await Future.delayed(
            const Duration(seconds: 2),
            () {
              setState(() {});
            },
          );
        },
        child: infoKost(context, widget.kost),
      ),
    );
  }

  launchMap(data) async {
    var latitude = double.parse(data['latitude']);
    var longitude = double.parse(data['longitude']);
    final availableMap = await mapLaunch.MapLauncher.installedMaps;
    final coords = mapLaunch.Coords(latitude, longitude);
    await availableMap.first.showDirections(
        destination: coords, destinationTitle: data['nama_kost']);
  }

  SingleChildScrollView infoKost(BuildContext context, data) {
    LatLng mapLocation = LatLng(double.parse(widget.kost['latitude']),
        double.parse(widget.kost['longitude']));
    var currency =
        NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: const Color.fromARGB(255, 236, 236, 236),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              height: 250,
              child: FutureBuilder(
                future: Future.wait([
                  _kostController.getOneKelolaKost(widget.kost['id']),
                  _kamarController.getListKamarIdKost(widget.kost['id'])
                ]),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    var kost = snapshot.data[0];
                    var kamar = snapshot.data[1][0]['tampilan'];
                    var image = [];
                    image.add(
                        'https://api.marikost.com/storage/kost/${kost['foto_kost']}');
                    if (kamar['foto_kamar1'] != null) {
                      image.add(
                          'https://api.marikost.com/storage/tampilan_kamar/${kamar['foto_kamar1']}');
                    }
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
                      pageSnapping: true,
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
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: Text('No data!'));
                  }
                },
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(data['nama_kost'], style: const TextStyle(fontSize: 18)),
                  Text(
                    '${currency.format(data['harga_terendah'])} - ${currency.format(data['harga_tertinggi'])} / Bulan',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Chip(label: Text(data['jenis_kost'])),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(data['alamat_kost']),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Lokasi',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 230,
                    child: GoogleMap(
                      zoomControlsEnabled: true,
                      initialCameraPosition:
                          CameraPosition(target: mapLocation, zoom: 16),
                      markers: markers,
                      mapType: MapType.normal,
                      onMapCreated: (controller) {
                        setState(() {
                          _googleMapController = controller;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextButton(
                        onPressed: () async {
                          launchMap(data);
                        },
                        child: const Text('Lihat Lokasi Map')),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Di Sekitar Unit',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  _nearLocation(data),
                  const Divider(),
                  const Text(
                    'Tentang Kost',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data['deskripsi'],
                    textAlign: TextAlign.justify,
                  ),
                  const Divider(),
                  const Text(
                    'Peraturan Kost',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  FutureBuilder(
                    future: _kostController.getPeraturan(widget.kost['id']),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data.length > 0) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var rule = snapshot.data[index];
                              return Text('${index + 1}. ${rule['aturan']}',
                                  style: const TextStyle(color: Colors.black));
                            },
                          );
                        } else {
                          return const Center(
                              child: Text('Belum ada peraturan kost'));
                        }
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: Text('Loading...'));
                      } else {
                        return const Center(
                            child: Text('Tidak ada data ditemukan!'));
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40))),
                      onPressed: () {
                        Navigator.pushNamed(context, '/kost_search/kost/review',
                            arguments: widget.kost['id']);
                      },
                      child: const Text('Komentar Kost')),
                  const SizedBox(height: 20),
                  const Divider(),
                  const Text(
                    'List Kamar Kost Tersedia',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  FutureBuilder(
                    future:
                        _kamarController.getListKamarIdKost(widget.kost['id']),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        var convert = NumberFormat.simpleCurrency(
                            locale: 'id_ID', decimalDigits: 0);
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var listKamar = snapshot.data[index];
                            if (listKamar['status_kamar'] != 'Ditempati') {
                              return Card(
                                elevation: 2,
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
                                                'https://api.marikost.com/storage/tampilan_kamar/${listKamar['tampilan']['foto_kamar1']}',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                listKamar['nama_kamar'],
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                convert.format(
                                                    listKamar['harga_kamar']),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40))),
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/kost_search/kamar/details',
                                                          arguments:
                                                              listKamar['id']);
                                                    },
                                                    child: const Text('Lihat')),
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 2,
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
                                                'https://api.marikost.com/storage/tampilan_kamar/${listKamar['tampilan']['foto_kamar1']}',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                listKamar['nama_kamar'],
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                convert.format(
                                                    listKamar['harga_kamar']),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        40))),
                                                    onPressed: null,
                                                    child: const Text('Lihat')),
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: Text('Loading...'));
                      } else {
                        return const Center(
                            child: Text('Tidak ada data ditemukan!'));
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _nearLocation(data) {
    return FutureBuilder(
      future: _kostController.getOneKelolaKost(data['id']),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data['unit_sekitar'].length > 0) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data['unit_sekitar'].length,
              itemBuilder: (context, index) {
                var unit = snapshot.data['unit_sekitar'][index];
                return ListTile(
                  leading: const Icon(Icons.location_pin, color: Colors.amber),
                  title: Text(unit['nama_unit']),
                  trailing: Text(unit['jarak_unit']),
                );
              },
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text('Tidak ada unit terdekat'),
              ),
            );
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Loading...'));
        } else {
          return const Center(child: Text('Error!'));
        }
      },
    );
  }
}
