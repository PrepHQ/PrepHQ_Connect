import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

var client = Client("x9cr83dnu8sm", logLevel: Level.INFO);

void setupUser() async {
  var user = User(id: "ggpepp", extraData: {"name": "Garrett Peppers"});
  var test = User(id: "test", extraData: {"name": "developer"});
  client.setUser(test, client.devToken("test"));
  var channel = client.channel("messaging", id: "test", extraData: {
    "members": ["ggpepp", "test"]
  });
  await channel.create();
}

class ChannelListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChannelsBloc(
        child: ChannelListView(
          sort: [SortOption("last_message_at")],
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
      resizeToAvoidBottomInset: false,
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
