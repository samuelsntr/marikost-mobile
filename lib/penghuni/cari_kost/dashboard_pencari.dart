import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';

class DashboardPencariKost extends StatefulWidget {
  const DashboardPencariKost({super.key});

  @override
  State<DashboardPencariKost> createState() => _DashboardPencariKostState();
}

class _DashboardPencariKostState extends State<DashboardPencariKost> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<FormBuilderState> _formSearhKey =
      GlobalKey<FormBuilderState>();
  final KostController _kostController = Get.put(KostController());

  var selectedCity = 'Semua Kota';
  var searchCity = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          key: _refreshKey,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2), () {
              setState(() {});
            });
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/marikost_bg_kelola.jpg'),
                          fit: BoxFit.cover)),
                  child: Padding(
                      padding:
                          const EdgeInsets.only(top: 25, left: 6, right: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/images/marikost_logo.png',
                              width: 70),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/login_penghuni');
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.only(right: 10),
                              child: const CircleAvatar(
                                backgroundColor: Colors.orange,
                                child: Icon(Icons.person),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: FormBuilder(
                            key: _formSearhKey,
                            child: FormBuilderTextField(
                              name: 'search',
                              readOnly: true,
                              onTap: () {
                                _formSearhKey.currentState!.save();
                                var res = _formSearhKey.currentState!.value;
                                Navigator.pushNamed(context, '/kost/cari',
                                    arguments: res);
                              },
                              decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(10),
                                  suffixIcon: InkWell(
                                    child: const Icon(Icons.search),
                                    // onTap: () {
                                    //   _formSearhKey.currentState!.save();
                                    //   var res =
                                    //       _formSearhKey.currentState!.value;
                                    //   if (res['search'] != null &&
                                    //       res['search'] != "") {
                                    //     Navigator.pushNamed(
                                    //         context, '/kost/cari',
                                    //         arguments: res);
                                    //   }
                                    // },
                                  ),
                                  border: const OutlineInputBorder(),
                                  hintText: 'Mau kost dimana?'),
                            )),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 4,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/jasa',
                                    arguments: {
                                      "title": "MariClean",
                                      "JasaId": 1,
                                    });
                              },
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Image.asset(
                                    'assets/images/MariClean.png',
                                    width: 50,
                                  ),
                                  const Text('MariClean')
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/jasa',
                                    arguments: {
                                      "title": "MariMart",
                                      "JasaId": 3,
                                    });
                              },
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Image.asset(
                                    'assets/images/MariMart.png',
                                    width: 50,
                                  ),
                                  const Text('MariMart')
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/jasa',
                                    arguments: {
                                      "title": "MariShop",
                                      "JasaId": 2,
                                    });
                              },
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Image.asset(
                                    'assets/images/MariShop.png',
                                    width: 50,
                                  ),
                                  const Text('MariShop')
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // Navigator.pushNamed(context, '/mari');
                                Navigator.pushNamed(context, '/jasa',
                                    arguments: {
                                      "title": "MariBayar",
                                      "JasaId": 4,
                                    });
                              },
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Image.asset(
                                    'assets/images/MariBayar.png',
                                    width: 50,
                                  ),
                                  const Text('MariBayar')
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/jasa',
                                    arguments: {
                                      "title": "MariFood",
                                      "JasaId": 5,
                                    });
                              },
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Image.asset(
                                    'assets/images/MariFood.png',
                                    width: 50,
                                  ),
                                  const Text('MariFood')
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/jasa',
                                    arguments: {
                                      "title": "MariTukang",
                                      "JasaId": 6,
                                    });
                              },
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Image.asset(
                                    'assets/images/MariTukang.png',
                                    width: 50,
                                  ),
                                  const Text('MariTukang')
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/jasa',
                                    arguments: {
                                      "title": "Lainnya",
                                      "JasaId": 7,
                                    });
                              },
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Stack(
                                    children: [
                                      Image.asset(
                                        'assets/images/bg-icon.png',
                                        width: 50,
                                      ),
                                      Positioned(
                                        left: 5,
                                        top: 5,
                                        child: Image.asset(
                                          'assets/images/more.png',
                                          width: 40,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Text('Lainnya')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: FutureBuilder(
                                future: _kostController.getIklanList(),
                                builder:
                                    (context, AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.connectionState ==
                                          ConnectionState.done) {
                                    if (snapshot.data.length > 0) {
                                      return Container(
                                        height: 150,
                                        width: double.infinity,
                                        child: ListView.builder(
                                          itemCount: snapshot.data.length,
                                          scrollDirection: Axis.horizontal,
                                          physics: const BouncingScrollPhysics(
                                              parent:
                                                  AlwaysScrollableScrollPhysics()),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            var data2 = snapshot.data[index];
                                            return Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(context,
                                                      '/kost_search/details',
                                                      arguments: data2);
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 150,
                                                      height: 100,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        child: Image.network(
                                                          'https://api.marikost.com/storage/kost/${data2['foto_kost']}',
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                data2[
                                                                    'nama_kost'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                        child: Text('Tidak Ada Iklan'),
                                      );
                                    }
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return const Center(
                                        child:
                                            Text('Error: terjadi kesalahan'));
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Rekomendasi Kost Terbaik',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (context, changeState) {
                                          return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.75,
                                            margin: const EdgeInsets.all(15),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Pilih Area',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                ),
                                                const Divider(),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: OutlinedButton(
                                                            style: OutlinedButton.styleFrom(
                                                                foregroundColor:
                                                                    Colors
                                                                        .black,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20))),
                                                            onPressed: () {
                                                              setState(() {
                                                                selectedCity =
                                                                    'Semua Kota';
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'Semua Kota'))),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                        child: OutlinedButton(
                                                            style: OutlinedButton.styleFrom(
                                                                foregroundColor:
                                                                    Colors
                                                                        .black,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20))),
                                                            onPressed: () {
                                                              setState(() {
                                                                selectedCity =
                                                                    'Sekitar Lokasi';
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'Sekitar Lokasi'))),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Pilih Kota',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .apply(
                                                            fontWeightDelta: 3),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Expanded(
                                                  child: FormBuilderTextField(
                                                    name: 'search_city',
                                                    onChanged: (value) {
                                                      changeState(() {
                                                        searchCity =
                                                            value.toString();
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText: 'Cari Kota',
                                                    ),
                                                  ),
                                                ),
                                                Divider(),
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  child: Container(
                                                    height: 370,
                                                    child: FutureBuilder(
                                                      future: searchCity
                                                                  .isNotEmpty &&
                                                              searchCity != null
                                                          ? _kostController
                                                              .getLocFilterArea(
                                                                  searchCity)
                                                          : _kostController
                                                              .getLocSelect(),
                                                      builder: (context,
                                                          AsyncSnapshot<dynamic>
                                                              snapshot) {
                                                        if (snapshot.hasData &&
                                                            snapshot.connectionState ==
                                                                ConnectionState
                                                                    .done) {
                                                          return ListView
                                                              .builder(
                                                            itemCount: snapshot
                                                                .data.length,
                                                            shrinkWrap: true,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return ListTile(
                                                                title: Text(
                                                                    snapshot.data[
                                                                            index]
                                                                        [
                                                                        'name']),
                                                                onTap: () {
                                                                  setState(() {
                                                                    selectedCity =
                                                                        snapshot.data[index]
                                                                            [
                                                                            'name'];
                                                                    searchCity =
                                                                        '';
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              );
                                                            },
                                                          );
                                                        } else if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return const Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        } else {
                                                          return const Center(
                                                              child: Text(
                                                                  'Error: not found'));
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 6, child: Text(selectedCity)),
                                      const Expanded(
                                        flex: 1,
                                        child: Icon(Icons.arrow_drop_down),
                                      )
                                    ],
                                  )),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: FutureBuilder(
                          future: selectedCity == 'Semua Kota' ||
                                  selectedCity == 'Sekitar Lokasi'
                              ? _kostController.getAllKost(selectedCity)
                              : _kostController.getLocSelected(selectedCity),
                          builder: (context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              if (snapshot.data.length > 0) {
                                return GridView.builder(
                                  addAutomaticKeepAlives: true,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  addRepaintBoundaries: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio:
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  500),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var data = snapshot.data[index];
                                    var currency = NumberFormat.simpleCurrency(
                                        locale: 'id_ID', decimalDigits: 0);

                                    return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/kost_search/details',
                                              arguments: data);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 200,
                                              height: 100,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                child: Image.network(
                                                    'https://api.marikost.com/storage/kost/${data['foto_kost']}',
                                                    fit: BoxFit.fill),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Chip(
                                                      label: Text(
                                                        data['jenis_kost'],
                                                        style: const TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      backgroundColor: Colors
                                                          .amber,
                                                      labelPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              vertical: -1,
                                                              horizontal: 3)),
                                                  Text(data['nama_kost'],
                                                      style: const TextStyle(
                                                          fontSize: 16)),
                                                  Text(
                                                      '${currency.format(data['harga_terendah'])} - ${currency.format(data['harga_tertinggi'])}/ Bulan',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                    heightFactor: 10,
                                    child: Text(
                                        'Tidak ada kost terdaftar disekitar sini'));
                              }
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  heightFactor: 10,
                                  child: CircularProgressIndicator());
                            } else {
                              return const Center(
                                  heightFactor: 10, child: Text('No Data'));
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 40)
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
