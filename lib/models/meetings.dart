import 'package:intl/intl.dart';

class MentorMeeting {
  String title;
  DateTime timeStart;
  DateTime timeEnd;
  DateTime date;
  String description;
  String subDescription;

  MentorMeeting(
      {this.title = "",
      String timeStart = "2020-11-27 13:00:00",
      String timeEnd = "2020-11-27 13:30:00",
      String date = "2020-11-27",
      this.description = "",
      this.subDescription = ""}) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    this.date = dateFormat.parse(date);
    this.timeEnd = dateFormat.parse(timeEnd);
    this.timeStart = dateFormat.parse(timeStart);
  }
  
  
  static List<MentorMeeting> meetings = [
  MentorMeeting(
      title: 'Meeting with Sarah ',
      timeStart: '2020-11-27 13:00:00',
      date: '2020-11-19 13:27:00',
      timeEnd: '2020-11-27 13:30:00',
      description: 'Meeting with Sarah on November 27th at 1:00PM',
      subDescription:
          "Meeting to discuss the College Roadmap"),
  MentorMeeting(
      title: 'Meeting with Caleb ',
      timeStart: '2020-11-28 13:30:00',
      date: '2020-11-19 13:27:00',
      timeEnd: '2020-11-28 13:45:00',
      description: 'Meeting with Caleb on November 28th at 1:30PM',
      subDescription:
          "Meeting to discuss the College Roadmap"),
  MentorMeeting(
      title: 'Meeting with Steven ',
      timeStart: '2020-11-29 13:00:00',
      date: '2020-11-29 13:27:00',
      timeEnd: '2020-11-29 13:55:00',
      description: 'Meeting with Steven on November 29th at 1:00PM',
      subDescription:
          "Meeting to discuss the College Roadmap"),
  MentorMeeting(
      title: 'Meeting with Garrett ',
      timeStart: '2020-11-30 14:00:00',
      date: '2020-11-30 14:00:00',
      timeEnd: '2020-11-30 14:30:00',
      description: 'Meeting with Garrett on November 30th at 2:00PM',
      subDescription:
          "Meeting to discuss the College Roadmap"),
];

  
}


