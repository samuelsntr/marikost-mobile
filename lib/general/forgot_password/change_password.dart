import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/account_controller.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key, required this.id});

  final id;
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final AkunController _akunController = Get.put(AkunController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lupa Password'),
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
              const Text('Ubah Password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text('Kata Sandi',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 2,
                      leadingDistribution: TextLeadingDistribution.even)),
              FormBuilderTextField(
                name: 'password',
                obscureText: true,
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),
                    hintText: 'Minimal 8 karakter'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Wajib diisi!'),
                  FormBuilderValidators.min(8)
                ]),
              ),
              const SizedBox(height: 10),
              const Text('Ulangi Kata Sandi',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 2,
                      leadingDistribution: TextLeadingDistribution.even)),
              FormBuilderTextField(
                name: 'retype_password',
                obscureText: true,
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),
                    hintText: 'Masukan kembali kata sandi'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Wajib diisi!'),
                  FormBuilderValidators.min(8),
                  (value) {
                    if (value == _formKey.currentState!.value['password']) {
                      return null;
                    } else {
                      return 'Kata sandi tidak cocok!';
                    }
                  }
                ]),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      print(_formKey.currentState!.value);
                      var data = _formKey.currentState!.value;
                      _akunController.changePassword(
                          data['password'], widget.id);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  child: const Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
