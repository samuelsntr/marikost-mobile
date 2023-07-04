import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/kost_controller.dart';

class AddNewKost extends StatefulWidget {
  const AddNewKost({super.key});

  @override
  State<AddNewKost> createState() => _AddNewKostState();
}

class _AddNewKostState extends State<AddNewKost> {
  final _formKeyKost = GlobalKey<FormBuilderState>();
  final KostController _kostController = Get.put(KostController());
  int currentStep = 0;
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Tambah Kost Baru'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tambahkan Kost',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text(
                  'Daftarkan kost Anda dengan mengisi data di bawah ini dengan benar.'),
              FormBuilder(
                  key: _formKeyKost,
                  child: Stepper(
                      physics: NeverScrollableScrollPhysics(),
                      type: StepperType.vertical,
                      currentStep: currentStep,
                      onStepContinue: () {
                        bool isLastStep =
                            (currentStep == _stepAddKost().length - 1);
                        if (isLastStep) {
                          _formKeyKost.currentState!.save();
                          if (_formKeyKost.currentState!.validate()) {
                            setState(() {
                              _isLoading = !_isLoading;
                            });
                            _kostController
                                .addNewKost(_formKeyKost.currentState!.value);
                          }
                        } else {
                          setState(() {
                            currentStep += 1;
                          });
                        }
                      },
                      onStepCancel: () => currentStep == 0
                          ? null
                          : () {
                              setState(() {
                                print(currentStep);
                                currentStep -= 1;
                              });
                            },
                      onStepTapped: (value) {
                        setState(() {
                          currentStep = value;
                        });
                      },
                      steps: _stepAddKost())),
            ],
          ),
        ),
      ),
    );
  }

  List<Step> _stepAddKost() {
    return <Step>[
      Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text('Tambah Kost'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              FormBuilderTextField(
                name: 'nama_kost',
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Nama Kost',
                    border: OutlineInputBorder()),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Wajib di isi!')
                ]),
              ),
              const SizedBox(height: 20),
              FormBuilderTextField(
                name: 'deskripsi',
                maxLines: 3,
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Deskripsi',
                    border: OutlineInputBorder()),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Wajib di isi!')
                ]),
              ),
              const SizedBox(height: 20),
              FormBuilderDropdown(
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
                  name: 'keterangan',
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                      labelText: 'Keterangan Kost',
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
            ],
          )),
      Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text('Alamat Kost'),
          content: Column(
            children: [
              const SizedBox(height: 20),
              const Text('Lokasi Anda:'),
              const SizedBox(height: 20),
              Obx(
                () {
                  if (_kostController.locData.isNotEmpty) {
                    return Text(_kostController.locData['alamat']);
                  } else {
                    return const Text('Tidak ada data alamat!');
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/kost/add_map');
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  child: const Text('Cari Lokasi'))
            ],
          )),
      Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text('Foto Kost'),
          content: Column(
            children: [
              const SizedBox(height: 20),
              FormBuilderImagePicker(
                  name: 'foto_kost',
                  imageQuality: 40,
                  validator: FormBuilderValidators.required(
                      errorText: 'Gambar tidak boleh kosong'),
                  decoration: const InputDecoration(
                      labelText: 'Foto Kost', border: OutlineInputBorder()))
            ],
          )),
    ];
  }
}
