import 'package:stream_chat_flutter/stream_chat_flutter.dart';

final client = Client(
  'aab3hqy7m4yx',
  logLevel: Level.INFO,
);

void userCreate(String user) {
  client.updateUser(User(id: user, role: 'user'));
}
