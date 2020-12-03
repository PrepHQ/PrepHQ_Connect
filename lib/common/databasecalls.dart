import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prephq_connect/models/usermodels/student_test.dart';
import 'package:prephq_connect/models/usermodels/timeslots.dart';
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
  await FirebaseFirestore.instance
      .collection('users')
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

/// Gets all profile information for a user.
Future<Map<String, dynamic>> getUserInfo(String userID) async {
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

/// Updates mentor's hours of availability for appointments in the database.
Future<void> updateMentorHours(String userID, List<TimeSlots> theTimes) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .update({
        'availability.m_begin': DateTime(1971, 1, 1, theTimes[0].from.hour, theTimes[0].from.minute),
        'availability.m_end': DateTime(1971 , 1, 1, theTimes[0].to.hour, theTimes[0].to.minute),
        'availability.t_begin': DateTime(1971, 1, 1, theTimes[1].from.hour, theTimes[1].from.minute),
        'availability.t_end': DateTime(1971 , 1, 1, theTimes[1].to.hour, theTimes[1].to.minute),
        'availability.w_begin': DateTime(1971, 1, 1, theTimes[2].from.hour, theTimes[2].from.minute),
        'availability.w_end': DateTime(1971 , 1, 1, theTimes[2].to.hour, theTimes[2].to.minute),
        'availability.r_begin': DateTime(1971, 1, 1, theTimes[3].from.hour, theTimes[3].from.minute),
        'availability.r_end': DateTime(1971 , 1, 1, theTimes[3].to.hour, theTimes[3].to.minute),
        'availability.f_begin': DateTime(1971, 1, 1, theTimes[4].from.hour, theTimes[4].from.minute),
        'availability.f_end': DateTime(1971 , 1, 1, theTimes[4].to.hour, theTimes[4].to.minute),
        'availability.sa_begin': DateTime(1971, 1, 1, theTimes[5].from.hour, theTimes[5].from.minute),
        'availability.sa_end': DateTime(1971 , 1, 1, theTimes[5].to.hour, theTimes[5].to.minute),
        'availability.su_begin': DateTime(1971, 1, 1, theTimes[6].from.hour, theTimes[6].from.minute),
        'availability.su_end': DateTime(1971 , 1, 1, theTimes[6].to.hour, theTimes[6].to.minute),
  });
}

/// Gets user's profile image from the database and sets a global variable.
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

/// Gets mentor's scheduled appointment times for today plus next 6 days.
Future<List<DateTime>> getMentorAppts(String userID) async {
  DateTime now = new DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime deadline = today.add(new Duration(days: 7));
  List<DateTime> appointments = [];
  await FirebaseFirestore.instance
      .collection('appointments')
      .where('mentor', isEqualTo: userID)
      .where('time', isLessThan: deadline)
      .orderBy('time', descending: false)
      .get()
      .then((QuerySnapshot qSnap) {
        qSnap.docs.forEach((appt) {
          appointments.add(appt['time'].toDate());
        });
  });
  return appointments;
}

/// Gets mentor's future scheduled appointments with details from the database.
Future<List<QueryDocumentSnapshot>> getMyAppts(String id) async {
  QuerySnapshot qSnap = await FirebaseFirestore.instance
      .collection('appointments')
      .where('mentor', isEqualTo: id)
      .get();
  return qSnap.docs;
}

/// Saves appointment reservation to the database.
Future<void> reserveAppointment(String studentID, String mentorID, DateTime appt) async {
  await FirebaseFirestore.instance
      .collection('appointments')
      .doc()
      .set({
        'student': studentID,
        'mentor': mentorID,
        'time': appt});
}