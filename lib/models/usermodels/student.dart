import 'package:prephq_connect/common/databasecalls.dart';
import 'package:prephq_connect/models/usermodels/student_test.dart';
import 'package:prephq_connect/models/usermodels/user.dart' as theUser;

import 'user.dart';

class Student extends User {
  List<StudentTests> tests = [];

  @override
  Future<User> getUser() async {
    Map<String, dynamic> studentInfo = await getStudentInfo(theUser.id);

    name = studentInfo['first_name'] + ' ' + studentInfo['last_name'];
    userName = theUser.email;
    imageUrl = studentInfo.containsKey('profile_image_url') ?
      // If user has uploaded profile image, use it
      studentInfo['profile_image_url'] :
      // If user has not uploaded profile image, use default
      'https://firebasestorage.googleapis.com/v0/b/prephq-connect.appspot.com/o/profilePictures%2FnoPic.png?alt=media&token=0b5e58c4-9999-4245-b9b7-6438e23f3020';
    if(studentInfo.containsKey('act_overall')) {
      tests.addAll([
          StudentTests(title: 'ACT Scores', score: studentInfo['act_overall'], type: StudentTestsType.Main),
          StudentTests(title: 'English', score: studentInfo['act_english']),
          StudentTests(title: 'Math', score: studentInfo['act_math']),
          StudentTests(title: 'Reading', score: studentInfo['act_reading']),
          StudentTests(title: 'Science', score: studentInfo['act_science']),
          StudentTests(title: 'Writing', score: studentInfo['act_writing'])
      ]);
    } else {
      tests.addAll([
        StudentTests(title: 'ACT Scores', score: 0, type: StudentTestsType.Main),
        StudentTests(title: 'English', score: 0),
        StudentTests(title: 'Math', score: 0),
        StudentTests(title: 'Reading', score: 0),
        StudentTests(title: 'Science', score: 0),
        StudentTests(title: 'Writing', score: 0)
      ]);
    }
    if(studentInfo.containsKey('sat_overall')) {
      tests.addAll([
        StudentTests(title: 'SAT Scores', score: studentInfo['sat_overall'], type: StudentTestsType.Main),
        StudentTests(title: 'Reading', score: studentInfo['sat_reading']),
        StudentTests(title: 'Science', score: studentInfo['sat_science']),
        StudentTests(title: 'Writing', score: studentInfo['sat_writing'])
      ]);
    } else {
      tests.addAll([
        StudentTests(title: 'SAT Scores', score: 0, type: StudentTestsType.Main),
        StudentTests(title: 'Reading', score: 0),
        StudentTests(title: 'Science', score: 0),
        StudentTests(title: 'Writing', score: 0)
      ]);
    }
    return this;
  }

  @override
  void doneUpdating() {
    print(this.toString());
  }

  @override
  setName(String name) {
    this.name = name;
  }
}