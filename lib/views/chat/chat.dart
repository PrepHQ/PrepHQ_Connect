import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

var client = Client("x9cr83dnu8sm", logLevel: Level.INFO);

void setupUser(String userID) async {
  var user = User(id: userID);
  client.setUser(user, client.devToken(userID));
}
void createChannel(String userID, String userID2) async
{
  String channelId = userID + userID2;
  var channel = client.channel("messaging", id: channelId, extraData: {
    "members": [userID, userID2]
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
