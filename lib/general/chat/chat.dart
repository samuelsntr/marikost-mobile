import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:marikost/app_service/controller/chat_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ChatSystem extends StatefulWidget {
  const ChatSystem({super.key, required this.chatData});

  final chatData;
  @override
  State<ChatSystem> createState() => _ChatSystemState();
}

class _ChatSystemState extends State<ChatSystem> {
  final supabase = Supabase.instance.client;
  var uuid = const Uuid();
  // Stream<List<dynamic>> _streamMessages;
  List<types.Message> _messages = [];
  var _user;
  var dataId = {};
  final ChatController _chatController = Get.put(ChatController());

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _user = types.User(
          id: widget.chatData['id_user'].toString(),
          firstName: widget.chatData['user_name']);

      dataId = widget.chatData;
    });
    loadMessage();
    var idUserChat = (dataId['id_user']);
    var idSenderChat = (dataId['id_sender']);
    supabase.channel('public:chat').on(
        RealtimeListenTypes.postgresChanges,
        ChannelFilter(
          event: '*',
          schema: 'public',
          table: 'chat',
        ), (payload, [ref]) {
      var update = payload['new'];
      if (update['id_user'] == idUserChat ||
          update['id_user'] == idSenderChat &&
              update['id_sender'] == idSenderChat ||
          update['id_sender'] == idUserChat) {
        Map<String, dynamic> send = {
          "author": {
            "id": update['id_user'].toString(),
          },
          "createdAt":
              DateTime.parse(update['created_at']).millisecondsSinceEpoch,
          "id": update['uuid'],
          "text": update['message'],
          "type": "text"
        };
        var convert = types.Message.fromJson(send);
        setState(() {
          _messages.insert(0, convert);
        });
      }
    }).subscribe();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    supabase.removeAllChannels();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: ListTile(
            leading: CircleAvatar(
              foregroundImage: widget.chatData['sender_foto'] != null
                  ? NetworkImage(
                      'https://api.marikost.com/storage/users/${widget.chatData['sender_foto']}')
                  : null,
              child: widget.chatData['sender_foto'] == null
                  ? const Icon(
                      Icons.person,
                      color: Colors.black,
                    )
                  : null,
            ),
            title: Text(widget.chatData['sender_name']),
          ),
        ),
        body: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Chat(
                  theme: const DefaultChatTheme(
                      primaryColor: Color(0xFFFFB82E),
                      inputBackgroundColor: Colors.white,
                      inputTextColor: Colors.black,
                      inputTextDecoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                      )),
                  messages: _messages,
                  onSendPressed: _handleSendMessage,
                  user: _user);
            }));
  }

  void _handleSendMessage(types.PartialText message) {
    var id = uuid.v4();
    var data = {
      "uuid": id,
      "message": message.text,
      "id_user": dataId['id_user'],
      "id_sender": dataId['id_sender']
    };
    _chatController.sendMessage(data);
  }

  void loadMessage() async {
    var loadData = [];
    var idUserChat = (dataId['id_user']);
    var idSenderChat = (dataId['id_sender']);
    var response = await supabase
        .from('chat')
        .select()
        .or('id_user.eq.$idUserChat,id_user.eq.$idSenderChat')
        .or('id_sender.eq.$idUserChat,id_sender.eq.$idSenderChat')
        .order('created_at');
    response.map((data) {
      Map<String, dynamic> send = {
        "author": {
          "id": data['id_user'].toString(),
        },
        "createdAt": DateTime.parse(data['created_at']).millisecondsSinceEpoch,
        "id": data['uuid'],
        "text": data['message'],
        "type": "text"
      };
      return loadData.add(send);
    }).toList();

    final message = loadData
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();
    setMessage(mounted, message);
  }

  void setMessage(mounted, data) {
    if (mounted) {
      setState(() {
        _messages = data;
      });
    } else {
      setState(() {});
    }
  }
}
