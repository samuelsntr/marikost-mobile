import 'dart:io';
import 'package:get/get.dart';
import 'package:marikost/app_service/api_provider/api_provider.dart';
import 'package:marikost/main.dart';

class KamarController extends GetxController {
  final ApiProvider _apiProvider = ApiProvider();

  Future getListKamarIdKost(id) async {
    final res = await _apiProvider.getKamarByIdKost(id);
    if (res['status'] == 200) {
      return res['data'];
    } else {
      return Get.snackbar('Error', 'Error Data');
    }
  }

  Future getOneKamarkost(id) async {
    final res = await _apiProvider.getKamarByIdKamar(id);
    if (res['status'] == 200) {
      return res['data'];
    } else {
      return Get.snackbar('Error', 'Error Data');
    }
  }

  Future getImageKamarbyIdKamar(id) async {
    final res = await _apiProvider.getImageKamarByIdKamar(id);
    if (res['status'] == 200) {
      return res['data'];
    } else {
      return Get.snackbar('Error', 'Error Data');
    }
  }

  Future getFasilitasKamarbyIdKamar(id) async {
    final res = await _apiProvider.getFasilitasKamarByIdKamar(id);
    if (res['status'] == 200) {
      return res['data'];
    } else {
      return Get.snackbar('Error', 'Error Data');
    }
  }

  Future getKamarByIdPemilik(id) async {
    final res = await _apiProvider.getKamarByIdPemilik(id);
    if (res['status'] == 200) {
      return res['data'];
    } else {
      return Get.snackbar('Error', 'Error Data');
    }
  }

  void addKamarKost(idKost, data) async {
    var postDataKamar = FormData({
      "id_kost": idKost,
      "nama_kamar": data['nama_kamar'],
      "luas_kamar": data['luas_kamar'],
      "harga_kamar": data['harga_kamar'],
      "biaya_listrik": data['biaya_listrik'],
      "biaya_air": data['biaya_air'],
      "biaya_sampah": data['biaya_sampah'],
      "wifi": data['wifi'] != null ? '1' : '2',
      "parkir": data['parkir'] != null ? '1' : '2',
      "cctv": data['cctv'] != null ? '1' : '2',
      "dapur": data['dapur'] != null ? '1' : '2',
      "ruang_santai": data['ruang_santai'] != null ? '1' : '2',
      "foto_kamar1": MultipartFile(File(data['foto_kamar1'][0].path),
          filename: data['foto_kamar1'][0].name),
      "foto_kamar2": data['foto_kamar2'] != null
          ? MultipartFile(File(data['foto_kamar2'][0].path),
              filename: data['foto_kamar2'][0].name)
          : null,
      "foto_kamar3": data['foto_kamar3'] != null
          ? MultipartFile(File(data['foto_kamar3'][0].path),
              filename: data['foto_kamar3'][0].name)
          : null,
      "foto_kamar360": data['foto_kamar360'] != null
          ? MultipartFile(File(data['foto_kamar360'][0].path),
              filename: data['foto_kamar360'][0].name)
          : null,
    });

    final res = await _apiProvider.addKamarKost(postDataKamar);
    if (res['status'] == 201 || res['status'] == 200) {
      Get.snackbar('Info', res['message']);
      navigatorKey.currentState!.pop();
    } else {
      print(res);
      Get.snackbar('Error', 'Error Data');
    }
  }

  void editKamarKost(idKamar, data) async {
    var postDataKamar = FormData({
      "nama_kamar": data['nama_kamar'],
      "luas_kamar": data['luas_kamar'],
      "harga_kamar": data['harga_kamar'],
      "wifi": data['wifi'] != false ? '1' : '2',
      "parkir": data['parkir'] != false ? '1' : '2',
      "cctv": data['cctv'] != false ? '1' : '2',
      "dapur": data['dapur'] != false ? '1' : '2',
      "ruang_santai": data['ruang_santai'] != false ? '1' : '2',
      "foto_kamar1": data['foto_kamar1'] != null
          ? MultipartFile(File(data['foto_kamar1'][0].path),
              filename: data['foto_kamar1'][0].name)
          : null,
      "foto_kamar2": data['foto_kamar2'] != null
          ? MultipartFile(File(data['foto_kamar2'][0].path),
              filename: data['foto_kamar2'][0].name)
          : null,
      "foto_kamar3": data['foto_kamar3'] != null
          ? MultipartFile(File(data['foto_kamar3'][0].path),
              filename: data['foto_kamar3'][0].name)
          : null,
      "foto_kamar360": data['foto_kamar360'] != null
          ? MultipartFile(File(data['foto_kamar360'][0].path),
              filename: data['foto_kamar360'][0].name)
          : null,
      "_method": 'PUT'
    });

    final res = await _apiProvider.editKamarKost(postDataKamar, idKamar);
    if (res['status'] == 201 || res['status'] == 200) {
      Get.snackbar('Info', res['message']);
      navigatorKey.currentState!.pop();
    } else {
      print(res);
      Get.snackbar('Error', 'Error Data');
    }
  }

  void deleteKamarKost(id) async {
    final res = await _apiProvider.deleteKamarKost(id);
    if (res['status'] == 201 || res['status'] == 200) {
      navigatorKey.currentState!.pop();
      Get.snackbar('Info', res['message']);
    } else {
      print(res);
      Get.snackbar('Error', 'Error Data');
    }
  }
}
