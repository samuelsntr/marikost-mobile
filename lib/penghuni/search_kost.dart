import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';

class SearchKost extends StatefulWidget {
  const SearchKost({super.key, required this.search});

  final search;

  @override
  State<SearchKost> createState() => _SearchKostState();
}

class _SearchKostState extends State<SearchKost> {
  final KostController _kostController = Get.put(KostController());
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<FormBuilderState> _searchKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _filterKey = GlobalKey<FormBuilderState>();

  var _selectedJenis;
  var _selectedPrice;
  var _selectedIsi;
  var _selectedSort;
  var _hargaStart;
  var _hargaEnd;
  var search;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: FormBuilder(
          key: _searchKey,
          child: FormBuilderTextField(
            name: 'search_kost',
            initialValue: widget.search['alamat'],
            decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.all(10),
                hintText: 'Cari Kost',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: () {
                      _searchKey.currentState!.save();
                      setState(() {
                        search = _searchKey.currentState!.value['search_kost'];
                      });
                    },
                    icon: const Icon(Icons.search))),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.90,
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: FormBuilder(
                            key: _filterKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Filter',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Tipe Kost:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                                FormBuilderChoiceChip<String>(
                                    name: 'jenis_kost',
                                    spacing: 5,
                                    initialValue: _selectedJenis,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                    selectedColor: const Color(0xFFFFB82E),
                                    options: const [
                                      FormBuilderChipOption(
                                        value: '1',
                                        child: Text('Campuran'),
                                      ),
                                      FormBuilderChipOption(
                                        value: '2',
                                        child: Text('Putra'),
                                      ),
                                      FormBuilderChipOption(
                                        value: '3',
                                        child: Text('Putri'),
                                      ),
                                    ]),
                                const SizedBox(height: 10),
                                const Text(
                                  'Harga:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: FormBuilderTextField(
                                        name: 'harga_start',
                                        initialValue: _hargaStart ?? '0',
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            labelText: 'Min. Harga',
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(10),
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: FormBuilderTextField(
                                        name: 'harga_end',
                                        keyboardType: TextInputType.number,
                                        initialValue: _hargaEnd ?? '0',
                                        decoration: const InputDecoration(
                                            labelText: 'Max. Harga',
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(10),
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Jenis Kost:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                                FormBuilderChoiceChip<String>(
                                    name: 'harga_kost',
                                    spacing: 5,
                                    initialValue: _selectedPrice,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                    selectedColor: const Color(0xFFFFB82E),
                                    options: const [
                                      FormBuilderChipOption(
                                          value: '1', child: Text('Low')),
                                      FormBuilderChipOption(
                                          value: '2', child: Text('Mid')),
                                      FormBuilderChipOption(
                                          value: '3', child: Text('High')),
                                    ]),
                                const SizedBox(height: 10),
                                const Text(
                                  'Urutkan:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                                FormBuilderChoiceChip<String>(
                                    name: 'sort_kost',
                                    spacing: 5,
                                    initialValue: _selectedSort,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                    selectedColor: const Color(0xFFFFB82E),
                                    options: const [
                                      FormBuilderChipOption(
                                          value: '1', child: Text('Termurah')),
                                      FormBuilderChipOption(
                                          value: '2', child: Text('Termahal')),
                                    ]),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: const Size.fromHeight(50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40))),
                                    onPressed: () {
                                      _filterKey.currentState!.save();
                                      var filtered =
                                          _filterKey.currentState!.value;

                                      setState(() {
                                        _selectedPrice = filtered['harga_kost'];
                                        _selectedJenis = filtered['jenis_kost'];
                                        _selectedIsi = filtered['keterangan'];
                                        _selectedSort = filtered['sort_kost'];
                                        _hargaStart = filtered['harga_start'];
                                        _hargaEnd = filtered['harga_end'];
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Tampilkan')),
                                const SizedBox(height: 10),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedJenis = null;
                                        _hargaStart = null;
                                        _hargaEnd = null;
                                        _selectedPrice = null;
                                        _selectedIsi = null;
                                        _selectedSort = null;
                                      });
                                      Navigator.pop(context);
                                    },
                                    style: TextButton.styleFrom(
                                        foregroundColor: Colors.red),
                                    child: const Text('Hapus Filter'))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.tune))
        ],
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Hasil Penelusuran:',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              FutureBuilder(
                future: _kostController.getSearchKost(
                    search ?? widget.search['alamat'],
                    _selectedJenis,
                    _hargaStart,
                    _hargaEnd,
                    _selectedIsi,
                    _selectedPrice,
                    _selectedSort),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data.length > 0) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data[index];
                          var currency = NumberFormat.simpleCurrency(
                              locale: 'id_ID', decimalDigits: 0);
                          var lowPrice =
                              currency.format(data['harga_terendah']);
                          var highPrice =
                              currency.format(data['harga_tertinggi']);
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 2,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/kost_search/details',
                                      arguments: data);
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
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.network(
                                              'https://api.marikost.com/storage/kost/${data['foto_kost']}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data['nama_kost'],
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                '${lowPrice} - ${highPrice}',
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                              Container(
                                                  width: 200,
                                                  child: Text(
                                                    data['alamat_kost'],
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ))
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('Kost tidak ditemukan'),
                      );
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(
                      child: Text('Error: terjadi kesalahaan'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
