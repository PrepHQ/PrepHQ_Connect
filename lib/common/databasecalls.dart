import 'package:cloud_firestore/cloud_firestore.dart';

/// Returns a document of the user's information from the Firestore database.
Future<Map<String, dynamic>> getUser(String username) async {
  Map<String, dynamic> userInfo;
  QuerySnapshot tempQ =  await FirebaseFirestore.instance
    .collection('testUsers')
    .where('email', isEqualTo: username)
    .get();
  userInfo = tempQ.docs.first.data();
  return userInfo;
}

/// Registers a new user on the Firestore database.
Future<void> registerNewUserStudent(String _email, String _password, String _fName, String _lName) async {
    FirebaseFirestore.instance.collection('testUsers').add({
      'email': _email,
      'password': _password,
      'user_type': 'student',
      'first_name': _fName,
      'last_name': _lName});
}