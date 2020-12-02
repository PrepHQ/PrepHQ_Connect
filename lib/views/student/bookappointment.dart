import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

/*FIXME: This is a global variable to represent a list of already taken times.
  Also add today's past appointments to alreadyTakenTimes
 */
List<DateTime> alreadyTakenTimes = [];

//Very simple, checks to see if "time" is in "takenTimes", and gives you a red or green color back
Color getAppointmentStatusColor(String time, List<DateTime> takenTimes) {
  if (takenTimes.contains(time)) {  // TODO change this
    return Colors.redAccent;
  }
  return Color.fromRGBO(75, 209, 160, 1);
}

//Send in start of availability, end of availability, and appointment duration for an iterable of appointment times
//MODIFIED FROM CREDITED FUNCTION
//Credit for this function: https://stackoverflow.com/questions/60370798/how-to-create-30-minutes-time-slots-in-flutter-dart
Iterable<DateTime> getTimes(
    DateTime startTime, DateTime endTime, DateTime theDay, Duration step) sync* {
  var hour = startTime.hour;
  var minute = startTime.minute;

  do {
    yield DateTime(theDay.year, theDay.month, theDay.day, hour, minute);
    minute += step.inMinutes;
    while (minute >= 60) {
      minute -= 60;
      hour++;
    }
  } while (hour < endTime.hour ||
      (hour == endTime.hour && minute <= endTime.minute));
}

ListView getDailyAppointmentListView(BuildContext context, DateTime currentTime) {

  //Hardcoded example start/end/duration values
  startTime = TimeOfDay(hour: 9, minute: 0); // TODO DateTime
  final endTime = TimeOfDay(hour: 19, minute: 0); // TODO DateTime
  final step = Duration(minutes: 30);

  //Boilerplate code to convert to a list of strings
  final times = getTimes(startTime, endTime, theDay, step).toList();

  return ListView.builder(
    itemCount: times.length,
    itemBuilder: (context, index) {
      return Card(
        child: InkWell(
          splashColor: Color.fromRGBO(75, 209, 160, 1).withAlpha(30),
          onTap: () {
            if(!alreadyTakenTimes.contains(times[index])) { // TODO if DateTime found in alreadyTakenTimes
              Alert(
                context: context,
                type: AlertType.success,
                style: AlertStyle(
                    animationType: AnimationType.grow,
                ),
                title: 'Confirm this appointment:',
                desc: '9:30 AM, November 17th, 2020', // TODO format from DateTime
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
                    onPressed: () => /*TODO save appt to database*/ Navigator.pop(context),
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
              // backgroundColor:
              //     getAppointmentStatusColor(times[index], alreadyTakenTimes), // TODO change times[index]
              maxRadius: 20,
            ),
            title: Text(
              'November 17th, 2020',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
            trailing: Text(
              '${times[index]}',
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

GridView getWeeklyGridView(BuildContext context) {


  Card weekdayCard(DateTime date, Color color) {
    String weekday = getWeekday(date.weekday);
    return Card(
      color: color,
      child: InkWell(
        splashColor: Colors.white.withAlpha(100),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DailyAppointmentViewPage(date)),
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
                  getMonth(date.month) + " " + date.day.toString() + ", " + date.year.toString(),
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
  DailyAppointmentViewPage(this.date);
  final DateTime date;

  @override
  _DailyAppointmentViewPageState createState() =>
      _DailyAppointmentViewPageState();
}

class _DailyAppointmentViewPageState extends State<DailyAppointmentViewPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: getDailyAppointmentListView(context, widget.date)),
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