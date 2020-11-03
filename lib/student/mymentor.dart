import 'package:flutter/material.dart';
import 'package:prephq_connect/common/chat.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class MyMentorScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          // TODO: Write function to generate these rows/cards
          // TODO: May need to refactor to use ListView.builder
          children: [
            Row(
              children: [
                MentorProfileCard(),
                MentorProfileCard(),
              ],
            ),
            Row(
              children: [
                MentorProfileCard(),
                MentorProfileCard(),
              ],
            ),
            Row(
              children: [
                MentorProfileCard(),
                MentorProfileCard(),
              ],
            ),
            Row(
              children: [
                MentorProfileCard(),
                MentorProfileCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MentorProfileCard extends StatelessWidget {
  MentorProfileCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: InkWell(
          splashColor: Color.fromRGBO(75, 209, 160, 1).withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Container(
            height: 250,
            child: Column(
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 65,
                  backgroundImage: AssetImage('images/caleb_headshot.jpg'),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //TODO: Make this not hardcoded.
                      Text(
                        'Caleb Werth',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0),
                      ),
                      Text(
                        'The University of Alabama',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontStyle: FontStyle.italic,
                            fontSize: 14.0),
                      ),
                      Text(
                        'Senior - Computer Science',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
