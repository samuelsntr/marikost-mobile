import 'package:get/get.dart';
import 'package:marikost/app_service/api_provider/api_provider.dart';
import 'package:marikost/main.dart';

class UnitSekitarController extends GetxController {
  final ApiProvider _apiProvider = ApiProvider();

  Future getUnitSekitarKost(id) async {
    final res = await _apiProvider.getUnitSekitarList(id);

    if (res['status'] == 200 || res['status'] == 201) {
      return res['data'];
    } else {
      return Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  Future getSingleUnitSekitar(id) async {
    final res = await _apiProvider.getOneUnitSekitar(id);

    if (res['status'] == 200 || res['status'] == 201) {
      return res['data'];
    } else {
      return Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  void addUnitSekitar(id, data, context) async {
    var post = {
      "id_kost": id,
      "nama_unit": data['nama_unit'],
      "jarak_unit": data['jarak_unit'],
    };

    final res = await _apiProvider.addUnitSekitar(post);
    if (res['status'] == 200 || res['status'] == 201) {
      navigatorKey.currentState!.pop(context);
    } else {
      Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  void updateUnitSekitar(id, data, idKost, context) async {
    var post = {
      "id_kost": idKost,
      "nama_unit": data['nama_unit'],
      "jarak_unit": data['jarak_unit'],
      "_method": "PUT"
    };

    final res = await _apiProvider.updateUnitSekitar(post, id);
    if (res['status'] == 200 || res['status'] == 201) {
      navigatorKey.currentState!.pop(context);
    } else {
      Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  void deleteUnitSekitar(id) async {
    final res = await _apiProvider.deleteUnitSekitar(id);
    if (res['status'] == 200 || res['status'] == 201) {
      Get.snackbar('${res['status']}', '${res['message']}');
    } else {
      Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }
}
