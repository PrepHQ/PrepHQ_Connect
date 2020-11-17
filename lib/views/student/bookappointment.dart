import 'package:flutter/material.dart';

/*FIXME: This is a global variable to represent a list of already taken times.
  Will want to replace with database call
 */
List<String> alreadyTakenTimes = ['10:00 AM', '1:00 PM'];

//Very simple, checks to see if "time" is in "takenTimes", and gives you a red or green color back
Color getAppointmentStatusColor(String time, List takenTimes) {
  if (takenTimes.contains(time)) {
    return Colors.redAccent;
  }
  return Color.fromRGBO(75, 209, 160, 1);
}

//Send in start of availability, end of availability, and appointment duration for an interable of appointment times
//Credit for this function: https://stackoverflow.com/questions/60370798/how-to-create-30-minutes-time-slots-in-flutter-dart
Iterable<TimeOfDay> getTimes(
    TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
  var hour = startTime.hour;
  var minute = startTime.minute;

  do {
    yield TimeOfDay(hour: hour, minute: minute);
    minute += step.inMinutes;
    while (minute >= 60) {
      minute -= 60;
      hour++;
    }
  } while (hour < endTime.hour ||
      (hour == endTime.hour && minute <= endTime.minute));
}

ListView getDailyAppointmentListView(BuildContext context) {
  //Hardcoded example start/end/duration values
  final startTime = TimeOfDay(hour: 9, minute: 0);
  final endTime = TimeOfDay(hour: 19, minute: 0);
  final step = Duration(minutes: 30);

  //Boilerplate code to convert to a list of strings
  final times = getTimes(startTime, endTime, step)
      .map((tod) => tod.format(context))
      .toList();

  return ListView.builder(
    itemCount: times.length,
    itemBuilder: (context, index) {
      return Card(
        child: InkWell(
          splashColor: Color.fromRGBO(75, 209, 160, 1).withAlpha(30),
          onTap: () => print('You clicked ${times[index]}'),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  getAppointmentStatusColor(times[index], alreadyTakenTimes),
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

class AppointmentListPage extends StatefulWidget {
  @override
  _AppointmentListPageState createState() => _AppointmentListPageState();
}

class _AppointmentListPageState extends State<AppointmentListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: getDailyAppointmentListView(context)),
    );
  }
}
