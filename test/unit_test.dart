import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prephq_connect/models/roadmap.dart';
import 'package:prephq_connect/models/usermodels/mentor.dart';
import 'package:prephq_connect/models/usermodels/student.dart';
import 'package:prephq_connect/views/student/bookappointment.dart';

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

  testWidgets('Create correct list of time slots using getTimes function',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            var times = getTimes(
                    DateTime(2020, 12, 3, 11),
                    DateTime(2020, 12, 3, 13),
                    DateTime(2020, 12, 3),
                    Duration(minutes: 30))
                .toList();

            expect(times, [
              DateTime(2020, 12, 3, 11),
              DateTime(2020, 12, 3, 11, 30),
              DateTime(2020, 12, 3, 12),
              DateTime(2020, 12, 3, 12, 30),
            ]);

            times = getTimes(
                DateTime(2020, 12, 3, 11, 43),
                DateTime(2020, 12, 3, 12),
                DateTime(2020, 12, 3),
                Duration(minutes: 5))
                .toList();

            expect(times, [
              DateTime(2020, 12, 3, 11, 43),
              DateTime(2020, 12, 3, 11, 48),
              DateTime(2020, 12, 3, 11, 53),
              DateTime(2020, 12, 3, 11, 58),
            ]);

            return Container();
          },
        ),
      ),
    );
  });
}
