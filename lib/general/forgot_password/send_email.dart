import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/account_controller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AkunController _akunController = Get.put(AkunController());
  var _email;

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
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Lupa Password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              const Text(
                  'Masukan akun email yang terdaftar untuk mengubah password akun anda:'),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(
                    labelText: 'Email',
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder()),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.email(errorText: 'Format Email salah!')
                ]),
                onChanged: (value) {
                  setState(() {
                    _email = value.toString();
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    _akunController.lupaPasswordEmail(_email);
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
