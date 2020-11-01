import 'package:flutter/material.dart';
import 'package:prephq_connect/views/user/mentor_profile_view.dart';

class MentorHome extends StatelessWidget {
  tmpFunction() {
    print('Function on Click Event Called.');
    // Put your code here, which you want to execute on onPress event.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, MentorProfileView.routeName);
                      },
                      child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.blueGrey,
                          backgroundImage: NetworkImage(
                              'https://www.cornwallbusinessawards.co.uk/wp-content/uploads/2017/11/dummy450x450-300x300.jpg')),
                    ),
                  ),
                ),
                Stack(children: [
                  
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome back, *Mentor*",
                          textScaleFactor: 2,
                          textAlign: TextAlign.justify,
                        ),
                        Text(
                          "These are your tools!",
                          textScaleFactor: 1,
                          textAlign: TextAlign.justify,
                        ),
                        RaisedButton(
                          child: Text(" Live Chat with Mentee "),
                          onPressed: tmpFunction,
                          color: Color(0xff33D2B0),
                          textColor: Colors.white,
                          splashColor: Colors.grey,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        ),
                        RaisedButton(
                          child: Text(" Schedule "),
                          onPressed: tmpFunction,
                          color: Color(0xff22CDF7),
                          textColor: Colors.white,
                          splashColor: Colors.grey,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        ),
                        RaisedButton(
                          child: Text(" List of Mentees "),
                          onPressed: tmpFunction,
                          color: Color(0xff096BD8),
                          textColor: Colors.white,
                          splashColor: Colors.grey,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        ),
                      ],
                    ),
                  )
                ]),
                Spacer(),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: new ButtonTheme.bar(
                      child: new ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new RaisedButton(
                            onPressed:
                                tmpFunction, //Should direct to My Account Screen
                            color: Color(0xff808786),
                            textColor: Colors.white,
                            splashColor: Colors.grey,
                            child: Text(" My Account "),
                          ),
                          new RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Color(0xff808786),
                            textColor: Colors.white,
                            splashColor: Colors.grey,
                            child: Text('Log Out'),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        ));
  }
}
