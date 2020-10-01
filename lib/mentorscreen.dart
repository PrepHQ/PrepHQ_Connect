import 'package:flutter/material.dart';

class MentorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          title: Text("Mentor"),
          backgroundColor: Color.fromRGBO(75,209,160, 1),
        ),
        body: Center
          (

          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children:[
                Text(
                  "Mentor Name Here",
                  textScaleFactor: 2,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  "Other Stuff",
                  textScaleFactor: 2,
                  textAlign: TextAlign.justify,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Log Out'),
                ),
              ]
          ),
        )
    );
  }
}