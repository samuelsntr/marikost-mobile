import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marikost/app_service/api_provider/api_provider.dart';
import 'package:marikost/main.dart';

class BookingController extends GetxController {
  final ApiProvider _apiProvider = ApiProvider();
  void addNewBooking(id, idKamar) async {
    var data = {
      "id_user": id,
      "id_kamar": idKamar,
      "tanggal_booking": DateFormat('yyyy-MM-dd').format(DateTime.now())
    };

    final res = await _apiProvider.addBooking(data);
    if (res['status'] == 200 || res['status'] == 201) {
      Get.snackbar('Info', res['message']);
      navigatorKey.currentState!.popAndPushNamed('/dashboard_penghuni');
    } else {
      print(res);
      Get.snackbar('Error', 'Error Data');
    }
  }

  Future getOneBooking(id) async {
    final res = await _apiProvider.getOneBooking(id);
    if (res['status'] == 200) {
      return res['data'];
    } else {
      Get.snackbar('Error', 'Tidak ada data!');
    }
  }

  Future getPayment(id) async {
    final res = await _apiProvider.getOnePayment(id);
    if (res['status'] == 200) {
      return res['data'];
    } else {
      Get.snackbar('Error', 'Tidak ada data!');
    }
  }

  void konfirmBooking(id) async {
    var postData = {"status": '2', "_method": 'PUT'};

    final res = await _apiProvider.confirmBooking(postData, id);
    if (res['status'] == 200 || res['status'] == 201) {
      Get.snackbar('Info', res['message']);
      navigatorKey.currentState!.popAndPushNamed('/dashboard_manajemen');
    } else {
      Get.snackbar('Error', 'Tidak ada data!');
    }
  }

  void uploadBuktiPembayaran(data, id) async {
    var postData = FormData({
      "bukti_pembayaran": MultipartFile(File(data['bukti_pembayaran'][0].path),
          filename: data['bukti_pembayaran'][0].name),
      "_method": 'PUT'
    });

    final res = await _apiProvider.payBooking(postData, id);
    if (res['status'] == 200 || res['status'] == 201) {
      Get.snackbar('Info', res['message']);
      navigatorKey.currentState!.popAndPushNamed('/dashboard_manajemen');
    } else {
      Get.snackbar('Error', 'Tidak ada data!');
    }
  }

  void konfirmPembayaran(id) async {
    var postData = {"konfirmasi": '2', "_method": 'PUT'};

    final res = await _apiProvider.confirmPayment(postData, id);
    if (res['status'] == 200 || res['status'] == 201) {
      Get.snackbar('Info', res['message']);
      navigatorKey.currentState!.popAndPushNamed('/dashboard_manajemen');
    } else {
      Get.snackbar('Error', 'Tidak ada data!');
    }
  }
}
