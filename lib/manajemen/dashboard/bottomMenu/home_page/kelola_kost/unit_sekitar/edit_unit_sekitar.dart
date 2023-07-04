import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/unit_sekitar_controller.dart';

class EditUnitSekitar extends StatefulWidget {
  const EditUnitSekitar({super.key, required this.idUnit});

  final idUnit;
  @override
  State<EditUnitSekitar> createState() => _EditUnitSekitarState();
}

class _EditUnitSekitarState extends State<EditUnitSekitar> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final UnitSekitarController _unitSekitarController =
      Get.put(UnitSekitarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Tambah Unit Sekitar'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _unitSekitarController.getSingleUnitSekitar(widget.idUnit),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data;
            return Container(
              margin: const EdgeInsets.all(20),
              child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Nama Unit:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      FormBuilderTextField(
                        name: 'nama_unit',
                        initialValue: data['nama_unit'],
                        decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Nama Unit',
                            border: OutlineInputBorder()),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Wajib diisi!')
                        ]),
                      ),
                      const SizedBox(height: 20),
                      const Text('Jarak Unit:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      FormBuilderTextField(
                        name: 'jarak_unit',
                        initialValue: data['jarak_unit'],
                        decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Jarak Unit',
                            border: OutlineInputBorder()),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Wajib diisi!')
                        ]),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              var value = _formKey.currentState!.value;
                              _unitSekitarController.updateUnitSekitar(
                                  widget.idUnit,
                                  value,
                                  data['id_kost'],
                                  context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40))),
                          child: const Text('Tambah Unit Sekitar'))
                    ],
                  )),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('Error: Terjadi kesalahan'),
            );
          }
        },
      ),
    );
  }
}
