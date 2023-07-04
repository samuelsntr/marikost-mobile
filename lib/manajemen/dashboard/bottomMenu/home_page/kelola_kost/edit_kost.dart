import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';

class EditKostManajemen extends StatefulWidget {
  const EditKostManajemen({super.key, required this.idKost});

  final idKost;

  @override
  State<EditKostManajemen> createState() => _EditKostManajemenState();
}

class _EditKostManajemenState extends State<EditKostManajemen> {
  final KostController _kostController = Get.put(KostController());
  final GlobalKey<FormBuilderState> _editFormKey =
      GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Kost'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: _kostController.getOneKelolaKost(widget.idKost),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data;
            return Container(
              margin: const EdgeInsets.all(20),
              child: FormBuilder(
                key: _editFormKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      initialValue: data['nama_kost'],
                      name: 'nama_kost',
                      decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Nama Kost',
                          border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Wajib di isi!')
                      ]),
                    ),
                    const SizedBox(height: 20),
                    FormBuilderTextField(
                      initialValue: data['deskripsi'],
                      name: 'deskripsi',
                      maxLines: 3,
                      decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Deskripsi',
                          border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Wajib di isi!')
                      ]),
                    ),
                    const SizedBox(height: 20),
                    FormBuilderDropdown(
                        initialValue: data['jenis_kost'] == 'Kost Campuran'
                            ? '1'
                            : data['jenis_kost'] == 'Kost Putra'
                                ? '2'
                                : '3',
                        name: 'jenis_kost',
                        decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                            labelText: 'Jenis Kost',
                            border: OutlineInputBorder()),
                        items: const [
                          DropdownMenuItem(
                            value: '1',
                            child: Text('Kost Campuran'),
                          ),
                          DropdownMenuItem(
                            value: '2',
                            child: Text('Kost Putra'),
                          ),
                          DropdownMenuItem(
                            value: '3',
                            child: Text('Kost Putri'),
                          ),
                        ]),
                    const SizedBox(height: 20),
                    FormBuilderDropdown(
                        initialValue: data['keterangan'],
                        name: 'keterangan',
                        decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                            labelText: 'Jenis Kost',
                            border: OutlineInputBorder()),
                        items: const [
                          DropdownMenuItem(
                            value: '1',
                            child: Text('Isian'),
                          ),
                          DropdownMenuItem(
                            value: '2',
                            child: Text('Kosongan'),
                          ),
                        ]),
                    const SizedBox(height: 20),
                    const Text(
                      'Alamat Kost:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Obx(
                      () => Text(_kostController.locData['alamat'] != null
                          ? _kostController.locData['alamat']
                          : data['alamat_kost']),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/kost/add_map');
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40))),
                        child: const Text('Ubah Lokasi')),
                    const SizedBox(height: 20),
                    FormBuilderImagePicker(
                        imageQuality: 40,
                        name: 'foto_kost',
                        decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                            labelText: 'Foto Kost',
                            border: OutlineInputBorder())),
                    const SizedBox(height: 20),
                    const Text('Foto Kost:'),
                    Image.network(
                        'https://api.marikost.com/storage/kost/${data['foto_kost']}'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          _editFormKey.currentState!.save();
                          if (_editFormKey.currentState!.validate()) {
                            var input = _editFormKey.currentState!.value;
                            _kostController.editKost(input, data['id']);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40))),
                        child: const Text('Simpan')),
                  ],
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('Error, data tidak ditemukan!'));
          }
        },
      ),
    );
  }
}
