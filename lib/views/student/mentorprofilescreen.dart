import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bookappointment.dart';
import '../chat/chatwindow.dart';
import '../chat/chat.dart';

class MentorProfileScreen extends StatelessWidget {
  const MentorProfileScreen(this.docMap);
  final Map<String, dynamic> docMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 120,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                    radius: 116,
                    backgroundColor: Colors.white,
                    backgroundImage: docMap.containsKey('profile_image_url')
                        ?
                        // If user has uploaded profile image, use it
                        NetworkImage(docMap['profile_image_url'])
                        :
                        // If user has not uploaded profile image, use default
                        NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/prephq-connect.appspot.com/o/profilePictures%2FnoPic.png?alt=media&token=0b5e58c4-9999-4245-b9b7-6438e23f3020')),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                docMap['first_name'] + ' ' + docMap['last_name'],
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
              Text(
                docMap['institution'],
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontStyle: FontStyle.italic,
                    fontSize: 24.0),
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
              Text(
                docMap['class'] + ' - ' + docMap['major'],
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                ),
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: 50,
                width: 200,
                child: RaisedButton.icon(
                  icon: Icon(Icons.calendar_today_rounded),
                  label: Text('Book Appointment'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WeeklyGridPage()),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 200,
                child: RaisedButton.icon(
                  icon: Icon(Icons.chat_bubble_outline),
                  label: Text('Chat With Mentor'),
                  onPressed: () {
                    createChannel("ggpepp", "test");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatWindow(
                              userID: "ggpepp",
                              userID2: "test",
                              channelID: "ggpepptest")),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
