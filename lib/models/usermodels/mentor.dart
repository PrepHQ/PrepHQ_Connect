import 'timeslots.dart';
import 'user.dart';

class Mentor extends User {
  List<TimeSlots> dates;

  @override
  getUser() {
    name = "Jeff Gray";
    userName = "gray@cs.ua.edu";
    imageUrl =
        "https://upload.wikimedia.org/wikipedia/commons/e/ec/PrepGray.jpg";
    dates = [
      TimeSlots("Monday" , "10.00", "1.00"),
      TimeSlots("Tuesday" , "10.00", "4.00"),
      TimeSlots("Wednesday" , "10.00", "4.00"),
      TimeSlots("Thursday" , "10.00", "4.00"),
      TimeSlots("Friday" , "10.00", "3.00"),
      TimeSlots("Saturday" , "1.00", "1.45"),
      TimeSlots("Sunday" , "1.00", "4.00"),
    ];

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
    
  }
}


