import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as md;

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
                                // 10.0.2.2 is alias for 127.0.0.1 on machine that is hosting the emulator
                                var db = md.Db('mongodb://10.0.2.2:27017/prephq_connect'); // localhost
                                //var db = await md.Db.create("mongodb+srv://user_1:prephqcs495@prephq.kltwv.mongodb.net/prephq_connect?retryWrites=true&w=majority");
                                await db.open();
                                var coll = db.collection('users');
                                await coll.insert({
                                  'email': _emailRegTextController.text,
                                  'password': _passwordRegTextController.text,
                                  'user_type': 'student',
                                  'first_name': _fNameRegTextController.text,
                                  'last_name': _lNameRegTextController.text
                                });
                                await db.close();
                                Navigator.pop(context,);
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