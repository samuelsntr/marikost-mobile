import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';

class ListPeraturanKost extends StatefulWidget {
  const ListPeraturanKost({super.key, required this.idKost});
  final idKost;

  @override
  State<ListPeraturanKost> createState() => _ListPeraturanKostState();
}

class _ListPeraturanKostState extends State<ListPeraturanKost> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final KostController _kostController = Get.put(KostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peraturan Kost'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: _kostController.getPeraturan(widget.idKost),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
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
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var data = snapshot.data[index];
                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.rule)),
                      title: Text('Peraturan ${index + 1}'),
                      subtitle: Text(data['aturan']),
                      trailing: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/kost/peraturan/edit',
                                arguments: data['id']);
                          },
                          icon: const Icon(Icons.edit)),
                    ),
                  );
                },
                itemCount: snapshot.data.length,
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
                child: Text('Maaf, belum ada peraturan dibuat!'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/kost/peraturan/add',
                arguments: widget.idKost);
          },
          child: const Icon(Icons.add)),
    );
  }
}
