import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as md;
import 'student/studentscreen.dart';
import 'mentor/mentorscreen.dart';
import 'registrationscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PrepHQ Connect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'PrepHQ Login'),
    );
  }
}

class DemoButton extends RaisedButton{
  final theText;
  final nextScreen;
  final Function clearScreen;
  const DemoButton(this.theText, this.nextScreen, this.clearScreen);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Text(theText),
      onPressed: () {
        clearScreen();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextScreen),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _loginFormKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  var _emailNoExist = false;
  var _wrongPassword = false;

  void resetTextBoxes(){
    _loginFormKey.currentState.reset();
    _emailTextController.clear();
    _passwordTextController.clear();
  }

  @override
  void dispose(){
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color.fromRGBO(75,209,160, 1),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if(_loginFormKey.currentState.validate()) {
            // 10.0.2.2 is alias for 127.0.0.1 on machine that is hosting the emulator
            //var db = md.Db('mongodb://10.0.2.2:27017/prephq_connect'); // localhost
            var db = await md.Db.create("mongodb+srv://user_1:prephqcs495@prephq.kltwv.mongodb.net/prephq_connect?retryWrites=true&w=majority");
            await db.open();
            var coll = db.collection('users');
            var _userInfoDoc = await coll.findOne(
                md.where.eq('email', _emailTextController.text));
            await db.close();

            if (_userInfoDoc != null) { // User with this email exists in database
              if (_userInfoDoc['password'] == _passwordTextController.text) { // password is correct
                resetTextBoxes();
                if (_userInfoDoc['user_type'] == 'student') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentScreen()),
                  );
                }
                else if (_userInfoDoc['user_type'] == 'mentor') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MentorScreen()),
                  );
                }
              }
              else { // password is wrong
                _wrongPassword = true;
                _loginFormKey.currentState.validate();
                _passwordTextController.clear();
              }
            } else { // User with this email does not exist in database
              _emailNoExist = true;
              _loginFormKey.currentState.validate();
              _passwordTextController.clear();
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
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Email",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))),
                        validator: (email){
                          if(email.isEmpty){
                            return 'Please enter your email address.';
                          } else if (_emailNoExist){
                            _emailNoExist = false;
                            return 'Incorrect email. Try again or register a new account.';
                          } else return null;
                        },
                      ),
                      SizedBox(height: 25.0),
                      TextFormField(
                        controller: _passwordTextController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Password",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))),
                        obscureText: true,
                        validator: (password){
                          if(password.isEmpty){
                            return 'Please enter your password.';
                          } else if (_wrongPassword){
                            _wrongPassword = false;
                            return 'Incorrect password. Please try again.';
                          } else return null;
                        },
                      ),
                      SizedBox(height: 25.0,),
                      loginButton,
                      SizedBox(height: 25.0,),
                      RaisedButton(
                        child: Text('Register'),
                        onPressed: (){
                          resetTextBoxes();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegistrationForm()),
                          );
                        },
                        splashColor: Colors.grey,
                      ),



                     /*For demo purposes, these bypass the loginButton*/
                      SizedBox(height: 50,),
                      const Divider(color: Colors.black12, thickness: 1,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          DemoButton('demo: S', StudentScreen(), resetTextBoxes),
                          DemoButton('demo: M', MentorScreen(), resetTextBoxes),
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
