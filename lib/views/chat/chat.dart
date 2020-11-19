import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

var client = Client('6k9d3ndm8wq2');

Client setupUser() {
  var user = User(id: 'ggpepp');
  client.updateUser(user);
  client.setUser(user, client.devToken('ggpepp'));
  var channel = client.channel("messaging", id:"test");
  channel.create();
  channel.watch();
  return client;
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
          sort: [SortOption('last_message_at')],
          pagination: PaginationParams(
            limit: 20,
          ),
          channelWidget: ChannelPage(),
        ),
      ),
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
