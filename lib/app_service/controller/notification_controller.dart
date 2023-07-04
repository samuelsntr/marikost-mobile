import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/api_provider/api_provider.dart';

class NotificationController extends GetxController {
  final ApiProvider _apiProvider = ApiProvider();

  Future getNotifikasiIdUser() async {
    const storage = FlutterSecureStorage();
    final String? getUser = await storage.read(key: 'user');
    var user = await jsonDecode(getUser!);

    final res = await _apiProvider.getNotification(user['id']);

    if (res['status'] == 200) {
      return res['data'];
    } else {
      return Get.snackbar('Error', 'Error Data');
    }
  }
}
