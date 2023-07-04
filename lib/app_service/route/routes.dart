import 'package:flutter/material.dart';
import 'package:marikost/general/akun/edit_akun.dart';
import 'package:marikost/general/akun/profil_akun.dart';
import 'package:marikost/general/chat/chat.dart';
import 'package:marikost/general/forgot_password/change_password.dart';
import 'package:marikost/general/forgot_password/send_email.dart';
import 'package:marikost/general/mariHelp/help_desk.dart';
import 'package:marikost/general/mariHelp/mariHelp.dart';
import 'package:marikost/general/otp/otp.dart';
import 'package:marikost/general/otp/otp_forgot_password.dart';
import 'package:marikost/general/page_view/view_image.dart';
import 'package:marikost/general/privacy/privacy_terms_page.dart';
import 'package:marikost/main.dart';
import 'package:marikost/main_page.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/home_page/add_new_kost.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/home_page/kelola_kost/iklan/request_iklan.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/home_page/kelola_kost/kamar/add_kamar.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/home_page/kelola_kost/edit_kost.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/home_page/kelola_kost/kamar/edit_kamar.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/home_page/kelola_kost/kamar/list_kamar.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/home_page/kelola_kost/peraturan/add_peraturan.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/home_page/kelola_kost/peraturan/edit_peraturan.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/home_page/kelola_kost/peraturan/list_peraturan.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/home_page/kelola_kost/profil_kost.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/home_page/kelola_kost/review/list_review.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/home_page/kelola_kost/unit_sekitar/add_unit_sekitar.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/home_page/kelola_kost/unit_sekitar/edit_unit_sekitar.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/home_page/kelola_kost/unit_sekitar/list_unit_sekitar.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/home_page/map_new_kost.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/home_page/kelola_kost/user_kost_list.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/manajemen/info_kamar_management.dart';
import 'package:marikost/manajemen/dashboard/bottomMenu/notifikasi/detail_notifikasi_manajemen.dart';
import 'package:marikost/manajemen/dashboard/dashboard_page.dart';
import 'package:marikost/manajemen/login/login_register.dart';
import 'package:marikost/manajemen/review_app/review_app.dart';
import 'package:marikost/penghuni/cari_kost/bottom_nav_pencari.dart';
import 'package:marikost/penghuni/cari_kost/dashboard_pencari.dart';
import 'package:marikost/penghuni/dashboard_penghuni.dart';
import 'package:marikost/penghuni/kost_details/kamar_details.dart';
import 'package:marikost/penghuni/kost_details/kost_details.dart';
import 'package:marikost/penghuni/kost_details/review_kost.dart';
import 'package:marikost/penghuni/kost_saya/add_review_kost.dart';
import 'package:marikost/penghuni/kost_saya/details_kost_saya.dart';
import 'package:marikost/penghuni/kost_saya/montly_payment.dart';
import 'package:marikost/penghuni/login_penghuni/login_register_penghuni.dart';
import 'package:marikost/penghuni/menu/jasa/jasa_details.dart';
import 'package:marikost/penghuni/menu/jasa/jasa_list.dart';
import 'package:marikost/penghuni/notifikasi/details_notifikasi_penghuni.dart';
import 'package:marikost/penghuni/search_kost.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MyHomePage());
      case '/main_page':
        return MaterialPageRoute(builder: (_) => MainPage());
      case '/otp':
        return MaterialPageRoute(builder: (_) => OTPCode(email: arg));
      case '/forgot_password':
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case '/change_password':
        return MaterialPageRoute(builder: (_) => ChangePassword(id: arg));
      case '/otp_forgot':
        return MaterialPageRoute(builder: (_) => OTPForgotPassword(email: arg));
      case '/login_manajemen':
        return MaterialPageRoute(
            builder: (_) => const LoginRegisterManajemenKost(selectedPage: 0));
      case '/login_penghuni':
        return MaterialPageRoute(
            builder: (_) => const LoginRegisterPenghuni(selectedPage: 1));
      case '/dashboard_manajemen':
        return MaterialPageRoute(
            builder: (_) => const DashboardManajemenKost());
      case '/dashboard_pencari':
        return MaterialPageRoute(builder: (_) => const PencariKost());
      case '/dashboard_penghuni':
        return MaterialPageRoute(builder: (_) => const DashboardPenghuni());
      case '/kost/add':
        return MaterialPageRoute(builder: (_) => const AddNewKost());
      case '/kost/add_map':
        return MaterialPageRoute(builder: (_) => const MapNewKost());
      case '/kost_search/details':
        return MaterialPageRoute(builder: (_) => KostDetails(kost: arg));
      case '/kost_search/kost/review':
        return MaterialPageRoute(builder: (_) => ReviewKostUser(kostId: arg));
      case '/kost_search/kamar/details':
        return MaterialPageRoute(builder: (_) => KamarDetails(idKamar: arg));
      case '/kost_list':
        return MaterialPageRoute(builder: (_) => const RoomKostList());
      case '/jasa':
        return MaterialPageRoute(builder: (_) => JasaList(dataJasa: arg));
      case '/jasa/details':
        return MaterialPageRoute(builder: (_) => DetailJasa(jasa: arg));
      case '/kost/kamar':
        return MaterialPageRoute(
            builder: (_) => ListKelolaKostKamar(idKost: arg));
      case '/kost/profile':
        return MaterialPageRoute(builder: (_) => ProfilKost(idKost: arg));
      case '/kost/edit':
        return MaterialPageRoute(
            builder: (_) => EditKostManajemen(idKost: arg));
      case '/kost/kamar/add':
        return MaterialPageRoute(builder: (_) => AddKamarKost(idKost: arg));
      case '/kost/kamar/edit':
        return MaterialPageRoute(builder: (_) => EditKamarKost(idKamar: arg));
      case '/kost/peraturan':
        return MaterialPageRoute(
            builder: (_) => ListPeraturanKost(idKost: arg));
      case '/kost/unit':
        return MaterialPageRoute(builder: (_) => ListUnitSekitar(idKost: arg));
      case '/kost/unit/add':
        return MaterialPageRoute(builder: (_) => AddUnitSekitar(idKost: arg));
      case '/kost/unit/edit':
        return MaterialPageRoute(builder: (_) => EditUnitSekitar(idUnit: arg));
      case '/kost/peraturan/add':
        return MaterialPageRoute(builder: (_) => AddPeraturanKost(idKost: arg));
      case '/kost/peraturan/edit':
        return MaterialPageRoute(
            builder: (_) => EditdanHapusPeraturanKost(idPeraturan: arg));
      case '/manajemen/kamar':
        return MaterialPageRoute(
            builder: (_) => InfoKamarManajemen(idKamar: arg));
      case '/manajemen/notif/details':
        return MaterialPageRoute(
            builder: (_) => DetailNotifikasiManajemen(notif: arg));
      case '/penghuni/notif/details':
        return MaterialPageRoute(
            builder: (_) => DetailPenghuniNotifikasi(notif: arg));
      case '/kost_saya/details':
        return MaterialPageRoute(builder: (_) => DetailKostSaya(info: arg));
      case '/kost/cari':
        return MaterialPageRoute(builder: (_) => SearchKost(search: arg));
      case '/akun/profile':
        return MaterialPageRoute(builder: (_) => ProfilAkun(idUser: arg));
      case '/akun/profile/edit':
        return MaterialPageRoute(builder: (_) => EditAkun(profil: arg));
      case '/mariHelp':
        return MaterialPageRoute(builder: (_) => const MariHelp());
      case '/help_desk':
        return MaterialPageRoute(builder: (_) => const HelpDesk());
      case '/terms_privacy':
        return MaterialPageRoute(builder: (_) => const PrivacyTermsPage());
      case '/chat':
        return MaterialPageRoute(builder: (_) => ChatSystem(chatData: arg));
      case '/request_iklan':
        return MaterialPageRoute(builder: (_) => RequestIklan(id: arg));
      case '/review_kost':
        return MaterialPageRoute(builder: (_) => ListReviewKost(kost: arg));
      case '/review_kost/add':
        return MaterialPageRoute(builder: (_) => AddReviewKost(kost: arg));
      case '/payment/kost':
        return MaterialPageRoute(builder: (_) => PaymentKost(idPenghuni: arg));
      case '/review_app':
        return MaterialPageRoute(builder: (_) => ReviewApp(idUser: arg));
      case '/view/image':
        return MaterialPageRoute(
            builder: (_) => ViewImage(
                  imageUrl: arg,
                ));
      default:
        return _errorPage();
    }
  }

  static Route<dynamic> _errorPage() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: Center(
                  child: Column(
                children: const [
                  Text(
                    'ERROR 404',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  Text('Halaman tidak ditemukan!')
                ],
              )),
            ));
  }
}
