import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

var clientVar = 'aab3hqy7m4yx';

class ChatView extends StatelessWidget {
  final Client client;

  ChatView(this.client);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     builder: (context, child) => StreamChat(
       client: client,
       child: child,
     ),
     home: ChannelListPage(),
    );
  }
}

class ChannelListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChannelsBloc(
        child: ChannelListView(
          filter: {
            'members': {
              '\$in': [StreamChat.of(context).user.id],
            }
          },

         channelPreviewBuilder: _channelPreviewBuilder,
          sort: [SortOption('last_message_at')],
          pagination: PaginationParams(
            limit: 20,
          ),
          channelWidget: ChannelPage(),
        ),
      ),
    );
  }

 Widget _channelPreviewBuilder(BuildContext context, Channel channel) {
   final lastMessage = channel.state.messages.reversed
       .firstWhere((message) => !message.isDeleted);
   final subtitle = (lastMessage == null ? "nothing yet" : lastMessage.text);
   final opacity = channel.state.unreadCount > .0 ? 1.0 : 0.5;
   return ListTile(
     leading: ChannelImage(
       channel: channel,
     ),
     title: ChannelName(
       channel: channel,
       textStyle:
           StreamChatTheme.of(context).channelPreviewTheme.title.copyWith(
                 color: Colors.black.withOpacity(opacity),
               ),
     ),
     subtitle: Text(subtitle),
     trailing: channel.state.unreadCount > 0
         ? CircleAvatar(
             radius: 10,
             child: Text(channel.state.unreadCount.toString()),
           )
         : SizedBox(),
   );
 }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessageListView(),
          ),
          MessageInput(),
        ],
      ),
    );
  }
}