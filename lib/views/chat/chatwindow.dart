import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'chat.dart';

class ChatWindow extends StatelessWidget {
  final String userID;
  final String userID2;
  final String channelID;
  ChatWindow({this.userID, this.userID2, this.channelID});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, child) {
          return StreamChat(child: child, client: client);
        },
        home: StreamChannel(
          channel: client.channel("messaging", id: channelID, extraData: {"members":[userID, userID2]}),
          child: ChannelPage(),
        ));
  }
}
