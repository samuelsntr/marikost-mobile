import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/jasa_controller.dart';

class JasaList extends StatefulWidget {
  const JasaList({super.key, required this.dataJasa});

  final dataJasa;
  @override
  State<JasaList> createState() => _JasaListState();
}

class _JasaListState extends State<JasaList> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  final JasaController _jasaController = Get.put(JasaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  widget.dataJasa['title'],
                  style: const TextStyle(
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
            future: _jasaController.getJasaList(widget.dataJasa['JasaId']),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return RefreshIndicator(
                  key: _refreshKey,
                  onRefresh: () async {
                    Future.delayed(
                      const Duration(seconds: 2),
                      () {
                        setState(() {});
                      },
                    );
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var jasa = snapshot.data[index];
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          leading: CircleAvatar(
                            foregroundImage: NetworkImage(
                                "https://admin.marikost.com/storage/jasa/${jasa['gambar']}"),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/jasa/details',
                                arguments: jasa);
                          },
                          title: Text(jasa['nama']),
                          subtitle: Text('Phone: ${jasa['no_handphone']}'),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      );
                    },
                    itemCount: snapshot.data.length,
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(child: Text('Error: Terjadi kesalahan'));
              }
            },
          ),
        )
      ],
    ));
  }
}
