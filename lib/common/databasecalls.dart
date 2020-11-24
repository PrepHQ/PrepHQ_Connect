import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prephq_connect/models/usermodels/student_test.dart';
import 'package:prephq_connect/models/usermodels/user.dart' as theUser;

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
Future<void> registerNewUserStudent(String _id, String _fName, String _lName) async {
  await FirebaseFirestore.instance.collection('users')
      .doc(_id)
      .set({
    'user_type': 'student',
    'first_name': _fName,
    'last_name': _lName});
}

/// Gets all mentors from the database.
Future<List<QueryDocumentSnapshot>> getAllMentors() async {
  QuerySnapshot mentors = await FirebaseFirestore.instance
      .collection('users')
      .where('user_type', isEqualTo: 'mentor')
      .get();
  return mentors.docs;
}

/// Gets all profile information for a student.
Future<Map<String, dynamic>> getStudentInfo(String userID) async {
  var answer;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .get()
      .then((DocumentSnapshot dSnap) {
    answer = dSnap.data();
  });
  return answer;
}

/// Updates student's test scores in the database.
Future<void> updateStudentTests(String userID, List<StudentTests> theTests) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .update({
        'act_overall': theTests[0].score,
        'act_english': theTests[1].score,
        'act_math': theTests[2].score,
        'act_reading': theTests[3].score,
        'act_science': theTests[4].score,
        'act_writing': theTests[5].score,
        'sat_overall': theTests[6].score,
        'sat_reading': theTests[7].score,
        'sat_science': theTests[8].score,
        'sat_writing': theTests[9].score
  });
}

/// Gets user's profile image from the database.
Future<void> setUserImageURL(String userID) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .get()
      .then((DocumentSnapshot dSnap) {
    var tempData = dSnap.data();
    if (tempData.containsKey('profile_image_url')) {
      theUser.imageURL = tempData['profile_image_url'];
    }
  });
}