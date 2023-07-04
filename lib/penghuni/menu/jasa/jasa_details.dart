import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailJasa extends StatefulWidget {
  const DetailJasa({super.key, required this.jasa});

  final jasa;

  @override
  State<DetailJasa> createState() => _DetailJasaState();
}

class _DetailJasaState extends State<DetailJasa> {
  GoogleMapController? _googleMapController;
  Set<Marker> markers = Set();

  @override
  void initState() {
    // TODO: implement initState

    markers.add(Marker(
        markerId: MarkerId(LatLng(double.parse(widget.jasa['latitude']),
                double.parse(widget.jasa['longitude']))
            .toString()),
        position: LatLng(double.parse(widget.jasa['latitude']),
            double.parse(widget.jasa['longitude'])),
        infoWindow: InfoWindow(title: widget.jasa['nama']),
        icon: BitmapDescriptor.defaultMarker));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LatLng mapLocation = LatLng(double.parse(widget.jasa['latitude']),
        double.parse(widget.jasa['longitude']));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Detail Jasa'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Image.network(
                    'https://admin.marikost.com/storage/jasa/${widget.jasa['gambar']}'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text('Informasi Jasa'),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const Icon(Icons.abc, color: Colors.amber),
                    title: const Text('Nama Jasa'),
                    subtitle: Text(widget.jasa['nama']),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone, color: Colors.amber),
                    title: const Text('No. Telp'),
                    subtitle: Text(widget.jasa['no_handphone']),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.location_pin, color: Colors.amber),
                    title: const Text('Alamat Jasa'),
                    subtitle: Text(widget.jasa['alamat']),
                  ),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40))),
                      onPressed: () {},
                      child: const Text('Hubungi Jasa'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
