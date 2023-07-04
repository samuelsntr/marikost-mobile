import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/account_controller.dart';
import 'package:marikost/app_service/controller/booking_controller.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';

class DetailNotifikasiManajemen extends StatefulWidget {
  const DetailNotifikasiManajemen({super.key, required this.notif});

  final notif;
  @override
  State<DetailNotifikasiManajemen> createState() =>
      _DetailNotifikasiManajemenState();
}

class _DetailNotifikasiManajemenState extends State<DetailNotifikasiManajemen> {
  final BookingController _bookingController = Get.put(BookingController());
  final KostController _kostController = Get.put(KostController());
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset('assets/images/undraw_opened.png'),
              ),
              const SizedBox(height: 30),
              Text(widget.notif['judul'],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Text(widget.notif['pesan']),
              const SizedBox(height: 30),
              if (widget.notif['kode'] == '2')
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40))),
                    onPressed: () {
                      _bookingController
                          .konfirmBooking(widget.notif['id_booking']);
                    },
                    child: const Text('Konfirmasi Booking')),
              if (widget.notif['kode'] == '4')
                FutureBuilder(
                  future: _bookingController
                      .getPayment(widget.notif['id_pembayaran']),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        children: [
                          Image.network(
                              'https://api.marikost.com/storage/payment/${snapshot.data['bukti_pembayaran']}'),
                          const SizedBox(height: 10),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40))),
                              onPressed: () {
                                _bookingController.konfirmPembayaran(
                                    widget.notif['id_pembayaran']);
                              },
                              child: const Text('Konfirmasi Pembayaran')),
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const Center(
                          child: Text('Error: tidak ada data ditemukan!'));
                    }
                  },
                ),
              if (widget.notif['id_iklan'] != null &&
                  widget.notif['kode'] == '5')
                FutureBuilder(
                  future:
                      _kostController.getSingleIklan(widget.notif['id_iklan']),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return FormBuilder(
                          key: _formKey,
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.house),
                                title: const Text('Tanggal Mulai:'),
                                subtitle: Text(snapshot.data['start_date']),
                              ),
                              ListTile(
                                leading: const Icon(Icons.house),
                                title: const Text('Tanggal Selesai:'),
                                subtitle: Text(snapshot.data['end_date']),
                              ),
                              const Divider(),
                              const SizedBox(height: 20),
                              FormBuilderImagePicker(
                                  imageQuality: 40,
                                  name: 'bukti_pembayaran',
                                  maxImages: 1,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Gambar tidak boleh kosong!')
                                  ]),
                                  decoration: const InputDecoration(
                                      labelText: 'Bukti Pembayaran',
                                      border: OutlineInputBorder()),
                                  galleryIcon: const Icon(Icons.image)),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40))),
                                  onPressed: snapshot.data['konfirmasi'] !=
                                              '2' &&
                                          snapshot.data['konfirmasi'] != '3'
                                      ? () {
                                          _formKey.currentState!.save();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            var data =
                                                _formKey.currentState!.value;

                                            _kostController
                                                .confirmPembayaranIklan(
                                                    widget.notif['id_iklan'],
                                                    data);
                                          }
                                        }
                                      : null,
                                  child: const Text('Upload Bukti Pembayaran')),
                            ],
                          ));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const Center(
                          child: Text('Error: tidak ada data ditemukan!'));
                    }
                  },
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
