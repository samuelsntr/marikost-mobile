import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/api_provider/api_provider.dart';
import 'package:marikost/main.dart';

class AkunController extends GetxController {
  final ApiProvider _apiProvider = ApiProvider();

  void loginManajemen(data) async {
    const storage = FlutterSecureStorage();
    var postData = {"email": data['email'], "password": data['password']};

    final res = await _apiProvider.login(postData);

    if (res['status'] == 200) {
      if (res['data']['role'] == '2') {
        await storage.write(key: 'user', value: jsonEncode(res['data']));
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/dashboard_manajemen',
          (route) => false,
        );
      } else {
        Get.snackbar('Info', 'Email atau Password salah!');
      }
    } else {
      Get.snackbar('Info', 'Email atau Password salah!');
    }
  }

  void loginPenghuni(data) async {
    const storage = FlutterSecureStorage();
    var postData = {"email": data['email'], "password": data['password']};

    final res = await _apiProvider.login(postData);

    if (res['status'] == 200) {
      if (res['data']['role'] == '3') {
        await storage.write(key: 'user', value: jsonEncode(res['data']));
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil('/dashboard_penghuni', (route) => false);
      } else {
        Get.snackbar('Info', 'Email atau Password salah!');
      }
    } else {
      Get.snackbar('Info', 'Email atau Password salah!');
    }
  }

  Future getUserData() async {
    const storage = FlutterSecureStorage();
    final String? getUser = await storage.read(key: 'user');
    if (getUser != null) {
      var user = await jsonDecode(getUser);
      return user;
    } else {
      return null;
    }
  }

  Future getOneUserAkun(id) async {
    final res = await _apiProvider.getUserAkun(id);
    if (res['status'] == 200) {
      return res['data'];
    } else {
      Get.snackbar('Error', 'User tidak ditemukan');
    }
  }

  void registerAkunManajemen(data) async {
    var postData = FormData({
      "name": data['nama'],
      "email": data['email'],
      "password": data['password'],
      "role": "2",
      "no_handphone": data['phone'],
      "jenis_kelamin": data['jenis_kelamin'],
      "no_ktp": data['no_ktp'],
      "nama_bank": data['nama_bank'],
      "no_bank": data['no_bank'],
      "foto_ktp": MultipartFile(File(data['foto_ktp'][0].path),
          filename: data['foto_ktp'][0].name)
    });

    // print(postData);

    final res = await _apiProvider.register(postData);

    if (res['status'] == 200) {
      navigatorKey.currentState
          ?.pushReplacementNamed('/otp', arguments: data['email']);
    } else {
      Get.snackbar('Info', '${res['message']}');
    }
  }

  void registerAkunPenguni(data) async {
    var postData = FormData({
      "name": data['nama'],
      "email": data['email'],
      "password": data['password'],
      "jenis_kelamin": data['jenis_kelamin'],
      "role": "3",
      "no_handphone": data['phone'],
    });

    final res = await _apiProvider.register(postData);

    if (res['status'] == 200) {
      navigatorKey.currentState
          ?.pushReplacementNamed('/otp', arguments: data['email']);
    } else {
      Get.snackbar('Info', '${res['message']}');
    }
  }

  void lupaPasswordEmail(email) async {
    var data = {"email": email};

    final res = await _apiProvider.forgotPaswordEmail(data);
    if (res['status'] == 200 || res['status'] == 201) {
      navigatorKey.currentState
          ?.pushReplacementNamed('/otp_forgot', arguments: email);
    } else {
      Get.snackbar('Info', '${res['message']}');
    }
  }

  void checkOTPForgot(email, otp) async {
    var postData = {"email": email, "otp": otp};

    final res = await _apiProvider.checkOTPForgotPassword(postData);
    if (res['status'] == 200 || res['status'] == 200) {
      navigatorKey.currentState?.pushReplacementNamed('/change_password',
          arguments: res['data']['id']);
    } else {
      Get.snackbar('Info', '${res['message']}');
    }
  }

  void changePassword(pass, id) async {
    var data = {"password": pass, "_method": "PUT"};

    final res = await _apiProvider.forgotPassword(data, id);
    if (res['status'] == 200 || res['status'] == 200) {
      Get.snackbar('Info', 'Password berhasil diubah');
      navigatorKey.currentState?.pushReplacementNamed('/main_page');
    } else {
      Get.snackbar('Info', '${res['message']}');
    }
  }

  void editUserAkun(data, id) async {
    var storage = const FlutterSecureStorage();
    var postData = FormData({
      "name": data['name'],
      "foto_profile": data['foto_profile'] != null
          ? MultipartFile(File(data['foto_profile'][0].path),
              filename: data['foto_profile'][0].name)
          : null,
      "email": data['email'],
      "jenis_kelamin": data['jenis_kelamin'],
      "password": data['password'] ?? null,
      "no_handphone": data['no_handphone'],
      "nama_bank": data['nama_bank'] ?? null,
      "no_bank": data['no_bank'] ?? null,
      "_method": "PUT",
    });

    final res = await _apiProvider.updatUserAkun(postData, id);
    if (res['status'] == 200 || res['status'] == 201) {
      final user = await _apiProvider.getUserAkun(id);
      storage.delete(key: 'user');
      await storage.write(key: 'user', value: jsonEncode(user['data']));
      Get.snackbar('Info', res['message']);
      navigatorKey.currentState!.pop();
    } else {
      Get.snackbar('Error', res['message']);
    }
  }

  void checkOTP(pin, email) async {
    var postData = {"email": email, "otp": pin};

    final res = await _apiProvider.checkOTP(postData);
    if (res['status'] == 200) {
      const storage = FlutterSecureStorage();
      Get.snackbar('Info', 'Registrasi Selesai');
      await storage.write(key: 'user', value: jsonEncode(res['data']));
      if (res['data']['role'] == '2') {
        navigatorKey.currentState?.pushReplacementNamed('/dashboard_manajemen');
      } else if (res['data']['role'] == '3') {
        navigatorKey.currentState?.pushReplacementNamed('/dashboard_penghuni');
      }
    } else {
      Get.snackbar('Info', 'Registrasi Gagal');
    }
  }

  void resendOTP(email) async {
    var data = {"email": email};
    final res = await _apiProvider.resendOTP(data);
    if (res['status'] == 200) {
      Get.snackbar('Info', 'Resend Code');
    } else {
      Get.snackbar('info', 'Failed Resend Code');
    }
  }

  void deleteAccount(id) async {
    final res = await _apiProvider.deleteAccount(id);
    if (res['status'] == 200) {
      Get.snackbar('Info', 'Akun Telah Terhapus');
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/main_page', (route) => false);
    } else {
      Get.snackbar('info', 'Failed Remove Account');
    }
  }
}
