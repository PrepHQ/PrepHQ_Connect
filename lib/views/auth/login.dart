import 'package:flutter/material.dart';
import 'package:prephq_connect/views/mentor/mentorscreen.dart';
import 'package:prephq_connect/views/student/studentscreen.dart';

import '../../common/databasecalls.dart';
import '../../registrationscreen.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  void dispose(){
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final emailField = TextField(
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      controller: _emailTextController,
    );

    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      controller: _passwordTextController,
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color.fromRGBO(75,209,160, 1),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          var _userInfoDoc = await getUser(_emailTextController.text);

          // TODO if _userInfoDoc is null (email not in database), prompt for registration

          if (_userInfoDoc['password'] == _passwordTextController.text){
            if(_userInfoDoc['user_type'] == 'student'){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentScreen()),
              );
            }
            else if(_userInfoDoc['user_type'] == 'mentor'){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MentorScreen()),
              );
             }
          }
          else{ // password is wrong
            // TODO prompt for re-entry of password
          }
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final registerButton = RaisedButton(
      key: Key('register_button'),
      child: Text('Register'),
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegistrationForm()),
        );
      },
      splashColor: Colors.grey,
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 155.0,
                      child: Image.asset(
                        "assets/images/prephq.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(height: 25.0,),
                    loginButton,
                    SizedBox(height: 65.0,),
                    registerButton,
                   
                   /*For demo purposes, these bypass the loginButton*/
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text('demo: S'),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => StudentScreen()),
                          );
                        },
                      ),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text('demo: M'),
                        onPressed: (){
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MentorScreen()),
                          );
                        },
                      ),
                   ],
                  ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
