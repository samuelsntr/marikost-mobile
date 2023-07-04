import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/unit_sekitar_controller.dart';

class ListUnitSekitar extends StatefulWidget {
  const ListUnitSekitar({super.key, required this.idKost});

  final idKost;
  @override
  State<ListUnitSekitar> createState() => _ListUnitSekitarState();
}

class _ListUnitSekitarState extends State<ListUnitSekitar> {
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey();
  final UnitSekitarController _unitSekitarController =
      Get.put(UnitSekitarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Unit Sekitar'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _unitSekitarController.getUnitSekitarKost(widget.idKost),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.length > 0) {
              return RefreshIndicator(
                key: _refreshKey,
                onRefresh: () async {
                  await Future.delayed(
                    const Duration(seconds: 2),
                    () {
                      setState(() {});
                    },
                  );
                },
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var data = snapshot.data[index];
                    return Card(
                      child: ListTile(
                        leading:
                            const CircleAvatar(child: Icon(Icons.location_pin)),
                        title: Text(data['nama_unit']),
                        subtitle: Text(data['jarak_unit']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                _unitSekitarController
                                    .deleteUnitSekitar(data['id']);
                                setState(() {});
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/kost/unit/edit',
                                      arguments: data['id']);
                                },
                                icon: const Icon(Icons.edit))
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                ),
              );
            } else {
              return RefreshIndicator(
                key: _refreshKey,
                onRefresh: () async {
                  await Future.delayed(
                    const Duration(seconds: 2),
                    () {
                      setState(() {});
                    },
                  );
                },
                child: const SingleChildScrollView(
                  child: Center(
                    child: Text('Belum ada data unit sekitar'),
                  ),
                ),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('Error: Terjadi kesalahan'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/kost/unit/add',
              arguments: widget.idKost);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
