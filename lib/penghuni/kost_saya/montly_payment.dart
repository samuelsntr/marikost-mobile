import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';

class PaymentKost extends StatefulWidget {
  const PaymentKost({super.key, required this.idPenghuni});

  final idPenghuni;
  @override
  State<PaymentKost> createState() => _PaymentKostState();
}

class _PaymentKostState extends State<PaymentKost> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final KostController _kostController = Get.put(KostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Kost Saya'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: _kostController.getPaymentMonthlyData(widget.idPenghuni),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data;
            var price = (data['kamar']['harga_kamar']);
            var priceElectric = (data['kamar']['biaya_listrik']);
            var priceWater = (data['kamar']['biaya_air']);
            var priceTrash = (data['kamar']['biaya_sampah']);
            var totalBiaya = price + priceElectric + priceWater + priceTrash;
            var currency =
                NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informasi Biaya',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: const Icon(Icons.house, color: Colors.amber),
                      title: const Text('Biaya Kamar'),
                      trailing: Text('- ${currency.format(price)}'),
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.electric_bolt, color: Colors.amber),
                      title: const Text('Biaya Listrik'),
                      trailing: Text('- ${currency.format(priceElectric)}'),
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.water_drop, color: Colors.amber),
                      title: const Text('Biaya Air'),
                      trailing: Text('- ${currency.format(priceWater)}'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.delete, color: Colors.amber),
                      title: const Text('Biaya Sampah'),
                      trailing: Text('- ${currency.format(priceTrash)}'),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.payments, color: Colors.amber),
                      title: const Text('Total Biaya'),
                      trailing: Text(
                        '- ${currency.format(totalBiaya)}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Informasi Pembayaran',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.amber),
                      title: const Text('Nama Pemilik'),
                      subtitle: Text(data['pemilik']['name']),
                    ),
                    ListTile(
                      leading: const Icon(Icons.account_balance,
                          color: Colors.amber),
                      title: const Text('Bank'),
                      subtitle: Text(data['pemilik']['nama_bank']),
                    ),
                    ListTile(
                      leading: const Icon(Icons.payment, color: Colors.amber),
                      title: const Text('No. Rekening'),
                      subtitle: Text(data['pemilik']['no_bank']),
                    ),
                    const SizedBox(height: 10),
                    FormBuilder(
                        key: _formKey,
                        child: Column(
                          children: [
                            FormBuilderImagePicker(
                              imageQuality: 40,
                              name: 'bukti_pembayaran',
                              decoration: const InputDecoration(
                                  labelText: 'Bukti Pembayaran',
                                  border: OutlineInputBorder()),
                              maxImages: 1,
                              validator: FormBuilderValidators.compose(
                                  [FormBuilderValidators.required()]),
                            ),
                            const SizedBox(height: 10),
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
                                    _kostController.postPaymentMonthly(
                                        data, widget.idPenghuni);
                                  }
                                },
                                child: const Text('Bayar Kost')),
                          ],
                        )),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
        },
      ),
    );
  }
}
