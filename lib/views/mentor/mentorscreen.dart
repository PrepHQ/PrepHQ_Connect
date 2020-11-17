import 'package:flutter/material.dart';
import 'home.dart';

/// This is the stateful widget that the main application instantiates.
class MentorScreen extends StatefulWidget {
  MentorScreen({Key key}) : super(key: key);

  @override
  _MentorScreenState createState() => _MentorScreenState();
}

/// This is the private State class that goes with MentorScreen.
class _MentorScreenState extends State<MentorScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    MentorHome(),
    Text("Second Screen for Mentor", textScaleFactor: 2),
    Text("Third Screen for Mentor", textScaleFactor: 2),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Mentor Screen"),
      //   backgroundColor: Color.fromRGBO(75, 209, 160, 1),
      // ),
      body: IndexedStack(
        children: [
          MentorHome(),
          Text("Second Screen for Mentor", textScaleFactor: 2),
          Text("Third Screen for Mentor", textScaleFactor: 2),
        ],
        index: _selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'My Mentee',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Resources',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(75, 209, 160, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}
