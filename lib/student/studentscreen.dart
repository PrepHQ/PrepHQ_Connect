import 'package:flutter/material.dart';
import 'package:prephq_connect/common/chat.dart';
import 'home.dart';
import 'mymentor.dart';
import 'resources.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

/// This is the stateful widget that the main application instantiates.
class StudentScreen extends StatefulWidget {
  final Client client;

  StudentScreen(this.client);

  @override
  _StudentScreenState createState() => _StudentScreenState(client);
}

/// This is the private State class that goes with StudentScreen.
class _StudentScreenState extends State<StudentScreen> {
  final Client client;
  int _selectedIndex = 0;
  List<Widget> _widgetOptions;
  
  _StudentScreenState(this.client)
      : _widgetOptions = <Widget>[
    StudentHome(),
    MyMentorScreen(),
    ChatView(client)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text("My Mentor"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            title: Text("Resources"),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(75, 209, 160, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}
