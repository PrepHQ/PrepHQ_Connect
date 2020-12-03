import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'mentorprofilescreen.dart';

class MyMentorScreen extends StatelessWidget {
  final List<QueryDocumentSnapshot> mentorList;
  const MyMentorScreen(this.mentorList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView.builder(
          itemCount: mentorList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index){
            return new MentorProfileCard(mentorList[index].data());
          },
        )
      ),
    );
  }
}

class MentorProfileCard extends StatelessWidget {
  const MentorProfileCard(this.docMap);
  final Map<String, dynamic> docMap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Color.fromRGBO(75, 209, 160, 1).withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MentorProfileScreen(docMap)),
          );
        },
        child: Container(
          height: 250,
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: Column(
            children: [
              CircleAvatar(radius: 60, backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 58,
                    backgroundColor: Colors.white,
                    backgroundImage: docMap.containsKey('profile_image_url') ?
                    // If user has uploaded profile image, use it
                    NetworkImage(docMap['profile_image_url']) :
                    // If user has not uploaded profile image, use default
                    NetworkImage('https://firebasestorage.googleapis.com/v0/b/prephq-connect.appspot.com/o/profilePictures%2FnoPic.png?alt=media&token=0b5e58c4-9999-4245-b9b7-6438e23f3020')
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(docMap['first_name'] + ' ' + docMap['last_name'],
                      style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 17.0),
                      softWrap: false, overflow: TextOverflow.fade,),
                    Text(docMap['institution'],
                      style: TextStyle(fontFamily: 'Montserrat', fontStyle: FontStyle.italic, fontSize: 14.0),
                      softWrap: false, overflow: TextOverflow.fade,),
                    Text(docMap['class'] + ' - ' + docMap['major'],
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.0,),
                      softWrap: false, overflow: TextOverflow.fade),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}