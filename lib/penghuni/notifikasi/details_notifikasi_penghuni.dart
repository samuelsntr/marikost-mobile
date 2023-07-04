import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marikost/app_service/controller/booking_controller.dart';

class DetailPenghuniNotifikasi extends StatefulWidget {
  const DetailPenghuniNotifikasi({super.key, required this.notif});

  final notif;
  @override
  State<DetailPenghuniNotifikasi> createState() =>
      _DetailPenghuniNotifikasiState();
}

class _DetailPenghuniNotifikasiState extends State<DetailPenghuniNotifikasi> {
  final BookingController _bookingController = Get.put(BookingController());
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
              if (widget.notif['kode'] == '3')
                FutureBuilder(
                    future: _bookingController
                        .getPayment(widget.notif['id_pembayaran']),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        var convert = (snapshot.data['total_bayar'] ?? "1");
                        var price = NumberFormat.simpleCurrency(
                                locale: 'id_ID', decimalDigits: 0)
                            .format(convert);
                        return FormBuilder(
                            key: _formKey,
                            child: Column(
                              children: [
                                const Text('Info Kost',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                ListTile(
                                  leading: const Icon(Icons.house,
                                      color: Colors.amber),
                                  title: const Text('Nama Kost:'),
                                  subtitle: Text(snapshot.data['nama_kost']),
                                ),
                                ListTile(
                                  leading: const Icon(Icons.bed,
                                      color: Colors.amber),
                                  title: const Text('Nama kamar:'),
                                  subtitle: Text(snapshot.data['nama_kamar']),
                                ),
                                const Divider(),
                                const Text('Info Pembayaran',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                ListTile(
                                  leading: const Icon(Icons.person,
                                      color: Colors.amber),
                                  title: const Text('Nama Pemilik:'),
                                  subtitle:
                                      Text(snapshot.data['pemilik']['name']),
                                ),
                                ListTile(
                                  leading: const Icon(Icons.account_balance,
                                      color: Colors.amber),
                                  title: const Text('Bank:'),
                                  subtitle: Text(
                                      snapshot.data['pemilik']['nama_bank']),
                                ),
                                ListTile(
                                  leading: const Icon(Icons.credit_card,
                                      color: Colors.amber),
                                  title: const Text('No Rekening:'),
                                  subtitle:
                                      Text(snapshot.data['pemilik']['no_bank']),
                                ),
                                ListTile(
                                  leading: const Icon(Icons.payments,
                                      color: Colors.amber),
                                  title: const Text('Total:'),
                                  trailing: Text(price,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const Divider(),
                                const SizedBox(height: 20),
                                FormBuilderImagePicker(
                                    imageQuality: 40,
                                    name: 'bukti_pembayaran',
                                    maxImages: 1,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                          errorText:
                                              'Gambar tidak boleh kosong!')
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
                                    onPressed: () {
                                      _formKey.currentState!.save();
                                      if (_formKey.currentState!.validate()) {
                                        var data = _formKey.currentState!.value;

                                        _bookingController
                                            .uploadBuktiPembayaran(data,
                                                widget.notif['id_pembayaran']);
                                      }
                                    },
                                    child:
                                        const Text('Upload Bukti Pembayaran')),
                              ],
                            ));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const Center(
                          child: Text('Error: tidak ada data!'),
                        );
                      }
                    }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
