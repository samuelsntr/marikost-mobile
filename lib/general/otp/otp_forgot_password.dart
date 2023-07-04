import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/account_controller.dart';
import 'package:pinput/pinput.dart';

class OTPForgotPassword extends StatefulWidget {
  const OTPForgotPassword({super.key, required this.email});

  final email;

  @override
  State<OTPForgotPassword> createState() => _OTPForgotPasswordState();
}

class _OTPForgotPasswordState extends State<OTPForgotPassword> {
  final AkunController akunController = Get.put(AkunController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController otpCode = TextEditingController();
  int secondsRemaining = 30;
  bool enableResend = false;
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
    super.initState();
  }

  void _resendCode() {
    akunController.resendOTP(widget.email);
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Lupa Password'),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  const Text('Masukkan Kode OTP',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                  Text(
                    'Kami telah mengirimkan kode OTP ke alamat email ${widget.email}. Silahkan masukkan kode tersebut di kolom bawah ini.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Pinput(
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          controller: otpCode,
                          length: 4,
                          onCompleted: (value) {
                            akunController.checkOTPForgot(widget.email, value);
                          },
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }
}
