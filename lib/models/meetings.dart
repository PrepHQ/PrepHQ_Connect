import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:prephq_connect/common/databasecalls.dart';
import 'package:prephq_connect/views/student/bookappointment.dart';

class MentorMeeting {
  String title;
  DateTime timeStart;
  DateTime timeEnd;
  DateTime date;
  String stdntFName;
  String stdntLName;
  String description;
  String subDescription;
  static List<MentorMeeting> meetings = [];

  // import 'package:prephq_connect/models/usermodels/user.dart' as theUser;
  //
  // List<QueryDocumentSnapshot> temp = await getMyAppts(theUser.id);
  // MentorMeeting.meetings = makeMeetingList(temp);

  MentorMeeting(
      this.date,
      this.stdntFName,
      this.stdntLName,
      this.subDescription) {
      this.title = "Meeting with " + stdntFName;
      this.description = title + " on " + getDate(date) + " at " + getTime(date);
      this.timeStart = date;
      this.timeEnd = date.add(Duration(minutes: 30));
  }
}


List<MentorMeeting> makeMeetingList(List<QueryDocumentSnapshot> docs) {
  List<MentorMeeting> theList = [];
  docs.forEach((appt) async {
    Map<String, dynamic> studentInfo = await getUserInfo(appt['student']);
    theList.add(
        MentorMeeting(appt['time'].toDate(),
            studentInfo['first_name'],
            studentInfo['last_name'],
            appt['description'])
    );
  });
  return theList;
}