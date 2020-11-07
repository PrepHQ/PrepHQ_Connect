import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
          )      ),
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
          print('Card tapped.');
        },
        child: Container(
          height: 250,
          child: Column(
            children: [
              SizedBox(height: 10),
              CircleAvatar(
                radius: 60,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(docMap['profile_image_url']),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(docMap['first_name'] + ' ' + docMap['last_name'], style: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 17.0
                    ),),
                    Text(docMap['institution'], style: TextStyle(
                        fontFamily: 'Montserrat', fontStyle: FontStyle.italic, fontSize: 14.0
                    ),),
                    Text(docMap['class'] + ' - ' + docMap['major'], style: TextStyle(
                      fontFamily: 'Montserrat', fontSize: 13.0,
                    ),),
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