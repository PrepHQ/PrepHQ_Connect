import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'common/databasecalls.dart';
import 'student/studentscreen.dart';
import 'mentor/mentorscreen.dart';
import 'registrationscreen.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PrepHQ Connect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/student': (context) => StudentScreen(),
        '/mentor': (context) => MentorScreen(),
        '/register': (context) => RegistrationForm(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              String userType = await getUserType(userCred.user.uid);
              resetTextBoxes();
              if (userType == 'student') {
                Navigator.pushReplacementNamed(context, '/student');
              } else if (userType == 'mentor') {
                Navigator.pushReplacementNamed(context, '/mentor');
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
                          "images/prephq.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 45.0),
                      TextFormField(
                        controller: _emailTextController,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                        validator: (email) {
                          if (email.isEmpty) {
                            return 'Please enter your email address.';
                          } else if (_emailNoExist) {
                            _emailNoExist = false;
                            return 'Incorrect email. Try again or register a new account.';
                          } else
                            return null;
                        },
                      ),
                      SizedBox(height: 25.0),
                      TextFormField(
                        controller: _passwordTextController,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                        obscureText: true,
                        validator: (password) {
                          if (password.isEmpty) {
                            return 'Please enter your password.';
                          } else if (_wrongPassword) {
                            _wrongPassword = false;
                            return 'Incorrect password. Please try again.';
                          } else
                            return null;
                        },
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      loginButton,
                      SizedBox(
                        height: 25.0,
                      ),
                      RaisedButton(
                        key: Key('register_button'),
                        child: Text('Register'),
                        onPressed: () {
                          resetTextBoxes();
                          Navigator.pushNamed(context, '/register');
                        },
                        splashColor: Colors.grey,
                      ),

                      /*For demo purposes, these bypass the loginButton*/
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
                            onPressed: (){
                              _emailTextController.text = 'student1@prephqconnect.com';
                              _passwordTextController.text = 'p1p1p1';
                            }
                          ),
                          RaisedButton(
                              child: Text('Mentor4'),
                              onPressed: (){
                                _emailTextController.text = 'mentor4@prephqconnect.com';
                                _passwordTextController.text = 'p4p4p4';
                              }
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
