import 'package:flutter/material.dart';
import 'package:prephq_connect/common/databasecalls.dart';
import 'package:prephq_connect/models/usermodels/timeslots.dart';
import 'package:prephq_connect/models/usermodels/user.dart' as theUser;
import 'package:rflutter_alert/rflutter_alert.dart';

List<DateTime> alreadyTakenTimes = [];
Map<String, dynamic> mentorAvail = {};

/// Takes DateTime of an appointment slot and returns if it is already reserved.
bool isAppointmentAvailable(DateTime apptTime) {
  bool available = true;
  alreadyTakenTimes.forEach((element) {
    if (element.isBefore(DateTime.now()) || element.isAtSameMomentAs(apptTime))
      available = false;
  });
  return available;
}

//Send in start of availability, end of availability, and appointment duration for an iterable of appointment times
//MODIFIED FROM CREDITED FUNCTION
//Credit for this function: https://stackoverflow.com/questions/60370798/how-to-create-30-minutes-time-slots-in-flutter-dart
Iterable<DateTime> getTimes(
    DateTime startTime, DateTime endTime, DateTime theDay, Duration step) sync* {
  var hour = startTime.hour;
  var minute = startTime.minute;

  while ((hour < endTime.hour ||
      (hour == endTime.hour && minute < endTime.minute))){
    yield DateTime(theDay.year, theDay.month, theDay.day, hour, minute);
    minute += step.inMinutes;
    while (minute >= 60) {
      minute -= 60;
      hour++;
    }
  }
}

ListView getDailyAppointmentListView(BuildContext context, DateTime thatDate) {
  List<TimeSlots> availability = makeApptAvailList(mentorAvail);
  List<DateTime> times = [];

  if (availability.length > 0) {
      /* availability is 0-based-index list in-order starting with Monday.
      * thatDate.weekday gives day of the week as int in-order from Monday but
      * starts at 1   */
      DateTime startTime = DateTime(thatDate.year, thatDate.month, thatDate.day,
          availability[(thatDate.weekday - 1)].from.hour,
          availability[(thatDate.weekday - 1)].from.minute);
      DateTime endTime = DateTime(thatDate.year, thatDate.month, thatDate.day,
          availability[(thatDate.weekday - 1)].to.hour,
          availability[(thatDate.weekday - 1)].to.minute);
      final step = Duration(minutes: 30);

      times = getTimes(startTime, endTime, thatDate, step).toList();
  }
  if (times.length == 0){
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index){
        return Card(
          child: ListTile(
            title: Center(
              child: Text(
                "No appointments available.",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
           ),
          )
        );
      }
    );
  } else {
    return ListView.builder(
      itemCount: times.length,
      itemBuilder: (context, index) {
        Color status = Colors.redAccent;
        bool isAvail = isAppointmentAvailable(times[index]);
        if (isAvail) {
          status = Color.fromRGBO(75, 209, 160, 1);
        }
        return Card(
          child: InkWell(
            splashColor: Color.fromRGBO(75, 209, 160, 1).withAlpha(30),
            onTap: () {
              if (isAvail) {
                Alert(
                  context: context,
                  type: AlertType.success,
                  style: AlertStyle(
                    animationType: AnimationType.grow,
                  ),
                  title: 'Confirm this appointment:',
                  desc: getTime(times[index]) + ", " + getDate(times[index]),
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      width: 120,
                      color: Colors.red,
                    ),
                    DialogButton(
                      child: Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () async {
                        await reserveAppointment(theUser.id, mentorID, times[index]);
                        alreadyTakenTimes.add(times[index]);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      width: 120,
                    ),
                  ],
                ).show();
              }
              else {
                Alert(
                  context: context,
                  type: AlertType.error,
                  style: AlertStyle(
                    animationType: AnimationType.grow,
                  ),
                  title: 'This appointment is taken.',
                  desc: 'Sorry!',
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Okay",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      width: 120,
                      color: Colors.red,
                    ),
                  ],
                ).show();
              }
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: status,
                maxRadius: 20,
              ),
              title: Text(
                getDate(times[index]),
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
              trailing: Text(
                getTime(times[index]),
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

GridView getWeeklyGridView(BuildContext context) {
  Card weekdayCard(DateTime thatDate, Color color) {
    String weekday = getWeekday(thatDate.weekday);
    return Card(
      color: color,
      child: InkWell(
        splashColor: Colors.white.withAlpha(100),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DailyAppointmentViewPage(thatDate)),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 15.0),
                Text(
                  weekday,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                    getMonth(thatDate.month) + " " +
                    thatDate.day.toString() + ", " +
                    thatDate.year.toString(),
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
              ]
            ),
          )
        ),
      ),
    );
  }

  return GridView.count(
    primary: false,
    padding: EdgeInsets.all(10),
    crossAxisCount: 2,
    children: <Widget>[
      weekdayCard(DateTime.now(), Colors.teal[300]),
      weekdayCard(DateTime.now().add(new Duration(days: 1)), Colors.teal[400]),
      weekdayCard(DateTime.now().add(new Duration(days: 2)), Colors.teal[500]),
      weekdayCard(DateTime.now().add(new Duration(days: 3)), Colors.teal[600]),
      weekdayCard(DateTime.now().add(new Duration(days: 4)), Colors.teal[700]),
      weekdayCard(DateTime.now().add(new Duration(days: 5)), Colors.teal[800]),
      weekdayCard(DateTime.now().add(new Duration(days: 6)), Colors.teal[900]),
    ],
  );
}

