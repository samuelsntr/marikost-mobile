import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marikost/app_service/api_provider/api_provider.dart';
import 'package:marikost/main.dart';

class KostController extends GetxController {
  final ApiProvider _apiProvider = ApiProvider();
  var locData = {}.obs;

  void getAddressMap(address, coordinates) {
    locData['alamat'] = address;
    locData['lat'] = coordinates.lat;
    locData['lng'] = coordinates.lng;
    update();
  }

  Future getAllKost(filter) async {
    var res = await _apiProvider.getAllKost();
    if (res['status'] == 200) {
      if (filter == 'Sekitar Lokasi') {
        double radiusInMeter = 5000;
        List radiusLoc = [];
        Position position = await Geolocator.getCurrentPosition();
        double lat = position.latitude;
        double lng = position.longitude;

        for (var i = 0; i < res['data'].length; i++) {
          var list = res['data'][i];
          var desLat = double.parse(list['latitude']);
          var desLng = double.parse(list['longitude']);
          double distance =
              Geolocator.distanceBetween(lat, lng, desLat, desLng);
          if (distance < radiusInMeter) {
            print(distance);
            radiusLoc.add(list);
          }
        }
        var kost = List.from(radiusLoc);
        return kost;
      } else {
        return res['data'];
      }
    } else {
      return Get.snackbar('Error', 'Terjadi kesalahan');
    }
  }

