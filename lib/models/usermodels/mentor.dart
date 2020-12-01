import 'package:flutter/material.dart';
import 'package:prephq_connect/common/databasecalls.dart';
import 'timeslots.dart';
import 'package:prephq_connect/models/usermodels/user.dart' as theUser;
import 'user.dart';

class Mentor extends User {
  List<TimeSlots> days;

  @override
  getUser() async {
    Map<String, dynamic> userInfo = await getUserInfo(theUser.id);
    Map<String, dynamic> availability = userInfo['availability'];
    DateTime begin;
    DateTime end;

    name = userInfo['first_name'] + ' ' + userInfo['last_name'];
    userName = email;
    imageUrl = imageURL;

    if(availability.containsKey('m_begin')) {
      begin = DateTime.fromMillisecondsSinceEpoch(availability['m_begin']);
      end = DateTime.fromMillisecondsSinceEpoch(availability['m_end']);
      days.add(TimeSlots(
          "Monday", TimeOfDay.fromDateTime(begin), TimeOfDay.fromDateTime(end)));
    } else {
      days.add(TimeSlots(
          "Monday", TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)));
    }
    if(availability.containsKey('t_begin')) {
      begin = DateTime.fromMillisecondsSinceEpoch(availability['t_begin']);
      end = DateTime.fromMillisecondsSinceEpoch(availability['t_end']);
      days.add(TimeSlots(
          "Tuesday", TimeOfDay.fromDateTime(begin), TimeOfDay.fromDateTime(end)));
    } else {
      days.add(TimeSlots(
          "Tuesday", TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)));
    }
    if(availability.containsKey('w_begin')) {
      begin = DateTime.fromMillisecondsSinceEpoch(availability['w_begin']);
      end = DateTime.fromMillisecondsSinceEpoch(availability['w_end']);
      days.add(TimeSlots(
          "Wednesday", TimeOfDay.fromDateTime(begin), TimeOfDay.fromDateTime(end)));
    } else {
      days.add(TimeSlots(
          "Wednesday", TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)));
    }
    if(availability.containsKey('r_begin')) {
      begin = DateTime.fromMillisecondsSinceEpoch(availability['r_begin']);
      end = DateTime.fromMillisecondsSinceEpoch(availability['r_end']);
      days.add(TimeSlots(
          "Thursday", TimeOfDay.fromDateTime(begin), TimeOfDay.fromDateTime(end)));
    } else {
      days.add(TimeSlots(
          "Thursday", TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)));
    }
    if(availability.containsKey('f_begin')) {
      begin = DateTime.fromMillisecondsSinceEpoch(availability['f_begin']);
      end = DateTime.fromMillisecondsSinceEpoch(availability['f_end']);
      days.add(TimeSlots(
          "Friday", TimeOfDay.fromDateTime(begin), TimeOfDay.fromDateTime(end)));
    } else {
      days.add(TimeSlots(
          "Friday", TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)));
    }
    if(availability.containsKey('sa_begin')) {
      begin = DateTime.fromMillisecondsSinceEpoch(availability['sa_begin']);
      end = DateTime.fromMillisecondsSinceEpoch(availability['sa_end']);
      days.add(TimeSlots(
          "Saturday", TimeOfDay.fromDateTime(begin), TimeOfDay.fromDateTime(end)));
    } else {
      days.add(TimeSlots(
          "Saturday", TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)));
    }
    if(availability.containsKey('su_begin')) {
      begin = DateTime.fromMillisecondsSinceEpoch(availability['su_begin']);
      end = DateTime.fromMillisecondsSinceEpoch(availability['su_end']);
      days.add(TimeSlots(
          "Sunday", TimeOfDay.fromDateTime(begin), TimeOfDay.fromDateTime(end)));
    } else {
      days.add(TimeSlots(
          "Sunday", TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)));
    }
    return this;
  }

  @override
  String toString() {
    return "${UserTypes.Mentor}";
  }

  @override
  doneUpdating() {

  }

  @override
  setName(String name) {
    this.name = name;
  }
}


