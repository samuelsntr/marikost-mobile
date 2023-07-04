import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';

class MapNewKost extends StatefulWidget {
  const MapNewKost({super.key});

  @override
  State<MapNewKost> createState() => _MapNewKostState();
}

class _MapNewKostState extends State<MapNewKost> {
  final KostController _controller = Get.put(KostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlacePicker(
        apiKey: 'AIzaSyCzmgywzpQJVqsnH1k_8nhdDye7dMA2TLA',
        initialPosition: const LatLng(-8.690827, 115.226108),
        useCurrentLocation: true,
        onPlacePicked: (value) {
          _controller.getAddressMap(
              value.formattedAddress, value.geometry!.location);
          Navigator.pop(context);
        },
      ),
    );
  }
}
