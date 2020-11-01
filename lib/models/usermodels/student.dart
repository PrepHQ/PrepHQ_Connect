import 'package:prephq_connect/models/usermodels/student_test.dart';

import 'user.dart';

class Student extends User {
  List<StudentTests> tests = [];

  @override
  User getUser() {
    name = "Caleb Werth";
    userName = "cwerth@crimson.ua.edu";
    imageUrl =
        "https://upload.wikimedia.org/wikipedia/commons/f/fb/PrepCaleb.jpg";
    tests = [
      StudentTests(title: 'ACT Scores', score: 35, type: StudentTestsType.Main),
      StudentTests(title: 'English', score: 35),
      StudentTests(title: 'Math', score: 34),
      StudentTests(title: 'Reading', score: 34),
      StudentTests(title: 'Science', score: 36),
      StudentTests(title: 'Writing', score: 35),
      StudentTests(title: 'SAT Scores', score: 1750 ,type: StudentTestsType.Main),
      StudentTests(title: 'Reading', score: 600),
      StudentTests(title: 'Science', score: 550),
      StudentTests(title: 'Writing', score: 600),
    ];

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