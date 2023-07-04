import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/unit_sekitar_controller.dart';

class AddUnitSekitar extends StatefulWidget {
  const AddUnitSekitar({super.key, required this.idKost});

  final idKost;
  @override
  State<AddUnitSekitar> createState() => _AddUnitSekitarState();
}

class _AddUnitSekitarState extends State<AddUnitSekitar> {
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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nama Unit:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  FormBuilderTextField(
                    name: 'nama_unit',
                    decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Nama Unit',
                        border: OutlineInputBorder()),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'Wajib diisi!')
                    ]),
                  ),
                  const SizedBox(height: 20),
                  const Text('Jarak Unit:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  FormBuilderTextField(
                    name: 'jarak_unit',
                    decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Jarak Unit',
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
                          _unitSekitarController.addUnitSekitar(
                              widget.idKost, data, context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40))),
                      child: const Text('Tambah Unit Sekitar'))
                ],
              )),
        ),
      ),
    );
  }
}
