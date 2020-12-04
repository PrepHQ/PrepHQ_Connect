import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prephq_connect/models/roadmap.dart';
import 'package:prephq_connect/models/usermodels/mentor.dart';
import 'package:prephq_connect/models/usermodels/student.dart';
import 'package:prephq_connect/models/usermodels/timeslots.dart';
import 'package:prephq_connect/views/student/bookappointment.dart';

void main() {
  test('isCompleted should be marked true when complete is called', () {
    final roadMap = RoadMap(isCompleted: false);
    roadMap.complete();
    expect(roadMap.isCompleted, true);
  });

  test('Setting name of student works', () {
    final student = Student();
    expect(student.name, '');
    student.setName('Sarah Oswald');
    expect(student.name, 'Sarah Oswald');
  });

  test('Setting name of mentor works', () {
    final mentor = Mentor();
    expect(mentor.name, '');
    mentor.setName('Steven Alexander');
    expect(mentor.name, 'Steven Alexander');
  });

  test(
    'Create correct list of time slots using getTimes function',
    () {
      var times = getTimes(DateTime(2020, 12, 3, 11), DateTime(2020, 12, 3, 13),
              DateTime(2020, 12, 3), Duration(minutes: 30))
          .toList();

      expect(times, [
        DateTime(2020, 12, 3, 11),
        DateTime(2020, 12, 3, 11, 30),
        DateTime(2020, 12, 3, 12),
        DateTime(2020, 12, 3, 12, 30),
      ]);

      times = getTimes(DateTime(2020, 12, 3, 11, 43), DateTime(2020, 12, 3, 12),
              DateTime(2020, 12, 3), Duration(minutes: 5))
          .toList();

      expect(times, [
        DateTime(2020, 12, 3, 11, 43),
        DateTime(2020, 12, 3, 11, 48),
        DateTime(2020, 12, 3, 11, 53),
        DateTime(2020, 12, 3, 11, 58),
      ]);
    },
  );

  test('Validate getTime behavior', () {
    var time = getTime(DateTime(2020));
    expect(time, '12:00 AM');
    time = getTime(DateTime(2020, 12, 3, 8, 37));
    expect(time, '8:37 AM');
    time = getTime(DateTime(2020, 12, 3, 16, 37));
    expect(time, '4:37 PM');
  });

  test('Validate getDate behavior', () {
    var date = getDate(DateTime(2020));
    expect(date, 'January 1, 2020');
    date = getDate(DateTime(2020, 12, 3));
    expect(date, 'December 3, 2020');
  });

  test('Validate makeApptAvailList behavior', (){
    Map<String, dynamic> availability = {};
    List<TimeSlots> theList = makeApptAvailList(availability);
    //Test producing empty list
    expect(theList, []);
     Map<String, dynamic> availability2 = {'m_begin': Timestamp(50000, 0), 'm_end': Timestamp(50001, 0)};
     List<TimeSlots> theList2 = makeApptAvailList(availability2);

     //Test correct sequencing of days given timestamp input
     expect(theList2[0].day, 'Monday');
     expect(theList2[1].day, 'Tuesday');
     expect(theList2[2].day, 'Wednesday');
     expect(theList2[3].day, 'Thursday');
     expect(theList2[4].day, 'Friday');
     expect(theList2[5].day, 'Saturday');
     expect(theList2[6].day, 'Sunday');
  });
}
