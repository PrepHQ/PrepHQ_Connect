import 'package:flutter_test/flutter_test.dart';
import 'package:prephq_connect/models/roadmap.dart';
import 'package:prephq_connect/models/usermodels/mentor.dart';
import 'package:prephq_connect/models/usermodels/student.dart';

void main() {
  test('isCompleted should be marked true when complete is called', () {
    final roadMap = RoadMap(isCompleted: false);
    roadMap.complete();
    expect(roadMap.isCompleted, true);
  });

  test('Setting name of student works', () {
    final student = Student();
    expect(student.name, "");
    student.setName("Sarah Oswald");
    expect(student.name, "Sarah Oswald");
  });

  test('Setting name of mentor works', () {
    final mentor = Mentor();
    expect(mentor.name, "");
    mentor.setName("Steven Alexander");
    expect(mentor.name, "Steven Alexander");
  });
}