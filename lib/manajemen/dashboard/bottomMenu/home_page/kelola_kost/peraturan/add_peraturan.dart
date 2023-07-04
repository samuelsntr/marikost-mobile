import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';

class AddPeraturanKost extends StatefulWidget {
  const AddPeraturanKost({super.key, required this.idKost});

  final idKost;

  @override
  State<AddPeraturanKost> createState() => _AddPeraturanKostState();
}

class _AddPeraturanKostState extends State<AddPeraturanKost> {
  final KostController _kostController = Get.put(KostController());
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Peraturan Kost'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Peraturan:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                FormBuilderTextField(
                  name: 'aturan',
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Peraturan',
                      border: OutlineInputBorder()),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Wajib diisi!')
                  ]),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        var data = _formKey.currentState!.value;
                        _kostController.addPeraturan(data, widget.idKost);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40))),
                    child: const Text('Tambah Peraturan Baru'))
              ],
            )),
      ),
    );
  }
}
