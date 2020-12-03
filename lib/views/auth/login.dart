import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prephq_connect/common/databasecalls.dart';
import 'package:prephq_connect/views/mentor/mentorscreen.dart';
import 'package:prephq_connect/views/student/studentscreen.dart';
import 'package:prephq_connect/models/usermodels/user.dart' as theUser;
import '../../registrationscreen.dart';
import '../chat/chat.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _loginFormKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  var _emailNoExist = false;
  var _wrongPassword = false;
  UserCredential userCred;

  void resetTextBoxes() {
    _loginFormKey.currentState.reset();
    _emailTextController.clear();
    _passwordTextController.clear();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      controller: _emailTextController,
      validator: (email) {
        if (email.isEmpty) {
          return 'Please enter your email address.';
        } else if (_emailNoExist) {
          _emailNoExist = false;
          return 'Incorrect email. Try again or register a new account.';
        } else
          return null;
      },
    );

    final passwordField = TextFormField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      controller: _passwordTextController,
      validator: (password) {
        if (password.isEmpty) {
          return 'Please enter your password.';
        } else if (_wrongPassword) {
          _wrongPassword = false;
          return 'Incorrect password. Please try again.';
        } else
          return null;
      },
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color.fromRGBO(75, 209, 160, 1),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_loginFormKey.currentState.validate()) {
            try {
              userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _emailTextController.text,
                  password: _passwordTextController.text);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                // User with this email does not exist in database
                _emailNoExist = true;
              } else if (e.code == 'wrong-password') {
                // User exists, but password is wrong
                _wrongPassword = true;
              }
              _loginFormKey.currentState.validate();
              _passwordTextController.clear();
              userCred = null;
            }
            // Password is correct
            if (userCred != null) {
              theUser.id = userCred.user.uid;
              theUser.email = _emailTextController.text;
              var temp = await getUserInfo(theUser.id);
              theUser.name = temp['first_name'] + " " + temp['last_name'];
              String userType = await getUserType(theUser.id);
              await setUserImageURL(theUser.id);
              resetTextBoxes();
              await setupUser(theUser.id, theUser.name);
              if (userType == 'student') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => StudentScreen()),
                );
              } else if (userType == 'mentor') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MentorScreen()),
                );
              }
            }
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
      onPressed: () {
        resetTextBoxes();
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
          child: Builder(
            builder: (context) => Form(
              key: _loginFormKey,
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
                        SizedBox(
                          height: 25.0,
                        ),
                        loginButton,
                        SizedBox(
                          height: 50.0,
                        ),
                        registerButton,

                        /*For demo purposes, these pre-populate the login fields*/
                        SizedBox(
                          height: 50,
                        ),
                        const Divider(
                          color: Colors.black12,
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                                child: Text('Student1'),
                                onPressed: () {
                                  //setupUser("TjLjk4tnpqe1BOmZwGm3ritGZSC2",
                                      //"Caleb Werth");
                                  _emailTextController.text =
                                      'student1@prephqconnect.com';
                                  _passwordTextController.text = 'p1p1p1';
                                }),
                            RaisedButton(
                                child: Text('Mentor4'),
                                onPressed: () {
                                  //setupUser("TjLjk4tnpqe1BOmZwGm3ritGZSC2",
                                      //"Caleb Werth");
                                  _emailTextController.text =
                                      'mentor4@prephqconnect.com';
                                  _passwordTextController.text = 'p4p4p4';
                                })
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
