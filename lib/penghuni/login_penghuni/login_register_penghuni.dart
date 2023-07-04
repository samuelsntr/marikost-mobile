import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/account_controller.dart';

class LoginRegisterPenghuni extends StatefulWidget {
  const LoginRegisterPenghuni({super.key, required this.selectedPage});
  final selectedPage;

  @override
  State<LoginRegisterPenghuni> createState() => _LoginRegisterPenghuniState();
}

class _LoginRegisterPenghuniState extends State<LoginRegisterPenghuni> {
  final AkunController akunController = Get.put(AkunController());
  final _formKeyRegister = GlobalKey<FormBuilderState>();
  final _formKeyLogin = GlobalKey<FormBuilderState>();
  bool _showPassword = true;
  bool isInputed = false;
  int currentStep = 0;

  void _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.selectedPage,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            bottom: const TabBar(tabs: [
              Tab(
                text: 'Daftar',
              ),
              Tab(
                text: 'Masuk',
              ),
            ]),
          ),
          body: TabBarView(
            children: [_registerPenghuni(), _loginPenghuniKost()],
          )),
    );
  }

  SingleChildScrollView _loginPenghuniKost() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: FormBuilder(
            key: _formKeyLogin,
            child: ConstrainedBox(
                constraints: const BoxConstraints.tightFor(height: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.center,
                      child: Text('Login Penghuni Kost',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 10),
                    const Text('Email',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    FormBuilderTextField(
                      name: 'email',
                      decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          hintText: 'Email'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Wajib diisi!'),
                        FormBuilderValidators.email(
                            errorText: 'Format email salah!')
                      ]),
                    ),
                    const SizedBox(height: 10),
                    const Text('Kata Sandi',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    FormBuilderTextField(
                      name: 'password',
                      decoration: InputDecoration(
                          isDense: true,
                          border: const OutlineInputBorder(),
                          hintText: 'Kata sandi',
                          suffixIcon: IconButton(
                              onPressed: () => _toggleShowPassword(),
                              icon: Icon(_showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                      obscureText: _showPassword,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Wajib diisi!'),
                      ]),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                        onPressed: () {
                          _formKeyLogin.currentState!.save();
                          if (_formKeyLogin.currentState!.validate()) {
                            var data = _formKeyLogin.currentState!.value;
                            akunController.loginPenghuni(data);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40))),
                        child: const Text('Login')),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                          text: 'Belum Punya Akun?',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                            text: ' Daftar disini',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginRegisterPenghuni(
                                                selectedPage: 0)));
                              })
                      ])),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/forgot_password');
                        },
                        child: const Text(
                          'Lupa Password?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ))),
      ),
    );
  }

  SingleChildScrollView _registerPenghuni() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: FormBuilder(
          key: _formKeyRegister,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text('Daftar Kostmu Disini',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('Nama Lengkap',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 2,
                      leadingDistribution: TextLeadingDistribution.even)),
              FormBuilderTextField(
                name: 'nama',
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),
                    hintText: 'Masukan nama lengkap sesuai identitas'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Wajib diisi!')
                ]),
              ),
              const SizedBox(height: 10),
              const Text('Nomor Handphone',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 2,
                      leadingDistribution: TextLeadingDistribution.even)),
              FormBuilderTextField(
                name: 'phone',
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),
                    hintText: 'Gunakan no. handphone yang aktif'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Wajib diisi!')
                ]),
              ),
              const SizedBox(height: 10),
              const Text('Jenis Kelamin',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 2,
                      leadingDistribution: TextLeadingDistribution.even)),
              FormBuilderDropdown(
                name: 'jenis_kelamin',
                items: const [
                  DropdownMenuItem(
                      value: 'Laki - Laki', child: Text('Laki - Laki')),
                  DropdownMenuItem(
                      value: 'Perempuan', child: Text('Perempuan')),
                ],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Wajib diisi!')
                ]),
                decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    hintText: 'Pilih jenis kelamin'),
              ),
              const SizedBox(height: 10),
              const Text('Email',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 2,
                      leadingDistribution: TextLeadingDistribution.even)),
              FormBuilderTextField(
                name: 'email',
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),
                    hintText: 'Masukan email'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Wajib diisi!'),
                  FormBuilderValidators.email()
                ]),
              ),
              const SizedBox(height: 10),
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
                    if (value ==
                        _formKeyRegister.currentState!.value['password']) {
                      return null;
                    } else {
                      return 'Kata sandi tidak cocok!';
                    }
                  }
                ]),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {
                    _formKeyRegister.currentState!.save();
                    if (_formKeyRegister.currentState!.validate()) {
                      print(_formKeyRegister.currentState!.value);
                      var data = _formKeyRegister.currentState!.value;
                      akunController.registerAkunPenguni(data);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  child: const Text('Daftar')),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.center,
                child: RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                    text: 'Sudah Punya Akun?',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                      text: ' Masuk disini',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LoginRegisterPenghuni(
                                          selectedPage: 1)));
                        })
                ])),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
