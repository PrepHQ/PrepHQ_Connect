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
      String timeStart = "2020-02-27 13:27:00",
      String timeEnd = "2020-02-28 13:27:00",
      String date = "2020-02-27",
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
      timeStart: '2021-02-27 13:27:00',
      date: '2020-11-18 13:27:00',
      timeEnd: '2020-02-28 13:27:00',
      description: 'Meeting with Sarah on November 30th at 1:00PM',
      subDescription:
          "Our team members names are Sarah, Caleb, Steven and Garrett"),
  MentorMeeting(
      title: 'Meeting with Caleb ',
      timeStart: '2021-02-27 13:27:00',
      date: '2021-02-27 13:27:00',
      timeEnd: '2021-02-28 13:27:00',
      description: 'Meeting with Sarah on November 30th at 1:00PM',
      subDescription:
          "Our team members names are Sarah, Caleb, Steven and Garrett"),
  MentorMeeting(
      title: 'Meeting with Steven ',
      timeStart: '2021-02-27 13:27:00',
      date: '2021-02-27 13:27:00',
      timeEnd: '2020-02-28 13:27:00',
      description: 'Meeting with Sarah on November 30th at 1:00PM',
      subDescription:
          "Our team members names are Sarah, Caleb, Steven and Garrett"),
  MentorMeeting(
      title: 'Meeting with Sarah ',
      timeStart: '2021-02-27 13:27:00',
      date: '2021-02-27 13:27:00',
      timeEnd: '2020-02-28 13:27:00',
      description: 'Meeting with Sarah on November 30th at 1:00PM',
      subDescription:
          "Our team members names are Sarah, Caleb, Steven and Garrett"),
  MentorMeeting(
      title: 'Meeting with Garrett ',
      timeStart: '2021-02-27 13:27:00',
      date: '2021-02-27 13:27:00',
      timeEnd: '2020-02-28 13:27:00',
      description: 'Meeting with Sarah on November 30th at 1:00PM',
      subDescription:
          "Our team members names are Sarah, Caleb, Steven and Garrett")
];

  
}


