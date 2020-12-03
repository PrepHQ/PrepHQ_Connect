import 'package:flutter/material.dart'; 
import 'package:prephq_connect/views/chat/chat.dart'; 
import 'package:stream_chat_flutter/stream_chat_flutter.dart'; 
 
class MentorChatScreen extends StatelessWidget { 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      builder: (context, child) { 
        return StreamChat(child: child, client: client); 
      }, 
      home: ChannelListPage(), 
    ); 
  } 
}