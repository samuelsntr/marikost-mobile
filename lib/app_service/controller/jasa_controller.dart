import 'package:get/get.dart';
import 'package:marikost/app_service/api_provider/api_provider.dart';

class JasaController extends GetxController {
  final ApiProvider _apiProvider = ApiProvider();

  Future getJasaList(jasa) async {
    var res = await _apiProvider.getJasaList(jasa);

    if (res['status'] == 200) {
      return res['data'];
    } else {
      return Get.snackbar('Error', 'Terjadi kesalahan');
    }
  }

  Future getSingleJasa(id) async {
    var res = await _apiProvider.getSingleJasa(id);

    if (res['status'] == 200) {
      return res['data'];
    } else {
      return Get.snackbar('Error', 'Terjadi kesalahan');
    }
  }
}
