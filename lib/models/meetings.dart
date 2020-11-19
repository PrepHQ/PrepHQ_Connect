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
      String timeStart = "11-27-2020 13:27:00",
      String timeEnd = "11-27-2020 13:27:00",
      String date = "11-27-2020",
      this.description = "",
      this.subDescription = ""}) {
    DateFormat dateFormat = DateFormat("MM-dd-yyyy HH:mm:ss");
    this.date = dateFormat.parse(date);
    this.timeEnd = dateFormat.parse(timeEnd);
    this.timeStart = dateFormat.parse(timeStart);
  }
  
  
  static List<MentorMeeting> meetings = [
  MentorMeeting(
      title: 'Meeting with Caleb ',
      timeStart: '11-28-2020 14:00:00',
      date: '11-28-2020 14:00:00',
      timeEnd: '11-28-2020 14:30:00',
      description: 'Meeting with Caleb on November 28th at 2:00PM',
      subDescription:
          "Meeting to discuss College Roadmap"),
  MentorMeeting(
      title: 'Meeting with Steven ',
      timeStart: '11-29-2020 13:30:00',
      date: '11-29-2020 13:30:00',
      timeEnd: '11-29-2020 14:00:00',
      description: 'Meeting with Steven on November 29th at 1:30PM',
      subDescription:
          "Meeting to discuss College Roadmap"),
  MentorMeeting(
      title: 'Meeting with Sarah ',
      timeStart: '12-01-2020 12:30:00',
      date: '12-01-2020 12:30:00',
      timeEnd: '12-01-2020 13:00:00',
      description: 'Meeting with Sarah on December 1st at 12:00PM',
      subDescription:
          "Meeting to discuss College Roadmap"),
  MentorMeeting(
      title: 'Meeting with Garrett ',
      timeStart: '11-30-2020 13:30:00',
      date: '11-30-2020 13:30:00',
      timeEnd: '11-30-2020 14:30:00',
      description: 'Meeting with Garrett on November 30th at 1:00PM',
      subDescription:
          "Meeting to discuss College Roadmap")
];

  
}


