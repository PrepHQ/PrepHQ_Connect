import 'package:prephq_connect/common/databasecalls.dart';
import 'package:prephq_connect/models/usermodels/student_test.dart';
import 'package:prephq_connect/models/usermodels/user.dart' as theUser;

import 'user.dart';

class Student extends User {
  List<StudentTests> tests = [];

  @override
  Future<User> getUser() async {
    Map<String, dynamic> userInfo = await getUserInfo(theUser.id);

    name = userInfo['first_name'] + ' ' + userInfo['last_name'];
    userName = theUser.email;
    imageUrl = theUser.imageURL;
    if(userInfo.containsKey('act_overall')) {
      tests.addAll([
          StudentTests(title: 'ACT Scores', score: userInfo['act_overall'], type: StudentTestsType.Main),
          StudentTests(title: 'English', score: userInfo['act_english']),
          StudentTests(title: 'Math', score: userInfo['act_math']),
          StudentTests(title: 'Reading', score: userInfo['act_reading']),
          StudentTests(title: 'Science', score: userInfo['act_science']),
          StudentTests(title: 'Writing', score: userInfo['act_writing'])
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
    if(userInfo.containsKey('sat_overall')) {
      tests.addAll([
        StudentTests(title: 'SAT Scores', score: userInfo['sat_overall'], type: StudentTestsType.Main),
        StudentTests(title: 'Reading', score: userInfo['sat_reading']),
        StudentTests(title: 'Science', score: userInfo['sat_science']),
        StudentTests(title: 'Writing', score: userInfo['sat_writing'])
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