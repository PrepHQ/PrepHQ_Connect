import 'package:cloud_firestore/cloud_firestore.dart';

/// Returns the type of user, which is found in the [user_type] field on the database.
Future<String> getUserType(String userID) async {
  String answer;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .get()
      .then((DocumentSnapshot dSnap) {
        var tempData = dSnap.data();
        answer = tempData['user_type'];
  });
  return answer;
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