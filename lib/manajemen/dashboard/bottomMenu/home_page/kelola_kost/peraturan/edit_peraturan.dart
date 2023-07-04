import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';

class EditdanHapusPeraturanKost extends StatefulWidget {
  const EditdanHapusPeraturanKost({super.key, required this.idPeraturan});

  final idPeraturan;
  @override
  State<EditdanHapusPeraturanKost> createState() =>
      _EditdanHapusPeraturanKostState();
}

class _EditdanHapusPeraturanKostState extends State<EditdanHapusPeraturanKost> {
  final KostController _kostController = Get.put(KostController());
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Peraturan Kost'),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
          future: _kostController.getOnePeraturan(widget.idPeraturan),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return Container(
                margin: const EdgeInsets.all(20),
                child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text('Peraturan:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        FormBuilderTextField(
                          initialValue: snapshot.data['aturan'],
                          name: 'aturan',
                          decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Peraturan',
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
                                var data = _formKey.currentState!.value;
                                _kostController.editPeraturan(
                                    data, widget.idPeraturan);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            child: const Text('Simpan Peraturan Baru')),
                        const SizedBox(height: 50),
                        ElevatedButton(
                            onPressed: () {
                              _kostController
                                  .deletePeraturan(widget.idPeraturan);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            child: const Text('Hapus Peraturan'))
                      ],
                    )),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(child: Text('Error!'));
            }
          },
        ));
  }
}
