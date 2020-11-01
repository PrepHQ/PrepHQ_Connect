import 'package:flutter/cupertino.dart';

enum StudentTestsType { Main, Sub }

class StudentTests {
  final String title;
  double score;
  StudentTestsType type;

  StudentTests(
      {@required this.title, this.score = 0, this.type = StudentTestsType.Sub});
}