class DailyAppointmentViewPage extends StatefulWidget {
  DailyAppointmentViewPage(this.thatDate);
  final DateTime thatDate;

  @override
  _DailyAppointmentViewPageState createState() =>
      _DailyAppointmentViewPageState();
}

class _DailyAppointmentViewPageState extends State<DailyAppointmentViewPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: getDailyAppointmentListView(context, widget.thatDate)),
    );
  }
}

class WeeklyGridPage extends StatefulWidget {
  @override
  _WeeklyGridPageState createState() => _WeeklyGridPageState();
}

class _WeeklyGridPageState extends State<WeeklyGridPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: getWeeklyGridView(context)),
    );
  }
}

String getWeekday(int value){
  switch(value){
    case 1: {return 'Monday';}
    case 2: {return 'Tuesday';}
    case 3: {return 'Wednesday';}
    case 4: {return 'Thursday';}
    case 5: {return 'Friday';}
    case 6: {return 'Saturday';}
    case 7: {return 'Sunday';}
    default: {return 'ERROR';}
  }
}

String getMonth(int value){
  switch(value){
    case 1: {return 'January';}
    case 2: {return 'February';}
    case 3: {return 'March';}
    case 4: {return 'April';}
    case 5: {return 'May';}
    case 6: {return 'June';}
    case 7: {return 'July';}
    case 8: {return 'August';}
    case 9: {return 'September';}
    case 10: {return 'October';}
    case 11: {return 'November';}
    case 12: {return 'December';}
    default: {return 'ERROR';}
  }
}

/// Returns time in format of [2:30 PM]
String getTime(DateTime date){
  int hour = date.hour;
  int minute = date.minute;
  String sMinute = "";
  String suffix = "AM";

  if (hour >= 12){
    suffix = "PM";
    if (hour > 12) {hour -= 12;}
  }else if (hour == 0){hour += 12;}

  if (minute >= 10) {sMinute = minute.toString();}
  else{sMinute = "0" + minute.toString();}

  return hour.toString() + ":" + sMinute + " " + suffix;
}

/// Returns date in format of [November 23, 1997]
String getDate(DateTime date){
  return
      getMonth(date.month) + " " +
      date.day.toString() + ", " +
      date.year.toString();
}