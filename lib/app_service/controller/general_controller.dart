import 'package:get/get.dart';
import 'package:marikost/app_service/api_provider/api_provider.dart';
import 'package:marikost/main.dart';

class GeneralController extends GetxController {
  final ApiProvider _apiProvider = ApiProvider();

  void rateOurApp(val, rate, id) async {
    var data = {"id_user": id, "grade": rate, "komentar": val['komentar']};

    final res = await _apiProvider.addReviewApk(data);
    if (res['status'] == 200 || res['status'] == 201) {
      Get.snackbar('Info', 'Sukses memberikan review aplikasi');
      navigatorKey.currentState!.pop();
    } else {
      Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }

  Future checkReview(id) async {
    final res = await _apiProvider.getReviewApk(id);
    if (res['status'] == 200 || res['status'] == 201) {
      return res['data'];
    } else {
      Get.snackbar('error: ${res['status']}', '${res['message']}');
    }
  }
}
