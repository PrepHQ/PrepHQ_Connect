import 'package:flutter/cupertino.dart';
import 'package:prephq_connect/models/meetings.dart';

class MentorMeetingNotifier with ChangeNotifier{

  List<MentorMeeting> meetings = MentorMeeting.meetings;

  void initi() {
    MentorMeeting.initial();
  }

  List<MentorMeeting> getAllMeetings() {
    return meetings;
  }

  List<MentorMeeting> getUpcomingMeetings() {
    DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    return meetings.where((m) {
      return m.date.isAfter(today.add(Duration(days: 1)));
    }).toList();
  }

  List<MentorMeeting> getTodayMeetings() {
     print(meetings[0].date);
     
    
    return meetings.where((m) {
      return  DateOnlyCompare(m.date).isSameDate(DateTime.now());///m.date == DateTime.now();
    }).toList();
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year && this.month == other.month
           && this.day == other.day;
  }
}

