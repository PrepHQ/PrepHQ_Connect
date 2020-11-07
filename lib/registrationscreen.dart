import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'common/databasecalls.dart';

class RegistrationForm extends StatefulWidget {
  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final _registrationFormKey = GlobalKey<FormState>();

  final _fNameRegTextController = TextEditingController();
  final _lNameRegTextController = TextEditingController();
  final _emailRegTextController = TextEditingController();
  final _passwordRegTextController = TextEditingController();
  final _password2RegTextController = TextEditingController();
  var _emailTaken = false;
  var _weakPassword = false;
  UserCredential userCred;

  @override
  void dispose(){
    _fNameRegTextController.dispose();
    _lNameRegTextController.dispose();
    _emailRegTextController.dispose();
    _passwordRegTextController.dispose();
    _password2RegTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration Screen"),
      ),
      body: Center(
        child: Align(
          alignment: Alignment.topCenter,
          child: Builder(
            builder: (context) => Form(
              key: _registrationFormKey,
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(36),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:<Widget>[
                          TextFormField(
                            controller: _fNameRegTextController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "First Name",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
                            validator: (firstName){
                              if(firstName.isEmpty){
                                return 'Please enter your first name.';
                              } else return null;
                            },
                          ),
                          SizedBox(height: 15,),
                          TextFormField(
                            controller: _lNameRegTextController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Last Name",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
                            validator: (lastName){
                              if(lastName.isEmpty){
                                return 'Please enter your last name.';
                              } else return null;
                            },
                          ),
                          SizedBox(height: 15,),
                          TextFormField(
                            controller: _emailRegTextController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "Email Address",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
                            validator: (email){
                              if(email.isEmpty){
                                return 'Please enter your email address.';
                              } else if (_emailTaken) {
                                _emailTaken = false;
                                return 'Email is already registered. Please try a different email.';
                              } else return null;
                            },
                          ),
                          SizedBox(height: 15,),
                          TextFormField(
                            controller: _passwordRegTextController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "Password",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
                            obscureText: true,
                            validator: (password1){
                              if(password1.isEmpty){
                                return 'Please create a password.';
                              } else if (_weakPassword){
                                _weakPassword = false;
                                return 'Password is weak. It must be at least 6 characters.';
                              } else return null;
                            },
                          ),
                          SizedBox(height: 15,),
                          TextFormField(
                            controller: _password2RegTextController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "Re-Enter Password",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
                            obscureText: true,
                            validator: (password2){
                              if(password2.isEmpty){
                                return 'Please re-enter the password.';
                              } else if (password2 != _passwordRegTextController.text){
                                return 'Passwords must match.';
                              } else return null;
                            },
                          ),
                          SizedBox(height: 15,),
                          RaisedButton(
                            onPressed: () async {
                              if(_registrationFormKey.currentState.validate()){
                                try {
                                  userCred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                      email: _emailRegTextController.text,
                                      password: _passwordRegTextController.text);
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'email-already-in-use') {
                                    // User with this email already exists in database
                                    _emailTaken = true;
                                    _emailRegTextController.clear();
                                  } else if (e.code == 'weak-password') {
                                    // Password is not strong enough
                                    _weakPassword = true;
                                    _passwordRegTextController.clear();
                                    _password2RegTextController.clear();
                                  }
                                  _registrationFormKey.currentState.validate();
                                  userCred = null;
                                }
                                if (userCred != null) {
                                  await registerNewUserStudent(
                                      userCred.user.uid,
                                      _fNameRegTextController.text,
                                      _lNameRegTextController.text);
                                  await FirebaseAuth.instance.signOut();
                                  Navigator.pop(context,);
                                }
                              }
                            },
                            child: Text('Register'),
                          ),
                        ]
                    ),
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