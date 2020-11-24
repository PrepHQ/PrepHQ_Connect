import 'package:prephq_connect/common/databasecalls.dart';
import 'package:prephq_connect/models/usermodels/student_test.dart';
import 'package:prephq_connect/models/usermodels/user.dart' as theUser;

import 'user.dart';

class Student extends User {
  List<StudentTests> tests = [];

  @override
  Future<User> getUser() async {
    Map<String, dynamic> studentInfo = await getUserInfo(theUser.id);

    name = studentInfo['first_name'] + ' ' + studentInfo['last_name'];
    userName = theUser.email;
    imageUrl = theUser.imageURL;
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