import 'package:flutter/material.dart';
import 'package:prephq_connect/common/databasecalls.dart';
import 'timeslots.dart';
import 'package:prephq_connect/models/usermodels/user.dart' as theUser;
import 'user.dart';

class Mentor extends User {
  List<TimeSlots> days = [];

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
      begin = availability['m_begin'].toDate();
      end = availability['m_end'].toDate();
      days.add(TimeSlots(
          "Monday", TimeOfDay.fromDateTime(begin), TimeOfDay.fromDateTime(end)));
    } else {
      days.add(TimeSlots(
          "Monday", TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)));
    }
    if(availability.containsKey('t_begin')) {
      begin = availability['t_begin'].toDate();
      end = availability['t_end'].toDate();
      days.add(TimeSlots(
          "Tuesday", TimeOfDay.fromDateTime(begin), TimeOfDay.fromDateTime(end)));
    } else {
      days.add(TimeSlots(
          "Tuesday", TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)));
    }
    if(availability.containsKey('w_begin')) {
      begin = availability['w_begin'].toDate();
      end = availability['w_end'].toDate();
      days.add(TimeSlots(
          "Wednesday", TimeOfDay.fromDateTime(begin), TimeOfDay.fromDateTime(end)));
    } else {
      days.add(TimeSlots(
          "Wednesday", TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)));
    }
    if(availability.containsKey('r_begin')) {
      begin = availability['r_begin'].toDate();
      end = availability['r_end'].toDate();
      days.add(TimeSlots(
          "Thursday", TimeOfDay.fromDateTime(begin), TimeOfDay.fromDateTime(end)));
    } else {
      days.add(TimeSlots(
          "Thursday", TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)));
    }
    if(availability.containsKey('f_begin')) {
      begin = availability['f_begin'].toDate();
      end = availability['f_end'].toDate();
      days.add(TimeSlots(
          "Friday", TimeOfDay.fromDateTime(begin), TimeOfDay.fromDateTime(end)));
    } else {
      days.add(TimeSlots(
          "Friday", TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)));
    }
    if(availability.containsKey('sa_begin')) {
      begin = availability['sa_begin'].toDate();
      end = availability['sa_end'].toDate();
      days.add(TimeSlots(
          "Saturday", TimeOfDay.fromDateTime(begin), TimeOfDay.fromDateTime(end)));
    } else {
      days.add(TimeSlots(
          "Saturday", TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)));
    }
    if(availability.containsKey('su_begin')) {
      begin = availability['su_begin'].toDate();
      end = availability['su_end'].toDate();
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


