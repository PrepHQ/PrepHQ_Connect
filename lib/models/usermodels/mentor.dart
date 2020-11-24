import 'package:prephq_connect/common/databasecalls.dart';
import 'timeslots.dart';
import 'package:prephq_connect/models/usermodels/user.dart' as theUser;
import 'user.dart';

class Mentor extends User {
  List<TimeSlots> days;

  @override
  getUser() async {
    Map<String, dynamic> userInfo = await getUserInfo(theUser.id);

    name = userInfo['first_name'] + ' ' + userInfo['last_name'];
    userName = email;
    imageUrl = imageURL;
    days = [
      // TODO: populate these from database
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
    this.name = name;
  }
}


