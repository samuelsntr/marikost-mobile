import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/api_provider/api_provider.dart';

class PenghuniController extends GetxController {
  final ApiProvider _apiProvider = ApiProvider();
  Future getUserPenghuni() async {
    const storage = FlutterSecureStorage();
    final String? getUser = await storage.read(key: 'user');
    var user = await jsonDecode(getUser!);
    final res = await _apiProvider.getPenghuni(user['id']);
    if (res['status'] == 200) {
      return res['data'];
    } else {
      return Get.snackbar('Error', 'Error Data');
    }
  }

  Future getOnePenghuni(id) async {
    final res = await _apiProvider.getOnePenghuni(id);
    if (res['status'] == 200) {
      return res['data'];
    } else {
      return Get.snackbar('Error', 'Error Data');
    }
  }
}
