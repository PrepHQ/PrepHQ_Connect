import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prephq_connect/common/databasecalls.dart';
import 'home.dart';
import 'mymentor.dart';
import 'resources.dart';

/// This is the stateful widget that the main application instantiates.
class StudentScreen extends StatefulWidget {
  StudentScreen({Key key}) : super(key: key);

  @override
  _StudentScreenState createState() => _StudentScreenState();
}

/// This is the private State class that goes with StudentScreen.
class _StudentScreenState extends State<StudentScreen> {
  int _selectedIndex = 0;
  List<QueryDocumentSnapshot> mentorList;

  Future<void> buildMentorList () async {
    mentorList = await getAllMentors();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    buildMentorList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: [
          StudentHome(),
          MyMentorScreen(mentorList),
          StudResourcesScreen(),
        ],
        index: _selectedIndex,
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
