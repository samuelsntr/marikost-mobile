import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:marikost/app_service/api_provider/api_provider.dart';
import 'package:marikost/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatController extends GetxController {
  final supabase = Supabase.instance.client;
  final ApiProvider _apiProvider = ApiProvider();

  Future getListChatContact(id) async {
    try {
      var dataKontak = [];
      final response = await supabase.from('kontak').select().eq('id_user', id);
      dataKontak = response;
      return dataKontak;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  List<Map<String, dynamic>> getChatData(id, idSender) {
    try {
      var dataChat = <Map<String, dynamic>>[];
      final res = supabase
          .from('chat')
          .stream(primaryKey: ['id'])
          .order('created_at')
          .eq('id_user', id)
          .eq('id_sender', idSender);

      res.listen((event) {
        print(event);
        dataChat = event;
      });
      return dataChat;
    } catch (e) {
      throw e;
    }
  }

  void sendMessage(data) async {
    var message = {
      "uuid": data['uuid'],
      "message": data['message'],
      "id_user": data['id_user'],
      "id_sender": data['id_sender'],
    };

    await supabase.from('chat').insert(message);
  }

  void addContact(idUser, idSender) async {
    var check = await supabase.from('kontak').select().or(
        'and(id_user.eq.${idUser},id_sender.eq.${idSender}),and(id_user.eq.${idSender},id_sender.eq.${idUser})');
    var user = await _apiProvider.getUserAkun(idUser);
    var sender = await _apiProvider.getUserAkun(idSender);
    if (check.length != 0) {
      navigatorKey.currentState!.pushNamed('/chat', arguments: {
        "id_user": user['data']['id'],
        "user_name": user['data']['name'],
        "id_sender": sender['data']['id'],
        "sender_name": sender['data']['name'],
        "sender_foto": sender['data']['foto_profile'],
      });
    } else {
      var add = [
        {"id_user": idUser, "id_sender": idSender},
        {
          "id_user": idSender,
          "id_sender": idUser,
        }
      ];
      await supabase.from('kontak').insert(add);
      navigatorKey.currentState!.pushNamed('/chat', arguments: {
        "id_user": user['data']['id'],
        "user_name": user['data']['name'],
        "id_sender": sender['data']['id'],
        "sender_name": sender['data']['name'],
        "sender_foto": sender['data']['foto_profile'],
      });
    }
  }
}
