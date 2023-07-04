import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/kamar_controller.dart';

class EditKamarKost extends StatefulWidget {
  const EditKamarKost({super.key, required this.idKamar});

  final idKamar;
  @override
  State<EditKamarKost> createState() => _EditKamarKostState();
}

class _EditKamarKostState extends State<EditKamarKost> {
  final KamarController _kamarController = Get.put(KamarController());
  final GlobalKey<FormBuilderState> _editFormKey =
      GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Kamar'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: Future.wait([
          _kamarController.getOneKamarkost(widget.idKamar),
          _kamarController.getFasilitasKamarbyIdKamar(widget.idKamar),
          _kamarController.getImageKamarbyIdKamar(widget.idKamar)
        ]),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            var kamar = snapshot.data[0];
            var fasum = snapshot.data[1][0];
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: FormBuilder(
                    key: _editFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Nama Kamar:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        FormBuilderTextField(
                          name: 'nama_kamar',
                          initialValue: kamar['nama_kamar'],
                          decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Nama Kamar',
                              border: OutlineInputBorder()),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Wajib diisi!')
                          ]),
                        ),
                        const SizedBox(height: 20),
                        const Text('Luas Kamar:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        FormBuilderTextField(
                          name: 'luas_kamar',
                          initialValue: kamar['luas_kamar'],
                          decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Luas Kamar',
                              border: OutlineInputBorder()),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Wajib diisi!')
                          ]),
                        ),
                        const SizedBox(height: 20),
                        const Text('Harga Kamar:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        FormBuilderTextField(
                          name: 'harga_kamar',
                          initialValue: kamar['harga_kamar'].toString(),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Harga Kamar',
                              border: OutlineInputBorder()),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Wajib diisi!')
                          ]),
                        ),
                        const SizedBox(height: 20),
                        const Text('Biaya Listrik:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        FormBuilderTextField(
                          name: 'biaya_listrik',
                          initialValue: kamar['biaya_listrik'].toString(),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Biaya Listrik',
                              border: OutlineInputBorder()),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Wajib diisi!')
                          ]),
                        ),
                        const SizedBox(height: 20),
                        const Text('Biaya Air:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        FormBuilderTextField(
                          name: 'biaya_air',
                          initialValue: kamar['biaya_air'].toString(),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Biaya Air',
                              border: OutlineInputBorder()),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Wajib diisi!')
                          ]),
                        ),
                        const SizedBox(height: 20),
                        const Text('Biaya Sampah:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        FormBuilderTextField(
                          name: 'biaya_sampah',
                          initialValue: kamar['biaya_sampah'].toString(),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Biaya Sampah',
                              border: OutlineInputBorder()),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Wajib diisi!')
                          ]),
                        ),
                        const SizedBox(height: 20),
                        const Text('Fasilitas Kamar:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        FormBuilderCheckbox(
                          name: 'wifi',
                          title: const Text('Wifi'),
                          initialValue: fasum['wifi'] == '1' ? true : false,
                        ),
                        FormBuilderCheckbox(
                            name: 'parkir',
                            title: const Text('Area parkir'),
                            initialValue:
                                fasum['parkir'] == '1' ? true : false),
                        FormBuilderCheckbox(
                            name: 'cctv',
                            title: const Text('CCTV'),
                            initialValue: fasum['cctv'] == '1' ? true : false),
                        FormBuilderCheckbox(
                            name: 'dapur',
                            title: const Text('Dapur'),
                            initialValue: fasum['dapur'] == '1' ? true : false),
                        FormBuilderCheckbox(
                            name: 'ruang_santai',
                            title: const Text('Ruang Santai'),
                            initialValue:
                                fasum['ruang_santai'] == '1' ? true : false),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            const Text('Foto Kamar:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            FormBuilderImagePicker(
                                imageQuality: 40,
                                name: 'foto_kamar1',
                                maxImages: 1,
                                initialValue: [
                                  'https://api.marikost.com/storage/tampilan_kamar/${snapshot.data[2][0]['foto_kamar1']}',
                                ],
                                decoration: const InputDecoration(
                                    labelText: 'Foto Kamar 1',
                                    border: OutlineInputBorder()),
                                galleryIcon: const Icon(Icons.image)),
                            const SizedBox(height: 20),
                            FormBuilderImagePicker(
                                imageQuality: 40,
                                name: 'foto_kamar2',
                                maxImages: 1,
                                initialValue:
                                    snapshot.data[2][0]['foto_kamar2'] != null
                                        ? [
                                            'https://api.marikost.com/storage/tampilan_kamar/${snapshot.data[2][0]['foto_kamar2']}'
                                          ]
                                        : null,
                                decoration: const InputDecoration(
                                    labelText: 'Foto Kamar 2',
                                    border: OutlineInputBorder()),
                                galleryIcon: const Icon(Icons.image)),
                            const SizedBox(height: 20),
                            FormBuilderImagePicker(
                                imageQuality: 40,
                                name: 'foto_kamar3',
                                initialValue:
                                    snapshot.data[2][0]['foto_kamar3'] != null
                                        ? [
                                            'https://api.marikost.com/storage/tampilan_kamar/${snapshot.data[2][0]['foto_kamar3']}'
                                          ]
                                        : null,
                                maxImages: 1,
                                decoration: const InputDecoration(
                                    labelText: 'Foto Kamar 3',
                                    border: OutlineInputBorder()),
                                galleryIcon: const Icon(Icons.image)),
                            const SizedBox(height: 20),
                            FormBuilderImagePicker(
                                imageQuality: 40,
                                name: 'foto_kamar360',
                                maxImages: 1,
                                initialValue:
                                    snapshot.data[2][0]['foto_kamar360'] != null
                                        ? [
                                            'https://api.marikost.com/storage/tampilan_kamar/${snapshot.data[2][0]['foto_kamar360']}'
                                          ]
                                        : null,
                                decoration: const InputDecoration(
                                    labelText: 'Foto Kamar 360',
                                    border: OutlineInputBorder()),
                                galleryIcon: const Icon(Icons.image)),
                            const SizedBox(height: 20),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () {
                              _editFormKey.currentState!.save();
                              if (_editFormKey.currentState!.validate()) {
                                var data = _editFormKey.currentState!.value;
                                _kamarController.editKamarKost(
                                    kamar['id'], data);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            child: const Text('Simpan Kamar')),
                        const SizedBox(height: 40),
                      ],
                    )),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('Tidak ada data ditemukan!'));
          }
        },
      ),
    );
  }
}
