import 'package:flutter/material.dart';

class MyMentorScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // TODO: write function to generate these rows/cards
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
                      Text('Caleb Werth', style: TextStyle(
                          fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 17.0
                      ),),
                      Text('The University of Alabama', style: TextStyle(
                          fontFamily: 'Montserrat', fontStyle: FontStyle.italic, fontSize: 14.0
                      ),),
                      Text('Senior - Computer Science', style: TextStyle(
                        fontFamily: 'Montserrat', fontSize: 13.0,
                      ),),
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