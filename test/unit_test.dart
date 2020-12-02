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

  testWidgets('Create correct list of time slots using getTimes function', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            var times = getTimes(
              TimeOfDay(hour: 11, minute: 0),
              TimeOfDay(hour: 13, minute: 0),
              Duration(minutes: 30),
            ).map((tod) => tod.format(context)).toList();

            expect(times,
                ['11:00 AM', '11:30 AM', '12:00 PM', '12:30 PM', '1:00 PM']);

            times = getTimes(
              TimeOfDay(hour: 12, minute: 0),
              TimeOfDay(hour: 12, minute: 0),
              Duration(minutes: 30),
            ).map((tod) => tod.format(context)).toList();

            expect(times, ['12:00 PM']);

            times = getTimes(
              TimeOfDay(hour: 15, minute: 3),
              TimeOfDay(hour: 16, minute: 0),
              Duration(minutes: 5),
            ).map((tod) => tod.format(context)).toList();

            expect(times, [
              '3:03 PM',
              '3:08 PM',
              '3:13 PM',
              '3:18 PM',
              '3:23 PM',
              '3:28 PM',
              '3:33 PM',
              '3:38 PM',
              '3:43 PM',
              '3:48 PM',
              '3:53 PM',
              '3:58 PM'
            ]);

            return Container();
          },
        ),
      ),
    );
  });
}