  void addNewKost(data) async {
    const storage = FlutterSecureStorage();
    final String? getUser = await storage.read(key: 'user');
    Map<String, dynamic> user = jsonDecode(getUser!);

    var postData = FormData({
      "id_pemilik": user['id'],
      "nama_kost": data['nama_kost'],
      "alamat_kost": locData['alamat'],
      "jenis_kost": data['jenis_kost'],
      "keterangan": data['keterangan'],
      "latitude": locData['lat'],
      "longitude": locData['lng'],
      "deskripsi": data['deskripsi'],
      "foto_kost": MultipartFile(File(data['foto_kost'][0].path),
          filename: data['foto_kost'][0].name),
    });

    final res = await _apiProvider.addKost(postData);

    if (res['status'] == 200) {
      Get.snackbar('Info', '${res['message']}');
      navigatorKey.currentState!.popAndPushNamed('/dashboard_manajemen');
    } else {
      print(res);
      Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  void editKost(data, id) async {
    var postData = FormData({
      "nama_kost": data['nama_kost'],
      "alamat_kost": locData['alamat'],
      "jenis_kost": data['jenis_kost'],
      "keterangan": data['keterangan'],
      "latitude": locData['lat'],
      "longitude": locData['lng'],
      "deskripsi": data['deskripsi'],
      "foto_kost": data['foto_kost'] != null
          ? MultipartFile(File(data['foto_kost'][0].path),
              filename: data['foto_kost'][0].name)
          : null,
      "_method": 'PUT'
    });

    final res = await _apiProvider.editKost(postData, id);

    if (res['status'] == 200 || res['status'] == 201) {
      Get.snackbar('Info', '${res['message']}');
      navigatorKey.currentState!.pop();
    } else {
      Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  Future getkelolaKost() async {
    const storage = FlutterSecureStorage();
    final String? getUser = await storage.read(key: 'user');
    Map<String, dynamic> user = jsonDecode(getUser!);

    var res = await _apiProvider.getAllPemilikKost(user['id']);
    return res['data'];
  }

  Future getOneKelolaKost(id) async {
    var res = await _apiProvider.getOneKost(id);
    if (res['status'] == 200) {
      return res['data'];
    } else {
      return Get.snackbar('Error', 'Terjadi kesalahan');
    }
  }

  Future getPeraturan(id) async {
    var res = await _apiProvider.getPeraturanKost(id);
    if (res['status'] == 200) {
      return res['data'];
    } else {
      return Get.snackbar('Error', 'Terjadi kesalahan');
    }
  }

  Future getOnePeraturan(id) async {
    var res = await _apiProvider.getOnePeraturanKost(id);
    if (res['status'] == 200) {
      return res['data'];
    } else {
      return Get.snackbar('Error', 'Terjadi kesalahan');
    }
  }

  void addPeraturan(data, idKost) async {
    var post = {"id_kost": idKost, "aturan": data['aturan']};

    final res = await _apiProvider.addPeraturanKost(post);

    if (res['status'] == 200 || res['status'] == 201) {
      Get.snackbar('Info', '${res['message']}');
      navigatorKey.currentState!.pop();
    } else {
      Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  void editPeraturan(data, idPeraturan) async {
    var post = {"aturan": data['aturan'], "_method": "PUT"};

    final res = await _apiProvider.editPeraturanKost(post, idPeraturan);

    if (res['status'] == 200 || res['status'] == 201) {
      Get.snackbar('Info', '${res['message']}');
      navigatorKey.currentState!.pop();
    } else {
      Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  void deletePeraturan(id) async {
    final res = await _apiProvider.deletePeraturanKost(id);
    if (res['status'] == 200 || res['status'] == 201) {
      Get.snackbar('Info', '${res['message']}');
      navigatorKey.currentState!.pop();
    } else {
      Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  Future getLocSelect() async {
    var res = await _apiProvider.getLocList();
    if (res['status'] == 200) {
      return res['data'];
    } else {
      return Get.snackbar('Error', 'Terjadi kesalahan');
    }
  }

  Future getLocSelected(data) async {
    Map<String, dynamic> search = {"area": data};
    var res = await _apiProvider.getAreaList(search);
    if (res['status'] == 200) {
      return res['data'];
    } else {
      return Get.snackbar('Error', 'Terjadi kesalahan');
    }
  }

  Future getLocFilterArea(data) async {
    Map<String, dynamic> search = {"area": data};
    var res = await _apiProvider.getAreaFilterList(search);
    if (res['status'] == 200) {
      return res['data'];
    } else {
      return Get.snackbar('Error', 'Terjadi kesalahan');
    }
  }

  Future getSearchKost(
      alamat, jenis, hargaStart, hargaEnd, keterangan, rangePrice, sort) async {
    Map<String, dynamic> search = {
      "alamat_kost": alamat,
      "jenis_kost": jenis,
      "harga_start": hargaStart ?? 0,
      "harga_end": hargaEnd ?? 0,
      "keterangan": keterangan,
      "sort": sort,
      "range_harga": rangePrice
    };

    final res = await _apiProvider.getSearchKost(search);
    if (res['status'] == 200 || res['status'] == 201) {
      return res['data'];
    } else {
      return Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  void requestIklan(id, data) async {
    var request = {
      "id_kost": id,
      "start_date":
          DateFormat("yyyy-MM-dd").format(data['startDate']).toString(),
      "end_date": DateFormat("yyyy-MM-dd").format(data['lastDate']).toString(),
    };
    final res = await _apiProvider.requestIklan(request);
    if (res['status'] == 200 || res['status'] == 201) {
      Get.snackbar('Info', '${res['message']}');
      navigatorKey.currentState!.pop();
    } else {
      Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  Future getIklanList() async {
    final res = await _apiProvider.getIklanList();
    if (res['status'] == 200 || res['status'] == 201) {
      return res['data'];
    } else {
      return Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  Future getSingleIklan(id) async {
    final res = await _apiProvider.getSingleIklanList(id);
    if (res['status'] == 200 || res['status'] == 201) {
      return res['data'];
    } else {
      return Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  void confirmPembayaranIklan(id, data) async {
    var req = FormData({
      "bukti_pembayaran": MultipartFile(File(data['bukti_pembayaran'][0].path),
          filename: data['bukti_pembayaran'][0].name),
      "_method": "PUT"
    });

    final res = await _apiProvider.pembayaranIklan(id, req);
    if (res['status'] == 200 || res['status'] == 201) {
      Get.snackbar('Info', '${res['message']}');
      navigatorKey.currentState!.pop();
    } else {
      Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  void addReview(idkost, idPenghuni, star, value) async {
    var data = {
      "id_user": idPenghuni,
      "id_kost": idkost,
      "grade": star,
      "komentar": value['komentar']
    };

    final res = await _apiProvider.addReview(data);
    if (res['status'] == 200 || res['status'] == 201) {
      Get.snackbar('Info', 'Sukses memberikan review kost');
      navigatorKey.currentState!.pop();
    } else {
      Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  Future getReviewKostData(id) async {
    final res = await _apiProvider.getReviewKostId(id);
    if (res['status'] == 200 || res['status'] == 201) {
      return res['data'];
    } else {
      return Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  Future getPaymentMonthlyData(id) async {
    final res = await _apiProvider.getPaymentMontly(id);
    if (res['status'] == 200 || res['status'] == 201) {
      return res['data'];
    } else {
      return Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  void postPaymentMonthly(img, id) async {
    var getDate = DateTime.now();
    var date = DateFormat('yyyy-mm-dd').format(getDate);
    var data = FormData({
      "tanggal_bayar": date,
      "bukti_pembayaran": MultipartFile(File(img['bukti_pembayaran'][0].path),
          filename: img['bukti_pembayaran'][0].name)
    });

    final res = await _apiProvider.postPaymentMonthly(data, id);
    if (res['status'] == 200 || res['status'] == 201) {
      Get.snackbar('Info', '${res['message']}');
      navigatorKey.currentState!.pop();
    } else {
      Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  void deletedKost(id) async {
    final res = await _apiProvider.deletedKost(id);
    if (res['status'] == 200 || res['status'] == 201) {
      navigatorKey.currentState!.popAndPushNamed('/kost_list');
    } else {
      Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }
}
