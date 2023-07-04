import 'package:get/get.dart';

class ApiProvider {
  final urlLink = 'https://api.marikost.com';
  final GetConnect connect = GetConnect(timeout: const Duration(seconds: 50));

  Future login(data) async {
    final url = '$urlLink/login';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future register(data) async {
    final url = '$urlLink/register';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future forgotPaswordEmail(data) async {
    final url = '$urlLink/user/send-otp';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future checkOTPForgotPassword(data) async {
    final url = '$urlLink/user/check-otp';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future forgotPassword(data, id) async {
    final url = '$urlLink/user/password/$id';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future checkOTP(data) async {
    final url = '$urlLink/register/check-otp';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future resendOTP(data) async {
    final url = '$urlLink/register/resend-otp';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getUserAkun(id) async {
    final url = '$urlLink/user/$id';
    final res = await connect.get(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future updatUserAkun(data, id) async {
    final url = '$urlLink/user/update/$id';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future addKost(data) async {
    final url = '$urlLink/kost/store';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future editKost(data, id) async {
    final url = '$urlLink/kost/update/$id';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getAllPemilikKost(id) async {
    final url = '$urlLink/kost/pemilik/$id';
    final res = await connect.get(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getOneKost(id) async {
    final url = '$urlLink/kost/$id';
    final res = await connect.get(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getAllKost() async {
    final url = '$urlLink/kost';
    final res = await connect.get(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future deletedKost(id) async {
    final url = '$urlLink/kost/delete/$id';
    final res = await connect.delete(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getKamarByIdKost(id) async {
    final url = '$urlLink/kamar/kost/$id';
    final res = await connect.get(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getKamarByIdPemilik(id) async {
    final url = '$urlLink/kamar/pemilik/$id';
    final res = await connect.get(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getKamarByIdKamar(id) async {
    final url = '$urlLink/kamar/$id';
    final res = await connect.get(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getImageKamarByIdKamar(id) async {
    final url = '$urlLink/tampilan/kamar/$id';
    final res = await connect.get(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getFasilitasKamarByIdKamar(id) async {
    final url = '$urlLink/fasilitas/kost/$id';
    final res = await connect.get(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future addKamarKost(data) async {
    final url = '$urlLink/kamar/store';
    final res = await connect.post(url, data);
    if (res.statusCode == 200 || res.statusCode == 201) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body);
    }
  }

  Future editKamarKost(data, id) async {
    final url = '$urlLink/kamar/update/$id';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future deleteKamarKost(id) async {
    final url = '$urlLink/kamar/delete/$id';
    final res = await connect.delete(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getPeraturanKost(id) async {
    final url = '$urlLink/peraturan/kost/$id';
    final res = await connect.get(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future addPeraturanKost(data) async {
    final url = '$urlLink/peraturan/store';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future editPeraturanKost(data, id) async {
    final url = '$urlLink/peraturan/update/$id';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body);
    }
  }

  Future getOnePeraturanKost(id) async {
    final url = '$urlLink/peraturan/$id';
    final res = await connect.get(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future deletePeraturanKost(id) async {
    final url = '$urlLink/peraturan/delete/$id';
    final res = await connect.delete(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body);
    }
  }

  Future getNotification(id) async {
    final url = '$urlLink/notifikasi/$id';
    final res = await connect.get(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getOneBooking(id) async {
    final url = '$urlLink/booking/$id';
    final res = await connect.get(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getOnePayment(id) async {
    final url = '$urlLink/pembayaran/$id';
    final res = await connect.get(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future addBooking(data) async {
    final url = '$urlLink/booking/store';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future confirmBooking(data, id) async {
    final url = '$urlLink/booking/confirm/$id';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future payBooking(data, id) async {
    final url = '$urlLink/pembayaran/payment/$id';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future confirmPayment(data, id) async {
    final url = '$urlLink/pembayaran/confirm/$id';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getPenghuni(id) async {
    final url = '$urlLink/penghuni/user/$id';
    final res = await connect.get(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getOnePenghuni(id) async {
    final url = '$urlLink/penghuni/$id';
    final res = await connect.get(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getSearchKost(search) async {
    final url = '$urlLink/kost/cari';
    final res = await connect.post(url, search);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getLocList() async {
    final url = '$urlLink/kost/area/filter';
    final res = await connect.get(url);

    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getAreaList(data) async {
    final url = '$urlLink/kost/area/search';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getAreaFilterList(data) async {
    final url = '$urlLink/kost/filter/area';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getJasaList(jasa) async {
    final url = '$urlLink/pelayanan-jasa/kategori/$jasa';
    final res = await connect.get(url);

    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getSingleJasa(id) async {
    final url = '$urlLink/pelayanan-jasa/$id';
    final res = await connect.get(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future requestIklan(data) async {
    final url = '$urlLink/iklan/request';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getIklanList() async {
    final url = '$urlLink/iklan';
    final res = await connect.get(url);

    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getSingleIklanList(id) async {
    final url = '$urlLink/iklan/$id';
    final res = await connect.get(url);

    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future pembayaranIklan(id, data) async {
    final url = '$urlLink/iklan/payment/$id';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getUnitSekitarList(id) async {
    final url = '$urlLink/unit-sekitar/kost/$id';
    final res = await connect.get(url);

    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getOneUnitSekitar(id) async {
    final url = '$urlLink/unit-sekitar/$id';
    final res = await connect.get(url);

    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future addUnitSekitar(data) async {
    final url = '$urlLink/unit-sekitar/store';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future updateUnitSekitar(data, id) async {
    final url = '$urlLink/unit-sekitar/update/$id';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future deleteUnitSekitar(id) async {
    final url = '$urlLink/unit-sekitar/delete/$id';
    final res = await connect.delete(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future addReview(data) async {
    final url = '$urlLink/review/store';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future addReviewApk(data) async {
    final url = '$urlLink/review/apk/store';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getReviewKostId(id) async {
    final url = '$urlLink/review/kost/$id';
    final res = await connect.get(url);

    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getReviewApk(id) async {
    final url = '$urlLink/review/apk/$id';
    final res = await connect.get(url);

    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future getPaymentMontly(id) async {
    final url = '$urlLink/pembayaran/payment/get/monthly/$id';
    final res = await connect.get(url);

    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }

  Future postPaymentMonthly(data, id) async {
    final url = '$urlLink/pembayaran/payment/monthly/$id';
    final res = await connect.post(url, data);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body);
    }
  }

  Future deleteAccount(id) async {
    final url = '$urlLink/user/delete/$id';
    final res = await connect.delete(url);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.statusText.toString());
      return Future.error(res.body['message']);
    }
  }
}
