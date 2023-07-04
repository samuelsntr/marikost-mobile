import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';

class RequestIklan extends StatefulWidget {
  const RequestIklan({super.key, required this.id});

  final id;
  @override
  State<RequestIklan> createState() => _RequestIklanState();
}

class _RequestIklanState extends State<RequestIklan> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final KostController _kostController = Get.put(KostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Ajukan Iklan'),
        backgroundColor: const Color(0xFFFFB82E),
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 90,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: const Color(0xFFFFB82E),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 30, top: 20, bottom: 20),
              child: Text('Ajukan Iklan',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Silakan isi masukan batas tanggal untuk pengajuan iklan:',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
          Container(
            margin: const EdgeInsets.all(20),
            child: FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormBuilderDateTimePicker(
                      name: 'startDate',
                      firstDate: DateTime.now(),
                      inputType: InputType.date,
                      decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Tanggal Mulai',
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 20),
                    FormBuilderDateTimePicker(
                      name: 'lastDate',
                      firstDate: DateTime.now(),
                      inputType: InputType.date,
                      decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Tanggal Akhir',
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                        onPressed: () {
                          _formKey.currentState!.save();
                          if (_formKey.currentState!.validate()) {
                            var input = _formKey.currentState!.value;
                            _kostController.requestIklan(widget.id, input);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40))),
                        child: const Text('Request Iklan')),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
