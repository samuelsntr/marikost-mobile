import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/kamar_controller.dart';

class AddKamarKost extends StatefulWidget {
  AddKamarKost({super.key, required this.idKost});

  var idKost;

  @override
  State<AddKamarKost> createState() => _AddKamarKostState();
}

class _AddKamarKostState extends State<AddKamarKost> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final KamarController _kamarController = Get.put(KamarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kamar Baru'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Nama Kamar:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                FormBuilderTextField(
                  name: 'nama_kamar',
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Nama Kamar',
                      border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Wajib diisi!')
                  ]),
                ),
                const SizedBox(height: 20),
                const Text('Luas Kamar:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                FormBuilderTextField(
                  name: 'luas_kamar',
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Luas Kamar',
                      border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Wajib diisi!')
                  ]),
                ),
                const SizedBox(height: 20),
                const Text('Harga Kamar:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                FormBuilderTextField(
                  name: 'harga_kamar',
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Harga Kamar',
                      border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Wajib diisi!')
                  ]),
                ),
                const SizedBox(height: 20),
                const Text('Biaya Listrik:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                FormBuilderTextField(
                  name: 'biaya_listrik',
                  initialValue: '0',
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Biaya Listrik',
                      border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Wajib diisi!')
                  ]),
                ),
                const SizedBox(height: 20),
                const Text('Biaya Air:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                FormBuilderTextField(
                  name: 'biaya_air',
                  keyboardType: TextInputType.number,
                  initialValue: '0',
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Biaya Air',
                      border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Wajib diisi!')
                  ]),
                ),
                const SizedBox(height: 20),
                const Text('Biaya Sampah:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                FormBuilderTextField(
                  name: 'biaya_sampah',
                  initialValue: '0',
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Biaya Sampah',
                      border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Wajib diisi!')
                  ]),
                ),
                const SizedBox(height: 20),
                const Text('Fasilitas Kamar:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                FormBuilderCheckbox(name: 'wifi', title: const Text('Wifi')),
                FormBuilderCheckbox(
                    name: 'parkir', title: const Text('Area parkir')),
                FormBuilderCheckbox(name: 'cctv', title: const Text('CCTV')),
                FormBuilderCheckbox(name: 'dapur', title: const Text('Dapur')),
                FormBuilderCheckbox(
                    name: 'ruang_santai', title: const Text('Ruang Santai')),
                const SizedBox(height: 20),
                FormBuilderImagePicker(
                    imageQuality: 40,
                    name: 'foto_kamar1',
                    maxImages: 1,
                    decoration: const InputDecoration(
                        labelText: 'Foto Kamar 1',
                        border: OutlineInputBorder()),
                    validator: FormBuilderValidators.required(
                        errorText: 'Gambar tidak boleh kosong'),
                    galleryIcon: const Icon(Icons.image)),
                const SizedBox(height: 20),
                FormBuilderImagePicker(
                    imageQuality: 40,
                    name: 'foto_kamar2',
                    maxImages: 1,
                    decoration: const InputDecoration(
                        labelText: 'Foto Kamar 2',
                        border: OutlineInputBorder()),
                    galleryIcon: const Icon(Icons.image)),
                const SizedBox(height: 20),
                FormBuilderImagePicker(
                    imageQuality: 40,
                    name: 'foto_kamar3',
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
                    decoration: const InputDecoration(
                        labelText: 'Foto Kamar 360',
                        border: OutlineInputBorder()),
                    galleryIcon: const Icon(Icons.image)),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        var data = _formKey.currentState!.value;
                        _kamarController.addKamarKost(widget.idKost, data);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40))),
                    child: const Text('Tambah Kamar'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
